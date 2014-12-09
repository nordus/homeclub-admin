define ['ng', 's/services', 'ngResource'], (angular, services) ->
	'use strict'

	services.factory 'histogram', ['$resource', '$rootScope', ($resource, $rootScope) ->

		$resource '/api/histograms'


	]