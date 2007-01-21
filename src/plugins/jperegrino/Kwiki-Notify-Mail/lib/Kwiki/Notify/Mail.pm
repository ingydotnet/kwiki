# $Header: /home/staff/peregrin/cvs/Kwiki-Notify-Mail/lib/Kwiki/Notify/Mail.pm,v 1.8 2005/11/11 23:04:17 peregrin Exp $
#
package Kwiki::Notify::Mail;
use warnings;
use strict;
use Kwiki::Plugin '-Base';
use mixin 'Kwiki::Installer';
use MIME::Lite;

our $VERSION = '0.04';

const class_id    => 'notify_mail';
const class_title => 'Kwiki page edit notification via email';
const config_file => 'notify_mail.yaml';

sub debug {
    my $debug = $self->hub->config->notify_mail_debug || 0;
    return $debug;
}

sub register {
    my $registry = shift;
    $registry->add(
        hook => 'page:store',
        post => 'notify',
    );
}

sub recipient_list {
    my $notify_mail_obj = $self->hub->load_class('notify_mail');
    my $mail_to         = $notify_mail_obj->config->notify_mail_to;
    my $topic           = $notify_mail_obj->config->notify_mail_topic;
    my $meta_data       = $self->hub->edit->pages->current->metadata;
    my $who             = $meta_data->{edit_by};
    my $page_name       = $meta_data->{id};
    my ( $cfg, $page, $email );

    return undef
        unless defined $mail_to && defined $who && defined $page_name;

    # Support for a notify_mail_topic configuration entry giving a page from
    # which notification info can be read.
    $cfg = $self->hub->pages->new_page($topic);
    if ( defined $cfg ) {
        foreach ( split( /\n/, $cfg->content ) ) {
            s/#.*//;
            next if /^\s*$/;
            unless ( ( $page, $email ) = /^([^:]+):\s*(.+)/ ) {
                print STDERR "Kwiki::Notify::Mail: Unrecognised line in ",
                    $topic, ": ", $_, "\n";
                next;
            }
            next unless $page_name =~ /^$page$/;
            $mail_to .= " " . $email;
        }
    }

    return $mail_to;
}

sub notify {
    my $hook            = pop;
    my $page            = shift;
    my $notify_mail_obj = $self->hub->load_class('notify_mail');

    my $meta_data  = $self->hub->edit->pages->current->metadata;
    my $site_title = $self->hub->config->site_title;

    my $edited_by = $meta_data->{edit_by} || 'unknown name';
    my $page_name = $meta_data->{id}      || 'unknown page';
    my $to      = $notify_mail_obj->recipient_list();
    my $from    = $notify_mail_obj->config->notify_mail_from || 'unknown';
    my $subject = sprintf( $notify_mail_obj->config->notify_mail_subject,
        $site_title, $page_name, $edited_by )
        || 'unknown';
    $subject =~ s/\$1/$site_title/g;
    $subject =~ s/\$2/$page_name/g;
    $subject =~ s/\$3/$edited_by/g;

    my $body = "$site_title page $page_name edited by $edited_by\n";

    $notify_mail_obj->mail_it( $to, $from, $subject, $body ) if $to;
    return $self;
}

sub mail_it {
    my ( $to, $from, $subject, $body ) = @_;

    my $msg = MIME::Lite->new(
        To      => $to,
        From    => $from,
        Subject => $subject,
        Data    => $body,
    );

    if ( debug($self) ) {
        open( TEMPFILE, '>', '/tmp/kwiki_notify_mail.txt' )
            || die "can't open tmp file $!";
        $msg->print( \*TEMPFILE );
        close TEMPFILE;
    }
    else {
        $msg->send;
    }
}

1;    # End of Kwiki::Notify::Mail

__DATA__

__config/notify_mail.yaml__
notify_mail_to:
notify_mail_topic: NotifyMail
notify_mail_from: nobody
notify_mail_subject: %s wiki page %s updated by %s
notify_mail_debug: 0
