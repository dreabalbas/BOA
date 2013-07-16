package BOA::Form::Usuario;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
use namespace::autoclean;

has '+item_class' => ( default =>'Usuarios' );
has_field 'nombreusuario' => ( type => 'Text', apply => [{check  => qr/^[0-9a-z]*\z/,
				message => 'Contains invalid characters'}] );
has_field 'nombres' => ( type => 'Text' );
has_field 'apellidos' => ( type => 'Text');
has_field 'email' => ( type => 'Email');
has_field 'submit' => ( type => 'Submit', value => 'Submit' );

__PACKAGE__->meta->make_immutable;
1;