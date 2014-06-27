define ['c/controllers', 's/carrier'], (controllers) ->
	'use strict'

	controllers.controller 'import', ['$scope', '$http', '$location', 'carrier', ($scope, $http, $location, carrier) ->
    carrier.getAll {}, (data) ->
      $scope.carriers = data
      $scope.selectedCarrier = data[0]?._id


    $scope.preview = (form) ->
      $scope.loading = true
      $scope.accounts = undefined
      $scope.duplicateAccounts = undefined

      $http.post '/api/import-google-doc/preview',
        url: $scope.url
      .success (response) =>

        $scope.loading = false

        if response.duplicateAccounts
          # IE9+ required for Object.keys
          $scope.keys = Object.keys response.duplicateAccounts[0]
          $scope.duplicateAccounts = response.duplicateAccounts

        else
          $scope.keys = Object.keys response.accounts[0]
          $scope.accounts = response.accounts


    $scope.save = ->
      $http.post '/api/import-google-doc',
        accounts: $scope.accounts
        carrier: $scope.selectedCarrier
      .success (response) =>
        $location.path '/customer-accounts'

  ]