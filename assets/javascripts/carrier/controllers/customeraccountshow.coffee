define ['carrier/controllers/controllers', 'carrier/services/customeraccount'], (controllers) ->
	'use strict'

	controllers.controller 'customeraccountshow', ['$routeParams', '$scope', 'customeraccount', ($routeParams, $scope, customeraccount) ->
    customeraccount.get id:$routeParams.id, (data) -> $scope.account = data

  ]