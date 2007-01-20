package Kwiki::Attachments;
use strict;
use warnings;
use Kwiki::Plugin '-Base';
use Kwiki::Installer '-base';
use File::Basename;
our $VERSION = '0.18';

const class_id => 'attachments';
const class_title => 'File Attachments';
const cgi_class => 'Kwiki::Attachments::CGI';
const config_file => 'attachments.yaml';
const css_file => 'attachments.css';

field 'display_msg';
field files => [];

sub register {
    my $registry = shift;
    $registry->add( action => 'attachments');
    $registry->add( action => 'attachments_upload');
    $registry->add( action => 'attachments_delete');
    $registry->add( toolbar => 'attachments_button', 
                    template => 'attachments_button.html',
                    show_for => ['display'],
                  );
    $registry->add( wafl => file => 'Kwiki::Attachments::Wafl');
    $registry->add( wafl => img =>  'Kwiki::Attachments::Wafl');
    $registry->add( wafl => thumb =>  'Kwiki::Attachments::Wafl');
    $registry->add( preload => 'attachments' );
    $registry->add(widget => 'attachments_widget', 
                   template => 'attachments_widget.html',
                   show_for => [ 'display', 'edit' ],
                  );
}

sub update_metadata {
   # Updates the modification time of the page.
   my $page = $self->pages->current;
   $page->metadata->update->store;
}

sub attachments {
    $self->get_attachments( $self->pages->current_id );
    $self->render_screen();
}

sub attachments_upload {
   my $page_id = $self->pages->current_id;
   my $skip_like = $self->config->attachments_skip;
   my $client_file = CGI::param('uploaded_file');
   my $file = basename($client_file);
   $file = (reverse split (/\\/, $file))[0];
   $file =~ tr/a-zA-Z0-9.&+-/_/cs;
   unless ($file){
       $self->display_msg("Please specify a file to upload.");
   }
   else {
      if ($file =~ /$skip_like/i) {
         $self->display_msg("The selected file, $client_file, 
                             was not uploaded because its name matches the 
                             pattern of file names excluded by this wiki.");
      }
      else {
         my $newfile = io->catfile($self->plugin_directory, $page_id, $file);
         local $/;
         my $fh = CGI::upload('uploaded_file');

         if ( $fh ) {
            binmode($fh);
            $newfile->assert->print(<$fh>);
            $newfile->close();
            $self->update_metadata();
            if ($self->config->make_thumbnails !~ /off/i) {
               $self->make_thumbnail($newfile);
            }
         } 
      }
   }
   $self->get_attachments( $page_id );
   $self->render_screen;
}

sub make_thumbnail {

   my $file = shift;
   my ($fname, $fpath, $ftype) = fileparse($file, qr(\..*$));
   my $thumb = io->catfile($fpath, "thumb_$fname$ftype");
   my $override = ($self->config->im_override =~ /on/i) ? 0 : 1;
   
   if (eval { require Imager } && !$override) {
      # Imager.pm naively (IMO) depends on (and believes) file
      # extensions in order to determine the file type. 
      my $supported = 0;
      $ftype = 'jpeg' if $ftype =~ /jpg/i; 
      for (keys %Imager::formats) {
         if ($ftype =~ /$_/i) {
            $supported = 1;
            last;
         }
      }
      if ($supported) {
         my $image = Imager->new;
         return unless ref($image);
         if ($image->read(file=>$file)) {
            my $thumb_img = $image->scale(xpixels=>80,ypixels=>80);
            $thumb_img->write(file=>$thumb);
         }
      }
   } elsif (eval { require Image::Magick }) {
      # Image::Magick does the right thing with image files regardless
      # of whether the file extension looks like ".jpg", ".png" etc.
      my $image = Image::Magick->new;
      return unless ref($image);
      if (!$image->Read($file)) {
         if (!$image->Scale(geometry=>'80x80')) {
            if (!$image->Contrast(sharpen=>"true")) {
               $image->Write($thumb);
            }
         }
      }
   }
   return;
}

sub attachments_delete {
    # Remove the attachment and thumbnail, if one exists
    my $page_id = $self->hub->