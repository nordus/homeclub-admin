define ['carrier/controllers/controllers', 'carrier/services/carrieradmin'], (controllers) ->
	'use strict'

	controllers.controller 'carrieradmins', ['$location', '$rootScope', '$routeParams', '$scope', 'carrieradmin', ($location, $rootScope, $routeParams, $scope, carrierAdmin) ->
    $scope.breadcrumb =
      title: 'Admins'

    $scope.sortOptions = [
      value: 'name.last', title: 'Sort by Last Name'
    ,
      value: 'name.first', title: 'Sort by First Name'
    ]

    $scope.sortOrder = $scope.sortOptions[0].value

    carrierAdmin.query {}, (data) -> $scope.admins = data

    #carrier.getAll {}, (data) -> $scope.carriers = data

    $scope.show = (id) ->
      $location.path "/carrier-admins/#{id}"

    #$scope.selectedCarrier = $routeParams.carrier
    #$scope.selectedCarrier = $rootScope.currentUser.carrier._id

  ]