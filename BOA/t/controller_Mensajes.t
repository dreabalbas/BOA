use strict;
use warnings;
use Test::More;


use Catalyst::Test 'BOA';
use BOA::Controller::Mensajes;

ok( request('/mensajes')->is_success, 'Request should succeed' );
done_testing();
