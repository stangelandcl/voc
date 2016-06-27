#!/usr/bin/perl -w


use strict;
use warnings;
use POSIX "strftime";


use CGI qw(:standard escapeHTML);
use JSON;

sub writelog {
  my ($msg) = @_;

  open(LOG, ">>/tmp/postpush.log") or die "Could not create postpush.log";
  flock(LOG, 2)                    or die "Could not lock postpush.log";
  print LOG sprintf("%s %s\n", strftime("%Y/%m/%d %H.%M.%S", localtime), $msg);
  close(LOG);
}

sub writelog {
  my ($msg) = @_;

  open(LOG, ">>/tmp/postpush.log") or die "Could not create postpush.log";
  flock(LOG, 2)                    or die "Could not lock postpush.log";
  print LOG sprintf("%s %s\n", strftime("%Y/%m/%d %H.%M.%S", localtime), $msg);
  close(LOG);
}

writelog "Postpush.";

my $postdata = from_json(param('POSTDATA'));

my $url  = $postdata->{'repository'}->{'url'};
my $ref  = $postdata->{'ref'};
my $name = $postdata->{'head_commit'}->{'author'}->{'name'};

my $branch = $ref;  $branch =~ s'^.*\/'';
my $repo   = $url;  $repo   =~ s'^.*\/'';

#my $repo="repo"; my $branch="branch"; my $name="name";

<<<<<<< HEAD
writelog "Post push github web hook for repository $repo, branch $branch, name $name.";

my $child = fork;
if (not defined $child) {die "Fork failed.";}
if ($child) {
  # parent process
  writelog "Started ssh, pid = $child.";
} else {
  # child process
  exec 'ssh root@oberon "perl vishap/voc/src/tools/testcoordinator/buildall.pl >/tmp/buildall.log &"';
  exit;
}
=======
writelog "Repository $repo, branch $branch, name $name.";
>>>>>>> 3a17e1a65685db28158fd65fff295e93a1bec31f

print header(),
  start_html("Vishap Oberon github post push web hook."),
  p("Repository $repo, branch $branch, name $name."),
  end_html();
<<<<<<< HEAD
=======

system 'ssh root@oberon perl vishap/voc/src/tools/testcoordinator/buildall.pl >/tmp/buildall.log &';

writelog "Buildall triggered."
>>>>>>> 3a17e1a65685db28158fd65fff295e93a1bec31f
