define ['ng', 's/services', 'ngResource'], (angular, services) ->
	'use strict'

	services.factory 'customeraccount', ['$resource', ($resource) ->

    $resource '/api/customer-accounts/:id',
      id      : '@_id'
    ,
      getAll  : isArray:true
      update  : method:'PUT'

  ]