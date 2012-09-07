use v6;
use JSON::Tiny;
use Template::Mojo;

my $site_dir = '/home/user/public_html/modules';
my $fullpath = '/home/user/perl6/modules.perl6.org';

my $last_update = DateTime.now.Str;
my $tmpl = slurp "$fullpath/web/index.mojo";

my $projects = from-json(slurp("$site_dir/proto.json")).values;

my $index = open "$site_dir/index.html", :w;
$index.say: Template::Mojo.new($tmpl).render($projects.list.sort(*.<name>).item, $last_update);
$index.close;

$tmpl = slurp "$fullpath/web/module.mojo";
for $projects.list -> $p {
    my $m = open "$site_dir/module/{$p<name>}.html", :w;
    $m.say: Template::Mojo.new($tmpl).render($p);
    $m.close;
}
