define ['ng', 's/services', 'ngResource'], (angular, services) ->
	'use strict'

	services.factory 'homeclubadmin', ['$resource', ($resource) ->

    $resource '/api/home-club-admins/:id',
      id      : '@_id'
    ,
      getAll  : isArray:true

  ]