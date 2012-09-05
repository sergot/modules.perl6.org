<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

% my $m = @_[0];

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en-US">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	    <link rel="icon" href="/favicon.ico" type="favicon.ico" />
        <title>Perl 6 Modules Directory</title>
        <link rel="stylesheet" href="style.css" type="text/css" />

    </head>
    <body>
		<div id="header">
			<a href="https://github.com/perl6/mu/blob/master/misc/camelia.txt"><img alt="camelia perl bug logo" src="http://perl6.org/camelia-logo.png" /></a>
			<h1><a href="/">Perl 6 Modules</a></h1>
            <h2>
            % if $m<logo> {
                <img class="project-logo" alt="<%= $m<name> %> logo"
                     src="<%= $m<logo> %>">
            % }
                <%= $m<name> %>
            </h2>
            <h3> <%= $m<description> %> </h2>
		</div>
        <div id="content">
        <p>
        <%= $m<name> %> on Github:
            <a href="<%= $m<URL> %>"><%= $m<URL> %></a>
        <p>
        <h3> Readme </h3>
        <p><pre>
<%= $m<readme_content> %>
        </pre></p>

     </div>
    </body>
</html>
