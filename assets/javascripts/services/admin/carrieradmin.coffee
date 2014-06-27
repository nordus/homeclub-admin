define ['ng', 's/services', 'ngResource'], (angular, services) ->
	'use strict'

	services.factory 'carrieradmin', ['$resource', ($resource) ->

    $resource '/api/carrier-admins/:id',
      id      : '@_id'
    ,
      getAll  : isArray:true

  ]