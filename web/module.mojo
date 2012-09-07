<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

% my $m = @_[0];

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en-US">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	    <link rel="icon" href="/favicon.ico" type="favicon.ico" />
        <title>Perl 6 Modules Directory</title>
        <link rel="stylesheet" href="style.css" type="text/css" />

<style type="text/css">
body {
	font-family:helvetica,arial,sans-serif;
	color:#000;
	padding-top: 1em;
	padding-bottom: 2em;
}
a {color:#000;}
a img {border:none;}
.project-logo {width:32px;margin-left:-37px;margin-right:5px;float:left;}
.badges { float: right }
#header {
	margin:0 0 3em;min-height:200px;
	-moz-border-radius:1em 1em 1em 1em;
	-moz-box-shadow:5px 5px 10px #888888;
	border-radius:1em 1em 1em 1em;
	background:none repeat scroll 0 0 #80B5FF;
	border:0.2em solid #63A4FF;
	font-weight:bold;
	padding:0 1em;
	position:relative;
}
#header img{
	border:0 none;
	float:right;
	position:relative;
	right:-2em;
	top:-1.5em;
	z-index:1;
}
h2 {margin:30px 0 0 0;}
#header, #content {margin: 0 auto 0 auto;width: 700px;}
#about, p {margin: 40px auto 0 auto;text-align: justify}
#json_link {float:right;margin-top:-22px;font-size:smaller;}

h1 a { text-decoration: none; }

dl.table-display {
	float: left;
	width: 700px;
	margin: 1em auto 0 auto;
	padding: 0;
	border-bottom: 1px solid #999;
}

.table-display dt {
	clear: left;
	float: left;
	width: 200px;
	margin: 0;
	padding: 5px;
	border-top: 1px solid #999;
	font-weight: bold;
}

.table-display dd
{
	float: left;
	width: 480px;
	margin: 0;
	padding: 5px;
	border-top: 1px solid #999;
}
</style>

    </head>
    <body>
		<div id="header">
			<a href="https://github.com/perl6/mu/blob/master/misc/camelia.txt"><img alt="camelia perl bug logo" src="http://perl6.org/camelia-logo.png" /></a>
			<h1><a href="../">Perl 6 Modules</a></h1>
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
        <p>
% if $m<readme> {
        <pre>
<%= $m<readme_content> %>
        </pre>
% } else {
        There is no README file! :(
% }
        </p>
     </div>
    </body>
</html>
