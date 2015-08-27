define [
  'carrier/controllers/controllers'
  'carrier/services/customeraccount'
], (controllers) ->
	'use strict'

	controllers.controller 'customeraccounts', [
	  '$filter'
	  '$http'
	  '$rootScope'
	  '$routeParams'
	  '$scope'
	  'customeraccount'
	  ($filter, $http, $rootScope, $routeParams, $scope, customerAccount) ->
      customerAccount.getAll {}, (data) ->
        $scope.accounts = data
  
        $scope.accountIds = data.map ( account ) -> account._id
  
        query = '?accountIds=' + $scope.accountIds.join '&accountIds='
        url   = '/api/google-analytics/page-views' + query
  
        $http.get( url )
          .success ( resp ) ->
  
            $scope.stats  = resp
  
            $scope.histogramOptions =
              renderer  : 'bar'
              height    : 34
              width     : 150
  
            $scope.histogramFeatures =
              hover:
                formatter: (series, x, y) ->
                  formattedDate = $filter( 'date' )( x, 'MMM dd' )
  
                  "#{y} #{series.name}<br><span class='date'>#{formattedDate}</span>"
  
  
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
      ,
        value: 'shipDate', title: 'Sort by Ship Date'
      ]
  
      $scope.sortOrder = $scope.sortOptions[0].value

  ]