define ['ng', 'carrier/services/services', 'ngResource'], (angular, services) ->
	'use strict'

	services.factory 'customeraccount', ['$rootScope', '$resource', ($rootScope, $resource) ->

    defaultParams =
      carrier : $rootScope.currentUser.carrier._id
      id      : '@_id'

    $resource '/api/customer-accounts/:id', defaultParams,
      getAll  : isArray:true
      update  : method:'PUT'
      get:
        params:
          includeUser: true

  ]