//require('coffee-script/register');
var trans = require( 'coffee-script' );
if ( trans.register )  trans.register();


module.exports = require('./server').startServer;
