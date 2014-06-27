define ['c/controllers', 's/carrier'], (controllers) ->
	'use strict'

	controllers.controller 'carriers', ['$scope', 'carrier', ($scope, carrier) ->
    carrier.getAll {}, (data) -> $scope.carriers = data

    $scope.title = 'Carriers'

    $scope.sortOptions = [
        value: 'name', title: 'Sort by Name'
      ,
        value: 'city', title: 'Sort by City'
      ,
        value: 'state', title: 'Sort by State'
      ]

    $scope.sortOrder = $scope.sortOptions[0].value

  ]