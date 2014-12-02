define ['carrier/controllers/controllers'], (controllers) ->
	'use strict'

	controllers.controller 'nav', ['$http', '$location', '$rootScope', '$scope', ($http, $location, $rootScope, $scope) ->
    $scope.isActive = (link) ->
      $location.path().indexOf(link) is 0

    $scope.logout = ->
      $http.post('/api/logout', { logout:true }).then ->
        $rootScope.currentUser = undefined
        location.href = '/login'
  ]