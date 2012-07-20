<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en-US">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	    <link rel="icon" href="/favicon.ico" type="favicon.ico" />
        <title>Perl 6 Modules Directory</title>
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
			<h1><a href="/">Perl 6 Modules</a></h1>
		</div>
        <div id="content">
        <div id="about">
        <p>
            Below you can find a list of known Perl 6 modules. All of them
            have been working on <a href="http://rakudo.org/">Rakudo</a> at
            some point.
        </p>

        <p>These modules can be installed with <a
            href="https://github.com/tadzik/panda/">panda</a>, a module management tool
          which comes with <a href="http://rakudo.org/how-to-get-rakudo/">Rakudo Star</a>.
        </p>
        <p>
            If you want to contribute your own module, please read <a
            href="http://wiki.perl6.org/Create%20and%20Distribute%20Modules">this
            guide</a>.
        </p>
        <p>
            Missing a module you can't live without? Consider adding it
            to a <a href="https://github.com/perl6/ecosystem/wiki/Most-Wanted-Modules">Most Wanted</a> list on the ecosystem wiki.
        </p>
        </div>
        <h2>Project list</h2>
        <p id="json_link"><a href="proto.json">JSON version of this list</a>.</p>
        <dl class="table-display">
% my ($projects, $last_update) = @_;
% for $projects.list {
%     if $_.description {
            <dt>
%         if $_.logo {
                <img class="project-logo" src="<%= $_.logo %>" alt="<%= $_.name %> logo" />
%         }
            <a href="<%= $_.URL %>"><%= $_.name %></a></dt>
	    <dd>
        <div class='badges'>
%         if $_.readme {
                <a href="<%= $_.readme %>"><img src='readme.png' title='Has a README' alt="Readme badge" /></a>
%         } else {
            <img src='unachieved.png' title="Doesn't have a README" alt="Unachieved badge" />
%         }
%         if $_.has_tests {
                <img src='tests.png' title='Has tests' alt="Tests badge" />
%         } else {
                <img src='unachieved.png' title="Doesn't have tests" alt="Unachieved badge" />
%         }
%         if $_.is_fresh {
                <img src='fresh.png' title='Commits in the past 90 days' alt="Fresh badge" />
%         } else {
                <img src='unachieved.png' title='No commits in the past 90 days' alt="Unachieved badge" />
%         }
        </div>
	    <%= $_.description %></dd>
%     } # if
% } # for
        </dl>
        <p style="clear:both; padding-top: 2em">
        This page is generated from the files in the <a
        href="http://github.com/perl6/modules.perl6.org/">modules.perl6.org
        repository</a><br/>(<i>last update <%= $last_update %></i>).</p>
        <p>For feedback and patches, please contact us
        through the <a href="http://perl6.org/community/irc">#perl6 IRC
        channel</a>, or send an email to the perl6-compiler@perl.org mailing
        list.
        </p>
        <p>Want to know how to score badges? Read up on
           <a href="fame-and-profit">how to achieve fame and profit</a>!</p>
     </div>
    </body>
</html>
