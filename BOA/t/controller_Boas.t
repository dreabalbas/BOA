use strict;
use warnings;
use Test::More;


use Catalyst::Test 'BOA';
use BOA::Controller::Boas;

ok( request('/boas')->is_success, 'Request should succeed' );
done_testing();
