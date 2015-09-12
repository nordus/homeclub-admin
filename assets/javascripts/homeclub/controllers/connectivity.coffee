define ['c/controllers', 'homeclub/services/histogram', 'shared/services/meta', 's/sensorhub'], (controllers) ->

  controllers.controller 'connectivity', ['$filter', '$rootScope', '$scope', 'histogram', 'meta', 'sensorhub', ($filter, $rootScope, $scope, histogram, meta, sensorhub) ->

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

    $scope.sensorHubs = sensorhub.query()

    $scope.sensorHubType = ( sensorHubMac ) ->
      sensorHub = $scope.sensorHubs.filter ( sh ) ->
        sh._id == sensorHubMac
      .pop()

      meta.sensorHubTypes[sensorHub.sensorHubType]
  ]