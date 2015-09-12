define ['ng', 'shared/services/sharedservices', 'ngResource'], (angular, services) ->
	'use strict'

	services.factory 'carrieradmin', ['$resource', ($resource) ->

    $resource '/api/carrier-admins/:id',
      id      : '@_id'

  ]