define ['c/controllers', 's/carrier', 's/customeraccount', 's/notifier'], (controllers) ->
	'use strict'

	controllers.controller 'customeraccounts', ['$routeParams', '$scope', 'carrier', 'customeraccount', 'notifier', ($routeParams, $scope, carrier, customerAccount, notifier) ->
    customerAccount.getAll {}, (data) -> $scope.accounts = data

    carrier.getAll {}, (data) -> $scope.carriers = data

    $scope.selectedCarrier = $routeParams.carrier

    $scope.breadcrumb =
      title: 'Accounts'

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

    $scope.accountStatuses = ['New', 'Active', 'Suspended', 'Cancelled']

    $scope.save = ( account ) ->
      account.$update()
      notifier.success 'Saved!'

  ]