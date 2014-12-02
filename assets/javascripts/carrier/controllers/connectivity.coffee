define ['carrier/controllers/controllers', 'carrier/services/histogram'], (controllers) ->

  controllers.controller 'connectivity', ['$filter', '$rootScope', '$scope', 'histogram', ($filter, $rootScope, $scope, histogram) ->

    $scope.histogramOptions =
      renderer  : 'bar'
      height    : 20
      width     : 150

    $scope.histogramFeatures =
      hover:
        formatter: (series, x, y) ->
          formattedDate = $filter('date')(x*1000, 'MMM dd, h:mma')
          date = "<span class='date'>#{formattedDate}</span>"
          "#{parseInt(y)} messages<br>#{date}"

    histogram.get {}, (data) -> $scope.histograms = data

  ]