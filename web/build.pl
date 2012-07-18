use v6;
use Template::Mojo;
use JSON::Tiny;

my $tmpl = slurp 'index.mojo';

class Project {
    has $.has_readme  = False;
    has $.readme      = False;
    has $.is_fresh    = False;
    has $.logo        = False;
    has $.has_tests   = False;
    has $.description = "this project has no description";
    has $.name        = die "Every project needs a name";
    has $.URL         = die "Every project needs an URL";
}

my $projects = from-json(slurp("projects.json")).map: {
    Project.new(name => $_<name>, description => $_<description>,
                URL  => ($_<source-url>//$_<repo-url>)\
                                      .subst(/^git/, 'http')\
                                      .subst(/\.git$/, ''))
}

my $last_update = DateTime.now.Str;

Template::Mojo.new($tmpl).render($projects, $last_update).say;
