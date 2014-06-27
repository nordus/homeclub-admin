define ['c/controllers', 's/carrier', 's/notifier'], (controllers) ->
	'use strict'

	controllers.controller 'carriercreate', ['$location', '$routeParams', '$scope', 'carrier', 'notifier', ($location, $routeParams, $scope, carrier, notifier) ->
    $scope.carrier = new carrier

    $scope.save = ->
      $scope.carrier.$save (carrier) ->
        $location.path "/carriers/#{carrier._id}"
        notifier.success "#{carrier.name} saved!"

  ]