use utf8;
package BOA::Schema::Result::Amigo;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BOA::Schema::Result::Amigo

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

=head1 TABLE: C<amigo>

=cut

__PACKAGE__->table("amigo");

=head1 ACCESSORS

=head2 usuario1

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 usuario2

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "usuario1",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "usuario2",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</usuario1>

=item * L</usuario2>

=back

=cut

__PACKAGE__->set_primary_key("usuario1", "usuario2");

=head1 RELATIONS

=head2 usuario1

Type: belongs_to

Related object: L<BOA::Schema::Result::Usuario>

=cut

__PACKAGE__->belongs_to(
  "usuario1",
  "BOA::Schema::Result::Usuario",
  { nombreusuario => "usuario1" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 usuario2

Type: belongs_to

Related object: L<BOA::Schema::Result::Usuario>

=cut

__PACKAGE__->belongs_to(
  "usuario2",
  "BOA::Schema::Result::Usuario",
  { nombreusuario => "usuario2" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-07-15 15:43:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:S1uE9d4TMec7cL7A3nyF7A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
