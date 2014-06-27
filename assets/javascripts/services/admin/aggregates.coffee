define ['ng', 's/services', 'ngResource'], (angular, services) ->
	'use strict'

	services.factory 'aggregates', ['$resource', ($resource) ->

    $resource '/api/aggregates'

  ]