package BOA::Controller::Usuarios;
use Moose;
use namespace::autoclean;

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
Fetch all book objects and pass to books/list.tt2 in stash to be displayed

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


=head2 url_create
    
Crear un usuario

=cut

sub url_create :Local {
    # In addition to self & context, get the title, rating, &
    # author_id args from the URL.  Note that Catalyst automatically
    # puts extra information after the "/<controller_name>/<action_name/"
    # into @_.  The args are separated  by the '/' char on the URL.
    my ($self, $c, $nombreusuario, $nombres, $apellidos) = @_;

    # Call create() on the book model object. Pass the table
    # columns/field values we want to set as hash values
    my $usuario = $c->model('DB::Usuario')->create({
	    nombreusuario  => $nombreusuario,
	    nombres => $nombres,
	    apellidos => $apellidos
	});
	
    # Assign the Book object to the stash for display and set template
    $c->stash(usuario     => $usuario,
	      template => 'usuarios/usuario_creado.tt2');

    # Disable caching for this page
    $c->response->header('Cache-Control' => 'no-cache');
}
