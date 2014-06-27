define ['c/controllers', 's/carrier'], (controllers) ->
	'use strict'

	controllers.controller 'carriershow', ['$routeParams', '$scope', 'carrier', ($routeParams, $scope, carrier) ->
    carrier.get id:$routeParams.id, (data) -> $scope.carrier = data

  ]