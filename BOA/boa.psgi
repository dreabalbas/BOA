use strict;
use warnings;

use BOA;

my $app = BOA->apply_default_middlewares(BOA->psgi_app);
$app;

