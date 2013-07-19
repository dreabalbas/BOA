=head2 url_create
 
Create a book with the supplied title, rating, and author
 
=cut
 
sub url_create :Local {
    # In addition to self & context, get the title, rating, &
    # author_id args from the URL.  Note that Catalyst automatically
    # puts extra information after the "/<controller_name>/<action_name/"
    # into @_.  The args are separated  by the '/' char on the URL.
    my ($self, $c, $autor, $contenido, $fecha) = @_;
 
    # Call create() on the book model object. Pass the table
    # columns/field values we want to set as hash values
    my $boa = $c->model('DB::Boa')->create({
            autor  => $autor,
            contenido => $contenido,
            fecha => $fecha
        });
 
    # Add a record to the join table for this book, mapping to
    # appropriate author
    $boa->agregar_autor_boa({autor => $autor});
    # Note: Above is a shortcut for this:
    # $book->create_related('book_authors', {author_id => $author_id});
 
    # Assign the Book object to the stash for display and set template
    $c->stash(boa     => $boa,
              template => 'boas/boa_creada.tt2');
 
    # Disable caching for this page
    $c->response->header('Cache-Control' => 'no-cache');
}