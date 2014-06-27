define ['ng', 's/services', 'ngResource'], (angular, services) ->
	'use strict'

	services.factory 'gateway', ['$resource', ($resource) ->

    $resource '/api/gateways/:id',
      id      : '@_id'
    ,
      getAll  : isArray:true
      update  : method:'PUT'

  ]