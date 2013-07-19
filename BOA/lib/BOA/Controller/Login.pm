package BOA::Controller::Login;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

BOA::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
  my ($self, $c) = @_;

  # Obtiene el usuario y la contrasena
  my $nombreusuario = $c->request->params->{nombreusuario};
  my $contrasena    = $c->request->params->{contrasena};

  # Si los encontro
  if ($nombreusuario && $contrasena) {
      # Intenta hacer login
      if ($c->authenticate({ nombreusuario => $nombreusuario,
			      contrasena => $contrasena})) {
    	  # Si lo logra, entra en la app
    	  $c->response->redirect($c->uri_for(
	      $c->controller('Usuarios')->action_for('list')));
	      return;
      } else {
	      # Mensaje de error
	      $c->stash(error_msg => "Nombre de usuario o contraseña incorrecto.");
      }
  } else {
      # Mensaje de error
      $c->stash(error_msg => "Nombre de usuario o contraseña vacío.")
	    unless ($c->user_exists);
  }

  # If either of above don't work out, send to the login page
  $c->stash(template => 'login.tt2');
}


=head1 AUTHOR

dreabalbas,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
