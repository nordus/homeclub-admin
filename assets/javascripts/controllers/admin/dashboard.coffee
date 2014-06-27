define ['c/controllers', 's/aggregates'], (controllers) ->
	'use strict'

	controllers.controller 'dashboard', ['$scope', 'aggregates', ($scope, aggregates) ->
    $scope.aggregates = aggregates.get()
  ]