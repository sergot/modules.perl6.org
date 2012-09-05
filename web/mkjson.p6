use v6;
use JSON::Tiny;

my $download_dir = '.';
my $emmentaler_dir = '..';

class Project {
    has $.URL       = die "Every project needs an URL";
    has $.gitname   = die "Every project needs an gitname";

    has $.name;
    has $.readme;
    has $.readme_content;
    has $.logo;
    has $.description;

    has $!path;

    has Pair $.test-results is rw; # colour => description

    method has_tests() {
        return True if "$!path/t".IO.e;
        return False;
    }

    method is_fresh() {
        if qqx[ cd $!path; git log -n 1 --format='%ci' ] ~~ m/^(\d\d\d\d)\-(\d\d)\-(\d\d)\s+/ {
            return True if ((Date.today - Date.new(+$0, +$1, +$2)) <= 90);
        }
        return False;
    }

    submethod BUILD(:$!URL, :$!gitname, :$!name, :$!description, :$!logo, :$!readme) {
        my $url = $!URL;
        $url ~~ s:g/\//\\\//;

        $!path = "$download_dir/$!gitname";

        qqx/ git clone $url $!path /;
        #$!gitname.IO.e ?? eval "qx/ cd $!path; git pull /" !! eval "qx/ git clone $url $!path /"; # too slow

        my $item;
        try {
            $item = from-json(slurp "$!path/META.info")[0];
        }

        $!name = $item<name> or "error";
        $!description = $item<description> or "error";

        $!URL ~~ s/git\:\/\//https\:\/\//;
        $!URL ~~ s/\.git//;

        $!logo = $!URL~"/raw/master/logotype/logo_32x32.png" if "$!path/logotype/logo_32x32.png".IO.e;

        my $readme_file = readme_file($!path);
        $!readme = $readme_file ?? $!URL~"/blob/master/"~$readme_file !! False; 
        $!readme_content = slurp "$!path/$readme_file" if $!readme;
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
                    "readme_content" => $.readme_content,
                    "description" => $.description,
                    "has_tests" => self.has_tests,
                    "is_fresh" => self.is_fresh,
                    "test-results" => $.test-results.hash,
                    "logo" => $.logo;
        return %hash;
    }
}

my %test-results = from-json(slurp("$emmentaler_dir/results.json"));

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

my $json = open "proto.json", :w;
my %all;
%all.push(.gitname => .to_hash) for $projects.list;
$json.say: to-json(%all);
$json.close;

# generating single module page
# TODO
