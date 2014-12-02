define ['ng', 'carrier/services/services', 'ngResource'], (angular, services) ->
	'use strict'

	services.factory 'carrieradmin', ['$resource', '$rootScope', ($resource, $rootScope) ->

    defaultParams =
      carrier : $rootScope.currentUser.carrier._id
      id      : '@_id'

    $resource '/api/carrier-admins/:id', defaultParams

  ]