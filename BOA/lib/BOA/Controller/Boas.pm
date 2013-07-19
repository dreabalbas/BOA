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

sub base :Chained('/') :PathPart('boas') :CaptureArgs(0) {
    my ($self, $c) = @_;

    $c->stash(resultset => $c->model('DB::Boa'));

    $c->log->debug('*** INSIDE BASE METHOD ***');
}

=head2 url_create

Crea una boa via url

=cut

sub url_create :Chained('base') :PathPart('url_create') :Args(3) {
    my ($self, $c, $autor, $contenido, $fecha) = @_;

    my $boa = $c->model('DB::Boa')->create({
        autor  => $autor,
        contenido => $contenido,
        fecha => $fecha, 
    });

    $c->stash(boa     => $boa,
              template => 'boas/boa_creada.tt2');

    $c->response->header('Cache-Control' => 'no-cache');
}

=head2 form_create

Muestra form para crear boa

=cut

sub form_create :Chained('base') :PathPart('form_create') :Args(0) {
    my ($self, $c) = @_;

    $c->stash(template => 'boas/form_create.tt2');
}

=head2 form_create_do

Obtiene la informacion del form y la agrega a la base de datos

=cut

sub form_create_do :Chained('base') :PathPart('form_create_do') :Args(0) {
    my ($self, $c) = @_;

    my $autor     = $c->request->params->{autor}     || 'N/A';
    my $contenido = $c->request->params->{contenido} || 'N/A';

    my $boa = $c->model('DB::Boa')->create({
            autor      => $autor,
            contenido  => $contenido,
            fecha      => $c->datetime()
        });

    $c->stash(boa     => $boa,
              template => 'boas/boa_creada.tt2');
}

=head2 object
 
Fetch the specified book object based on the book ID and store
it in the stash
 
=cut
 
sub object :Chained('base') :PathPart('autor/contenido') :CaptureArgs(2) {
    my ($self, $c, $autor, $contenido) = @_;
 
    $c->stash(object => $c->stash->{resultset}->find($autor, $contenido));
 
    die "Boa $autor , $contenido no encontrada" if !$c->stash->{object};
 
    $c->log->debug("*** INSIDE OBJECT METHOD for obj autor=$autor contenido=$contenido ***");
}

=head2 delete
 
Borrar una boa
 
=cut
 
sub delete :Chained('object') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;
 
    $c->stash->{object}->delete;
 
    $c->stash->{status_msg} = "Boa eliminada";
 
    $c->forward('list');
}