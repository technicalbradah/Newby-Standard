package Newby::Standard::Imports;

# ABSTRACT: Standardized imports implementing the Newby Standard (tm)

use v5.24;
use strict;
use warnings;
use feature ();
use mro     ();
use utf8::all;
use Carp;
use English qw( -no_match_vars );
use IO::Handle;
use IO::File;
use Import::Into;

sub import {
    my $caller = caller;

    feature->import( qw/signatures :5.24/ );
    strict->import;
    warnings->import;
    warnings->unimport( 'experimental::signatures' );
    utf8::all->import::into( $caller );
    Carp->import::into( $caller, qw(carp cluck confess croak) );
    English->import::into( $caller, qw( -no_match_vars ) );
    IO::Handle->import::into( $caller );
    IO::File->import::into( $caller );
    mro::set_mro( scalar caller(), 'c3' );
}

sub unimport {
    feature->unimport;
    strict->unimport;
    utf8::all->unimport;
    warnings->unimport;
    Carp->unimport;
    English->unimport;
    IO::File->unimport;
    IO::Handle->unimport;
}

1;

__END__

=head1 SYNOPSIS

    use Newby::Standard::Imports;

=head1 DESCRIPTION

Using this module automatically adds the following to your code.

    use v5.24;
    use strict;
    use warnings;
    use feature 'signatures';
    no warnings 'experimental::signatures';
    use utf8::all;
    use Carp qw(carp croak);
    use English qw( -no_match_vars );
    use IO::Handle;
    use IO::File;

=head1 HOMEPAGE

Please visit the project's homepage at L<{{$homepage_url}}>.

=head1 SOURCE

Source repository is at L<{{$repository_url}}>.

=head1 BUGS

If you have any suggestions for improvements, or find any bugs, please report them to L<{{$issues_url}}>.  I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.

=cut
