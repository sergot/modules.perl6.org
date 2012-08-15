use Template::Mojo;

my $readme = q{
It's the port of Perl 5's Acme::Meow [1]

It's not the verbatim port, some things have changed,
and there are more to come. Stay tuned for more fun :)

[1] http://search.cpan.org/~foolish/Acme-Meow-0.01/lib/Acme/Meow.pm
};

my %data =
    name   => 'Acme::Meow',
    url    => 'https://github.com/tadzik/perl6-Acme-Meow',
    readme => $readme,
    logo   => 'https://github.com/GlitchMr/perl6-Acme-Addslashes/raw/master/logotype/logo_32x32.png',
    description => 'The kitty you always wanted, now in Perl 6',
;

my $tmpl = slurp "module.mojo";
$tmpl = Template::Mojo.new($tmpl);
say $tmpl.render($(%data))
