use v6;
#use Template::Mojo;
use JSON::Tiny;

class Project {
    has $.URL       = die "Every project needs an URL";
    has $.gitname   = die "Every project needs an gitname";

    has $.name;
    has $.readme;
    has $.logo;
    has $.description;

    has Pair $.test-results is rw; # colour => description

    method has_tests() {
        return True if "$.gitname/t".IO.e;
        return False;
    }

    method is_fresh() {
        if qqx[ cd $.gitname; git log -n 1 --format='%ci' ] ~~ m/^(\d\d\d\d)\-(\d\d)\-(\d\d)\s+/ {
            return True if ((Date.today - Date.new(+$0, +$1, +$2)) <= 90);
        }
        return False;
    }

    submethod BUILD(:$!URL, :$!gitname, :$!name, :$!description, :$!logo, :$!readme) {
        my $url = $!URL;
        $url ~~ s:g/\//\\\//;

        qqx/ git clone $url /;
        #$gitname.IO.e ?? eval "qx/ cd $gitname; git pull /" !! eval "qx/ git clone $url /"; too slow

        my $item;
        try {
            $item = from-json(slurp "$!gitname/META.info")[0];
        }

        $!name = $item<name> or "error";
        $!description = $item<description> or "error";

        $!URL ~~ s/git\:\/\//https\:\/\//;
        $!URL ~~ s/\.git//;

        $!logo = $!URL~"/raw/master/logotype/logo_32x32.png" if "$!gitname/logotype/logo_32x32.png".IO.e;

        my $readme_file = readme_file($!gitname);
        $!readme = $readme_file ?? $!URL~"/blob/master/"~$readme_file !! False; 
    }

    sub readme_file(Str $path) {
        for "", ".md", ".markdown", ".mkd" {
            return "README$_" if "$path/README$_".IO.e for "", ".md", ".markdown", ".mkd", ".mkdn", ".pod";
        }
    }

    method to_hash {
        my %hash =  "name" => $.name,
                    "URL" => $.URL,
                    "gitname" => $.gitname,
                    "readme" => $.readme,
                    "description" => $.description,
                    "has_tests" => self.has_tests,
                    "is_fresh" => self.is_fresh,
                    "test-results" => $.test-results.hash,
                    "logo" => $.logo;
        return %hash;
    }
}

my %test-results = from-json(slurp("results.json"));

my $projects = slurp("modules.list").split("\n").map: {
    my $p = Project.new(URL => $_, gitname => ~$/[0]) if /\/\/.*?\/.*?\/(.*?)\.git/;
    next unless $p;
    next unless $p.name;
    next unless %test-results{$p.name};
    $p.test-results = do given %test-results{$p.name} {
        when .<prereq> == False {
            red => 'Could not resolve dependencies'
        }
        when .<build> == False {
            red => 'Did not build successfully'
        }
        when .<test> == False {
            red => 'Some tests have failed'
        }
        when $p.has_tests == False {
            yellow => 'Has no tests'
        }
        default {
            green => 'Everything all right'
        }
    }
    $p;
}

#my $last_update = DateTime.now.Str;
#my $tmpl = slurp "index.mojo";

#my $index = open "../index.html", :w;
#$index.say: Template::Mojo.new($tmpl).render($projects.list.sort( *.name).item, $last_update);
#$index.close;

my $json = open "../proto.json", :w;
my %all;
%all.push(.gitname => .to_hash) for $projects.list;
$json.say: to-json(%all);
$json.close;