use utf8;
package BOA::Schema::Result::Usuario;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BOA::Schema::Result::Usuario

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<usuario>

=cut

__PACKAGE__->table("usuario");

=head1 ACCESSORS

=head2 nombreusuario

  data_type: 'text'
  is_nullable: 0

=head2 nombres

  data_type: 'text'
  is_nullable: 1

=head2 apellidos

  data_type: 'text'
  is_nullable: 1

=head2 email

  data_type: 'text'
  is_nullable: 1

=head2 contrasena

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "nombreusuario",
  { data_type => "text", is_nullable => 0 },
  "nombres",
  { data_type => "text", is_nullable => 1 },
  "apellidos",
  { data_type => "text", is_nullable => 1 },
  "email",
  { data_type => "text", is_nullable => 1 },
  "contrasena",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</nombreusuario>

=back

=cut

__PACKAGE__->set_primary_key("nombreusuario");

=head1 RELATIONS

=head2 boas

Type: has_many

Related object: L<BOA::Schema::Result::Boa>

=cut

__PACKAGE__->has_many(
  "boas",
  "BOA::Schema::Result::Boa",
  { "foreign.autor" => "self.nombreusuario" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-07-19 12:44:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FYklK3ktyM8C2fxFHKOJXQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
