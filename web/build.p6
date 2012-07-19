use v6;
use Template::Mojo;
use JSON::Tiny;
use File::Path;

class Project {
    has $.readme is rw      = False;
    has $.logo is rw        = False;
    has $.description is rw = "this project has no description";
    has $.name is rw  = False; #die "Every project needs a name";
    has $.URL is rw         = die "Every project needs an URL";
    has $.gitname;

    method has_readme() {
        if "$.gitname/README".IO.e {
            $.readme = "$.gitname/README";
            return True;
        }
        elsif "$.gitname/README.md".IO.e {
            $.readme = "$.gitname/README.md";
            return True;
        }
        return False;
    }

    method has_tests() {
        return True if "$.gitname/t".IO.e;
        return False;
    }

    method is_fresh() {
        return False;
    }

    method has_meta() {
        my $url = $.URL;
        $url ~~ s:g/\//\\\//;

        eval "qx/ git clone $url /";
        
        try {
            my $item = from-json(slurp "$.gitname/META.info")[0];
            $.name = $item<name>;
            $.description = $item<description>;
        }
        $.URL ~~ s/git\:\/\//https\:\/\//;
        $.URL ~~ s/\.git//;

        $.logo = $.URL~"/raw/master/logotype/logo_32x32.png" if "$.gitname/logotype/logo_32x32.png".IO.e;

        return True;
    }
}

my $projects = slurp("modules.list").split("\n").map: {
    Project.new(URL => $_, gitname => ~$/[0]) if /\/\/.*?\/.*?\/(.*?)\.git/;
}
my $last_update = DateTime.now.Str;
my $tmpl = slurp "index.mojo";

Template::Mojo.new($tmpl).render($projects, $last_update).say;
