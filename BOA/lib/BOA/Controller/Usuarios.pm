package BOA::Controller::Usuarios;
use Moose;
use namespace::autoclean;
use BOA::Form::Usuario;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

BOA::Controller::Usuarios - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched BOA::Controller::Usuarios in Usuarios.');
}

=head1 AUTHOR

dreabalbas,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;


=head2 list

Recupera los usuarios y los pasa en usuarios/list.tt2 para ser mostrados

=cut

sub list :Local {
    my ($self, $c) = @_;

    $c->stash(usuarios => [$c->model('DB::Usuario')->all]);

    $c->stash(template => 'usuarios/list.tt2');
}


=head2 base

Logica base, comun en varios metodos que luego
seran encadenados

=cut

sub base :Chained('/') :PathPart('usuarios') :CaptureArgs(0) {
    my ($self, $c) = @_;

    $c->stash(resultset => $c->model('DB::Usuario'));

    $c->log->debug('*** INSIDE BASE METHOD ***');
}

=head2 url_create
    
Crear un usuario via url

=cut
    
sub url_create :Chained('base') :PathPart('url_create') :Args(4) {
    my ($self, $c, $nombreusuario, $nombres, $apellidos, $email) = @_;

    my $usuario = $c->model('DB::Usuario')->create({
	    nombreusuario  => $nombreusuario,
	    nombres => $nombres,
	    apellidos => $apellidos,
	    email => $email
	});
	
    $c->stash(usuario     => $usuario,
	          template => 'usuarios/usuario_creado.tt2');

    $c->response->header('Cache-Control' => 'no-cache');
}

=head2 create

Muestra form de crear un nuevo usuario

=cut

sub form_create :Chained('base') :PathPart('form_create') :Args(0) {
    my ($self, $c) = @_;

    $c->stash(template => 'usuarios/form_create.tt2');
}

=head2 form

Procesa el formulario para usuario del FormHandler.

=cut

sub form {

    my ( $self, $c, $usuario ) = @_;

    my $form = BOA::Form::Usuario->new;
    
    $c->stash( template => 'usuarios/form.tt2', form => $form );
    $form->process( item => $usuario, params => $c->req->params );
    
    return unless $form->validated;
    
    $c->stash(usuario     => $usuario,
	      template => 'usuarios/usuario_creado.tt2');
}

=head2 form_create_do

Obtiene la informacion del form y la agrega a la base de datos

=cut

sub form_create_do :Chained('base') :PathPart('form_create_do') :Args(0) {
    my ($self, $c) = @_;

    my $nombreusuario   = $c->request->params->{nombreusuario}  || 'N/A';
    my $nombres         = $c->request->params->{nombres}        || 'N/A';
    my $apellidos       = $c->request->params->{apellidos}      || 'N/A';
    my $email           = $c->request->params->{email}          || 'N/A';
    my $password        = $c->request->params->{contrasena}     || 'N/A';

    my $usuario = $c->model('DB::Usuario')->create({
            nombreusuario      => $nombreusuario,
            nombres  => $nombres,
            apellidos      => $apellidos,
            email      => $email,
            contrasena      => $password,

        });

    $c->stash(usuario     => $usuario,
              template => 'usuarios/usuario_creado.tt2');
}

=head2 object
  
=cut
 
sub object :Chained('base') :PathPart('nombreusuario') :CaptureArgs(1) {
    my ($self, $c, $nombreusuario) = @_;
 
    $c->stash(object => $c->stash->{resultset}->find($nombreusuario));
 
    die "Book $nombreusuario not found!" if !$c->stash->{object};
 
    $c->log->debug("*** INSIDE OBJECT METHOD for obj nombreusuario=$nombreusuario ***");
}

=head2 delete
 
Borrar usuario
 
=cut
 
sub delete :Chained('object') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;
 
    $c->stash->{object}->delete;
 
    $c->stash->{status_msg} = "Usuario eliminado";
 
    $c->forward('list');
}