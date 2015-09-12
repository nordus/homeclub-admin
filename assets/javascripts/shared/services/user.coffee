define ['ng', 'shared/services/sharedservices', 'ngResource'], (angular, sharedservices) ->
	'use strict'

	sharedservices.factory 'user', ['$resource', ($resource) ->

    $resource '/api/users/:id',
      id      : '@_id'
    ,
      update  : method:'PUT'

  ]