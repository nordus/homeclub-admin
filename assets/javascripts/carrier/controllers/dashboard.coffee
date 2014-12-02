define ['carrier/controllers/controllers', 'carrier/services/aggregates'], (controllers) ->
	'use strict'

	controllers.controller 'dashboard', ['$rootScope', '$scope', 'aggregates', ($rootScope, $scope, aggregates) ->
    $scope.aggregates = aggregates.get carrier:$rootScope.currentUser.carrier._id
  ]