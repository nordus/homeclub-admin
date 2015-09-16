define ['c/controllers', 's/aggregates'], (controllers) ->
	'use strict'

	controllers.controller 'dashboard', ['$http', '$scope', 'aggregates', ($http, $scope, aggregates) ->
    $scope.aggregates = aggregates.get()

    url   = "/api/google-analytics/page-views"

    $http.get( url )
      .success ( resp ) ->

        $scope.stats  = resp

        $scope.histogramOptions =
          renderer  : 'bar'
          height    : 39
          resize    : true

        $scope.histogramFeatures =
          hover:
            formatter: (series, x, y) ->
              formattedDate = $filter( 'date' )( x, 'MMM dd' )

              "#{y} #{series.name}<br><span class='date'>#{formattedDate}</span>"

  ]
