define ['ng', 'carrier/services/services', 'ngResource'], (angular, services) ->
	'use strict'

	services.factory 'search', ['$resource', '$rootScope', ($resource, $rootScope) ->

		defaultParams =
			carrier	: $rootScope.currentUser.carrier._id
			limit		: 10000

		# gateways attribute exists on CustomerAccount.
		# not present when currentUser is HomeClubAdmin
		if $rootScope.currentUser.gateways
		  defaultParams.macAddress = $rootScope.currentUser.gateways[0]._id
		  defaultParams.sensorHubMacAddresses = $rootScope.currentUser.gateways[0].sensorHubs

		search = $resource '/api/search', defaultParams, {getAll:{isArray:true}}
		stats = $resource '/api/stats'


		all: (params, success) ->
			results = search.getAll params, ->
				success results
		
		sensorHubData: (params, success) ->
			params = angular.extend({msgType:5}, params)
			
			results = search.query params, ->
				success results

		sensorHubStats: (params, success) ->
			results = stats.get params, ->
				success results

		gatewayEvents: (params, success) ->
			params = angular.extend({msgType:2}, params)
			
			results = search.getAll params, ->
				success results

		sensorHubEvents: (params, success) ->
			params = angular.extend({msgType:4}, params)

			results = search.getAll params, ->
				success results

	]