package BOA::View::Vistas;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

 __PACKAGE__->config(
    # Change default TT extension
    TEMPLATE_EXTENSION => '.tt2',
    # Set the location for TT files
    INCLUDE_PATH => [
	    BOA->path_to( 'root' ),
	],
    # Set to 1 for detailed timer stats in your HTML as comments
    TIMER              => 0,
    # This is your wrapper template located in the 'root/src'
    WRAPPER => 'wrapper.tt2',
);

=head1 NAME

BOA::View::Vistas - TT View for BOA

=head1 DESCRIPTION

TT View for BOA.

=head1 SEE ALSO

L<BOA>

=head1 AUTHOR

dreabalbas,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

