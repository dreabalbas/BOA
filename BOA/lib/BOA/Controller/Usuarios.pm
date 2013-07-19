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
    # Retrieve the usual Perl OO '$self' for this object. $c is the Catalyst
    # 'Context' that's used to 'glue together' the various components
    # that make up the application
    my ($self, $c) = @_;

    # Retrieve all of the book records as book model objects and store in the
    # stash where they can be accessed by the TT template
    # $c->stash(books => [$c->model('DB::Book')->all]);
    # But, for now, use this code until we create the model later
    $c->stash(usuarios => [$c->model('DB::Usuario')->all]);

    # Set the TT template to use.  You will almost always want to do this
    # in your action methods (action methods respond to user input in
    # your controllers).
    $c->stash(template => 'usuarios/list.tt2');
}


=head2 base

Logica base, comun en varios metodos que luego
seran encadenados

=cut

sub base :Chained('/') :PathPart('usuarios') :CaptureArgs(0) {
    my ($self, $c) = @_;

    # Store the ResultSet in stash so it's available for other methods
    $c->stash(resultset => $c->model('DB::Usuario'));

    # Print a message to the debug log
    $c->log->debug('*** INSIDE BASE METHOD ***');
}

=head2 url_create
    
Crear un usuario via url

=cut
    
sub url_create :Chained('base') :PathPart('url_create') :Args(4) {
    # In addition to self & context, get the title, rating, &
    # author_id args from the URL.  Note that Catalyst automatically
    # puts extra information after the "/<controller_name>/<action_name/"
    # into @_.  The args are separated  by the '/' char on the URL.
    my ($self, $c, $nombreusuario, $nombres, $apellidos, $email) = @_;

    # Call create() on the book model object. Pass the table
    # columns/field values we want to set as hash values
    my $usuario = $c->model('DB::Usuario')->create({
	    nombreusuario  => $nombreusuario,
	    nombres => $nombres,
	    apellidos => $apellidos,
	    email => $email
	});
	
    # Assign the Book object to the stash for display and set template
    $c->stash(usuario     => $usuario,
	          template => 'usuarios/usuario_creado.tt2');

    # Disable caching for this page
    $c->response->header('Cache-Control' => 'no-cache');
}

=head2 create

Usa HTML::FormHandler para crear un nuevo usuario

=cut

sub create :Chained('base') Path('create') Args(0) {
    my ($self, $c ) = @_;

    my $usuario = $c->model('DB::Usuario')->new_result({});
    return $self->form($c, $usuario);
}

=head2 form

Procesa el formulario para usuario del FormHandler.

=cut

sub form {

    my ( $self, $c, $usuario ) = @_;

    my $form = BOA::Form::Usuario->new;
    
    # Establecer el archivo
    $c->stash( template => 'usuarios/form.tt2', form => $form );
    $form->process( item => $usuario, params => $c->req->params );
    
    return unless $form->validated;
    
    # Mensaje de status del proceso y vuelve a la lista de usuarios
    $c->stash(usuario     => $usuario,
	      template => 'usuarios/usuario_creado.tt2');
}

=head2 object
 
Fetch the specified book object based on the book ID and store
it in the stash
 
=cut
 
sub object :Chained('base') :PathPart('nombreusuario') :CaptureArgs(1) {
    # $id = primary key of book to delete
    my ($self, $c, $nombreusuario) = @_;
 
    # Find the book object and store it in the stash
    $c->stash(object => $c->stash->{resultset}->find($nombreusuario));
 
    # Make sure the lookup was successful.  You would probably
    # want to do something like this in a real app:
    #   $c->detach('/error_404') if !$c->stash->{object};
    die "Book $nombreusuario not found!" if !$c->stash->{object};
 
    # Print a message to the debug log
    $c->log->debug("*** INSIDE OBJECT METHOD for obj nombreusuario=$nombreusuario ***");
}

=head2 delete
 
Delete a book
 
=cut
 
sub delete :Chained('object') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;
 
    # Use the book object saved by 'object' and delete it along
    # with related 'book_author' entries
    $c->stash->{object}->delete;
 
    # Set a status message to be displayed at the top of the view
    $c->stash->{status_msg} = "Usuario eliminado";
 
    # Forward to the list action/method in this controller
    $c->forward('list');
}