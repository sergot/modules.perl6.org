use v6;
use JSON::Tiny;
use Template::Mojo;

my $last_update = DateTime.now.Str;
my $tmpl = slurp "index.mojo";

my $projects = from-json(slurp("../proto.json")).values;

my $index = open "../index.html", :w;
$index.say: Template::Mojo.new($tmpl).render($projects, $last_update);
$index.close;
