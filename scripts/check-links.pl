#!/usr/bin/perl
# Reports links in HTML files to local files that do not exist.
#
#   scripts/check-links.pl index.html other.html
#
# It checks href, src, and srcset values. It skips links to other sites (https:, mailto:,
# and so on), links to anchors on the same page, and links in HTML comments. A link that
# starts with / is relative to the repo root, which GitHub Pages serves as the site root.
# A link that ends with / goes to the index.html in that folder.

use strict;
use warnings;
use File::Basename qw(dirname);

my $missing = 0;

for my $page (@ARGV) {
    open my $fh, '<', $page or die "$page: $!\n";
    my $html = do { local $/; <$fh> };
    close $fh;

    # Blank out comments, but keep their newlines so that line numbers stay correct.
    $html =~ s/(<!--.*?-->)/my $c = $1; $c =~ s|[^\n]||g; $c/gse;

    my $dir = dirname($page);
    while ($html =~ /\b(href|src|srcset)\s*=\s*"([^"]*)"/g) {
        my ($attr, $value) = ($1, $2);
        my $line = 1 + (() = substr($html, 0, $-[0]) =~ /\n/g);
        # A srcset is a list of "URL width" entries, separated by commas.
        my @urls = $attr eq 'srcset' ? map { (split ' ', $_)[0] // () } split /,/, $value : ($value);
        for my $url (@urls) {
            next if $url eq '' || $url =~ m{^(#|[a-z][a-z0-9+.-]*:|//)}i;
            (my $path = $url) =~ s/[?#].*//;
            $path = $path =~ m{^/} ? ".$path" : "$dir/$path";
            $path .= 'index.html' if $path =~ m{/$};
            next if -e $path;
            print "$page:$line: $attr=\"$url\": no file at $path\n";
            $missing++;
        }
    }
}

exit($missing ? 1 : 0);
