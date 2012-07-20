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

    method has_tests() {
        return True if "$.gitname/t".IO.e;
        return False;
    }

    method is_fresh() {
        if eval("qx[ cd $.gitname; git log -n 1 --format='%ci' ]") ~~ m/^(\d\d\d\d)\-(\d\d)\-(\d\d)\s+/ {
            return True if ((Date.today - Date.new(+$0, +$1, +$2)) <= 90);
        }
        return False;
    }

    method new(:$URL is copy, :$gitname) {
        my $url = $URL;
        my ($name, $description, $logo);
        $url ~~ s:g/\//\\\//;

        eval "qx/ git clone $url /";
        #$gitname.IO.e ?? eval "qx/ cd $gitname; git pull /" !! eval "qx/ git clone $url /";

        try {
            my $item = from-json(slurp "$gitname/META.info")[0];
            $name = $item<name>;
            $description = $item<description>;
        }
        $URL ~~ s/git\:\/\//https\:\/\//;
        $URL ~~ s/\.git//;

        $logo = $URL~"/raw/master/logotype/logo_32x32.png" if "$gitname/logotype/logo_32x32.png".IO.e;

        my $readme_file = readme_file($gitname);
        my $readme = $readme_file ?? $URL~"/blob/master/"~$readme_file !! False; 

        self.bless(*, :$URL, :$gitname, :$logo, :$name, :$readme, :$description);
    }

    sub readme_file(Str $path) {
        "$path/README".IO.e ?? "README" !! "$path/README.md".IO.e ?? "README.md" !! "$path/README.markdown".IO.e ?? "README.markdown" !! "$path/README.mkd".IO.e ?? "README.mkd" !! False;
    }

    method to_hash {
        my %hash =  "name" => $.name,
                    "gitname" => $.gitname,
                    "readme" => $.readme,
                    "has_tests" => self.has_tests,
                    "logo" => $.logo;
        return %hash;
    }
}

my $projects = slurp("modules.list").split("\n").map: {
    Project.new(URL => $_, gitname => ~$/[0]) if /\/\/.*?\/.*?\/(.*?)\.git/;
}
my $last_update = DateTime.now.Str;
my $tmpl = slurp "index.mojo";

my $index = open "../index.html", :w;
$index.say: Template::Mojo.new($tmpl).render($projects.list.sort( *.name).item, $last_update);
$index.close;

my $json = open "../proto.json", :w;
my %all;
%all.push(.gitname => .to_hash) for $projects.list;
$json.say: to-json(%all);
$json.close;
