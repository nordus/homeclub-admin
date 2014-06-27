define ['c/controllers', 's/user'], (controllers) ->
	'use strict'

	controllers.controller 'usershow', ['$routeParams', '$scope', 'user', ($routeParams, $scope, user) ->
    user.get id:$routeParams.id, (data) -> $scope.user = data

  ]