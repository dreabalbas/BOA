package BOA::View::Vistas;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt2',
    render_die => 1,
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

