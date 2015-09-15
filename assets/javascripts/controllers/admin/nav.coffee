define ['c/controllers', 'shared/services/auth-token'], (controllers) ->
	'use strict'

	controllers.controller 'nav', [
    '$http'
    '$location'
    '$rootScope'
    '$scope'
    'AuthTokenFactory'
    ($http, $location, $rootScope, $scope, AuthTokenFactory) ->
      $scope.isActive = (link) ->
        $location.path().indexOf(link) is 0

      $scope.logout = ->
        $rootScope.currentUser = undefined
        AuthTokenFactory.setToken null
        location.href = '/login'
  ]