use utf8;
package BOA::Schema::Result::Boa;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BOA::Schema::Result::Boa

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

=head1 TABLE: C<boa>

=cut

__PACKAGE__->table("boa");

=head1 ACCESSORS

=head2 autor

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 contenido

  data_type: 'text'
  is_nullable: 0

=head2 fecha

  data_type: 'timestamp'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "autor",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "contenido",
  { data_type => "text", is_nullable => 0 },
  "fecha",
  { data_type => "timestamp", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</autor>

=item * L</contenido>

=back

=cut

__PACKAGE__->set_primary_key("autor", "contenido");

=head1 RELATIONS

=head2 autor

Type: belongs_to

Related object: L<BOA::Schema::Result::Usuario>

=cut

__PACKAGE__->belongs_to(
  "autor",
  "BOA::Schema::Result::Usuario",
  { nombreusuario => "autor" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07036 @ 2013-07-19 12:26:34
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:bBBt19EEhhtwNQHACj146w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
