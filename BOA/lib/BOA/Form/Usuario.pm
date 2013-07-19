package BOA::Form::Usuario;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
use namespace::autoclean;

has '+item_class' => ( default =>'Usuarios' );
has_field 'nombreusuario' => ( type => 'Text', required => 1, maxlength => 20, 
				apply => [{check  => qr/^[0-9a-z]*\z/,
				message => 'Contains invalid characters'}] );
has_field 'nombres' => ( type => 'Text', required => 1, maxlength => 60 );
has_field 'apellidos' => ( type => 'Text', required => 1, maxlength => 60);
has_field 'email' => ( type => 'Email', required => 1);
has_field 'contrasena' => ( type => 'Text', required => 1, maxlength => 20);
has_field 'submit' => ( type => 'Submit', value => 'Guardar' );

__PACKAGE__->meta->make_immutable;
1;