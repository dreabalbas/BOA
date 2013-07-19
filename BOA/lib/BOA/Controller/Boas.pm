package BOA::Controller::Boas;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

BOA::Controller::Boas - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched BOA::Controller::Boas in Boas.');
}


=head1 AUTHOR

betocols,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

=head2 list

Recupera los boas y los pasa en boas/list.tt2 para ser mostrados

=cut

sub list :Local {
    my ($self, $c) = @_;

    $c->stash(boas => [$c->model('DB::Boa')->all]);

    $c->stash(template => 'boas/list.tt2');
}

=head2 base

Can place common logic to start chained dispatch here

=cut

sub base :Chained('/') :PathPart('boas') :CaptureArgs(0) {
    my ($self, $c) = @_;

    $c->stash(resultset => $c->model('DB::Boa'));

    $c->log->debug('*** INSIDE BASE METHOD ***');
}

=head2 url_create

Crea una boa via url

=cut

sub url_create :Chained('base') :PathPart('url_create') :Args(3) {
    # In addition to self & context, get the autor, contenido, &
    # fecha args from the URL.  Note that Catalyst automatically
    # puts extra information after the "/<controller_name>/<action_name/"
    # into @_.  The args are separated  by the '/' char on the URL.
    my ($self, $c, $autor, $contenido, $fecha) = @_;

    # Call create() on the book model object. Pass the table
    # columns/field values we want to set as hash values
    my $boa = $c->model('DB::Boa')->create({
        autor  => $autor,
        contenido => $contenido,
        fecha => $fecha, 
    });

    # Assign the Book object to the stash for display and set template
    $c->stash(boa     => $boa,
              template => 'boas/boa_creada.tt2');

    # Disable caching for this page
    $c->response->header('Cache-Control' => 'no-cache');
}

=head2 form_create

Muestra form para crear boa

=cut

sub form_create :Chained('base') :PathPart('form_create') :Args(0) {
    my ($self, $c) = @_;

    # Set the TT template to use
    $c->stash(template => 'boas/form_create.tt2');
}

=head2 form_create_do

Take information from form and add to database

=cut

sub form_create_do :Chained('base') :PathPart('form_create_do') :Args(0) {
    my ($self, $c) = @_;

    # Retrieve the values from the form
    my $autor     = $c->request->params->{autor}     || 'N/A';
    my $contenido = $c->request->params->{contenido} || 'N/A';

    # Crear la boa
    my $boa = $c->model('DB::Boa')->create({
            autor      => $autor,
            contenido  => $contenido,
            fecha      => $c->datetime()
        });

    # Store new model object in stash and set template
    $c->stash(boa     => $boa,
              template => 'boas/boa_creada.tt2');
}