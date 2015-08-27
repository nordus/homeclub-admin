define ['carrier/controllers/controllers', 'carrier/services/histogram', 'carrier/services/sensorhub', 'shared/services/meta'], (controllers) ->

  controllers.controller 'connectivity', ['$filter', '$rootScope', '$scope', 'histogram', 'sensorhub', 'meta', ($filter, $rootScope, $scope, histogram, sensorhub, meta) ->

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

    $scope.sensorHubs = sensorhub.query
      carrier : $rootScope.currentUser.carrier._id

    $scope.sensorHubType = ( sensorHubMac ) ->
      sensorHub = $scope.sensorHubs.filter ( sh ) ->
        sh._id == sensorHubMac
      .pop()

      meta.sensorHubTypes[sensorHub.sensorHubType]

  ]