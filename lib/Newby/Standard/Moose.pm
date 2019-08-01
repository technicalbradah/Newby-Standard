package Newby::Standard::Moose;

# ABSTRACT: Standardized imports for Moose based modules.

use Hook::AfterRuntime;
use Moose;
use Moose::Exporter;
use MooseX::HasDefaults::RO;
use Newby::Standard::Imports;
use namespace::autoclean ();

my ( $import, ) =
    Moose::Exporter->build_import_methods( install => ['unimport'], );

Moose::Exporter->setup_import_methods( also => ['Moose'] );

sub import {
    my ( $class, ) = @_;

    return $class->$import( { into => scalar caller } );
} ## end of sub import

sub init_meta {
    shift;
    my %params = @_;

    my $for_class = $params{for_class};

    Moose->init_meta(@_);
    MooseX::HasDefaults::RO->import( { into => $for_class } );

    namespace::autoclean->import( -cleanee => $for_class );
    after_runtime { $for_class->meta->make_immutable };

    return;
} ## end of sub init_meta

1;

__END__

=head1 SYNOPSIS

    use Newby::Standard::Moose;

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
    use Moose;
    use MooseX::HasDefaults::RO;
    use namespace::autoclean;

    ...

    __PACKAGE__->meta->make_immutable;

=head1 USAGE

    use Newby::Standard::Moose;

=for Pod::Coverage init_meta

=head1 HOMEPAGE

Please visit the project's homepage at L<{{$homepage_url}}>.

=head1 SOURCE

Source repository is at L<{{$repository_url}}>.

=head1 BUGS

If you have any suggestions for improvements, or find any bugs, please report them to L<{{$issues_url}}>.  I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.

=cut
