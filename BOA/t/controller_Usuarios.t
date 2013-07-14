use strict;
use warnings;
use Test::More;


use Catalyst::Test 'BOA';
use BOA::Controller::Usuarios;

ok( request('/usuarios')->is_success, 'Request should succeed' );
done_testing();
