define ['c/controllers', 's/carrier'], (controllers) ->
	'use strict'

	controllers.controller 'carrieradminshow', ['$routeParams', '$scope', 'carrieradmin', ($routeParams, $scope, carrieradmin) ->
    carrieradmin.get id:$routeParams.id, (data) -> $scope.admin = data

    $scope.breadcrumb =
      title: 'Carrier Admins'
      link: '#/carrier-admins'

  ]