use v6;
use Template::Mojo;

sub render($tmpl, *@a) {
    Template::Mojo.new($tmpl).render(|@a);
}

my $file = slurp 'index.mojo';

class Project {
    has $.has_readme = True;
    has $.readme = True;

    has $.is_fresh = True;
    has $.panda = True;
    has $.description = True;
    has $.logo = True;

    has $.has_tests = True;

    has $.name = True;
    has $.URL = True;
}

my @projects;
@projects.push: Project.new;
@projects.push: Project.new;
my $last_update = 'dzisiaj';

say @projects.perl;

say render($file, { :@projects, :$last_update })
