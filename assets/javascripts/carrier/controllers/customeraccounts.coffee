define ['carrier/controllers/controllers', 'carrier/services/customeraccount'], (controllers) ->
	'use strict'

	controllers.controller 'customeraccounts', ['$rootScope', '$routeParams', '$scope', 'customeraccount', ($rootScope, $routeParams, $scope, customerAccount) ->
    customerAccount.getAll {}, (data) -> $scope.accounts = data

    #carrier.getAll {}, (data) -> $scope.carriers = data

    #$scope.selectedCarrier = $routeParams.carrier
    #$scope.selectedCarrier = $rootScope.currentUser.carrier._id

    $scope.breadcrumb =
      title: 'Customers'

    $scope.sortOptions = [
      value: 'name.last', title: 'Sort by Last Name'
    ,
      value: 'name.first', title: 'Sort by First Name'
    ,
      value: 'city', title: 'Sort by City'
    ,
      value: 'state', title: 'Sort by State'
    ]

    $scope.sortOrder = $scope.sortOptions[0].value

  ]