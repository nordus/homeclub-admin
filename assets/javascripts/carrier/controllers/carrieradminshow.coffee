define ['carrier/controllers/controllers'], (controllers) ->
	'use strict'

	controllers.controller 'carrieradminshow', ['$routeParams', '$scope', 'carrieradmin', ($routeParams, $scope, carrieradmin) ->
    carrieradmin.get id:$routeParams.id, (data) -> $scope.admin = data

    $scope.breadcrumb =
      title: 'Admins'
      link: '#/carrier-admins'

  ]