define ['ng', 'carrier/services/services', 'ngResource'], (angular, services) ->
	'use strict'

	services.factory 'aggregates', ['$resource', ($resource) ->

    $resource '/api/aggregates'

  ]