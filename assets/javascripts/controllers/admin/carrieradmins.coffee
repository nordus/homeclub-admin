define ['c/controllers', 's/carrieradmin', 's/carrier'], (controllers) ->
	'use strict'

	controllers.controller 'carrieradmins', ['$location', '$routeParams', '$scope', 'carrieradmin', 'carrier', ($location, $routeParams, $scope, carrierAdmin, carrier) ->
    $scope.breadcrumb =
      title: 'Carrier Admins'

    $scope.sortOptions = [
      value: 'name.last', title: 'Sort by Last Name'
    ,
      value: 'name.first', title: 'Sort by First Name'
    ]

    $scope.sortOrder = $scope.sortOptions[0].value

    carrierAdmin.getAll {}, (data) -> $scope.admins = data

    carrier.getAll {}, (data) -> $scope.carriers = data

    $scope.show = (id) ->
      $location.path "/carrier-admins/#{id}"

    $scope.selectedCarrier = $routeParams.carrier

  ]