define ['c/controllers', 's/carrier', 's/homeclubadmin'], (controllers) ->
	'use strict'

	controllers.controller 'homeclubadmins', ['$location', '$scope', 'carrier', 'homeclubadmin', ($location, $scope, carrier, homeClubAdmin) ->

    homeClubAdmin.getAll {}, (data) -> $scope.admins = data

    $scope.breadcrumb =
      title: 'HomeClub Admins'

    $scope.sortOptions = [
      value: 'name.last', title: 'Sort by Last Name'
    ,
      value: 'name.first', title: 'Sort by First Name'
    ]

    $scope.sortOrder = $scope.sortOptions[0].value

    carrier.getAll {}, (data) -> $scope.carriers = data

    $scope.show = (id) ->
      $location.path "/home-club-admins/#{id}"

  ]