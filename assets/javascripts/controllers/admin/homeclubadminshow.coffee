define ['c/controllers', 's/homeclubadmin'], (controllers) ->
	'use strict'

	controllers.controller 'homeclubadminshow', ['$routeParams', '$scope', 'homeclubadmin', ($routeParams, $scope, homeclubadmin) ->
    homeclubadmin.get id:$routeParams.id, (data) -> $scope.admin = data

    $scope.breadcrumb =
      title: 'HomeClub Admins'
      link: '#/home-club-admins'

  ]