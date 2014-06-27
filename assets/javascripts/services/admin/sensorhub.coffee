define ['ng', 's/services', 'ngResource'], (angular, services) ->
	'use strict'

	services.factory 'sensorhub', ['$resource', ($resource) ->

    $resource '/api/sensor-hubs/:id',
      id      : '@_id'
    ,
      getAll  : isArray:true
      update  : method:'PUT'

  ]