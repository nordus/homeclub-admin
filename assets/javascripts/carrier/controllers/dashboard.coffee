define ['carrier/controllers/controllers', 'carrier/services/aggregates'], (controllers) ->
	'use strict'

	controllers.controller 'dashboard', ['$filter', '$http', '$rootScope', '$scope', 'aggregates', ($filter, $http, $rootScope, $scope, aggregates) ->
    $scope.aggregates = aggregates.get carrier:$rootScope.currentUser.carrier._id

    url   = "/api/google-analytics/page-views?carrier=#{$rootScope.currentUser.carrier._id}"

    $http.get( url )
      .success ( resp ) ->

        $scope.stats  = resp

        $scope.histogramOptions =
          renderer  : 'bar'
          height    : 53

        $scope.histogramFeatures =
          hover:
            formatter: (series, x, y) ->
              formattedDate = $filter( 'date' )( x, 'MMM dd' )

              "#{y} #{series.name}<br><span class='date'>#{formattedDate}</span>"
  ]