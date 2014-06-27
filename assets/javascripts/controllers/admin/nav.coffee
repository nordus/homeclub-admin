define ['c/controllers'], (controllers) ->
	'use strict'

	controllers.controller 'nav', ['$location', '$scope', ($location, $scope) ->
    $scope.isActive = (link) ->
      $location.path().indexOf(link) is 0
  ]