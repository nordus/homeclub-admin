define ['ng', 's/services', 'ngResource'], (angular, services) ->
	'use strict'

	services.factory 'carrier', ['$resource', ($resource) ->

    activity = $resource '/api/carriers/:id',
      id      : '@_id'
    ,
      getAll  : isArray:true

  ]