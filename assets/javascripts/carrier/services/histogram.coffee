define ['ng', 'carrier/services/services', 'ngResource'], (angular, services) ->
	'use strict'

	services.factory 'histogram', ['$resource', '$rootScope', ($resource, $rootScope) ->

		defaultParams =
			carrier: $rootScope.currentUser.carrier._id

		$resource '/api/histograms/:carrier', defaultParams


	]