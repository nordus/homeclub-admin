define ['carrier/controllers/controllers', 'carrier/services/search', 'carrier/services/buildurl'], (controllers) ->

	controllers.controller 'reports', ['$location', '$rootScope', '$routeParams', '$scope', 'search', 'buildurl', ($location, $rootScope, $routeParams, $scope, search, buildurl) ->

	  $scope.searchParams =
	    carrier     : $rootScope.currentUser.carrier._id
	    msgType     : $routeParams.msgType
	    fields      : ['sensorHubData1', 'sensorHubData2', 'sensorHubData3']
	    offset      : 0
	    start       : '30 days ago'

    $scope.downloadUrl = ->
      params = angular.extend { download:'true', limit:5000000 }, $scope.searchParams
      baseUrl = "http://#{$location.host()}/api/search"
      buildurl(baseUrl, params)

    getStatResults = ->
      return if $routeParams.msgType isnt '5'
      search.sensorHubStats $scope.searchParams, (resp) -> $scope.statResults = resp

    getSearchResults = ->
      params = angular.extend { limit:20, filtered:true }, $scope.searchParams
      search.sensorHubData params, (resp) -> $scope.searchResults = resp

    getStatResults()
    getSearchResults()

    $scope.$watch 'searchParams.offset', (oldVal, newVal) ->
      if oldVal isnt newVal
        getSearchResults()

    $scope.$watch 'searchParams.start', (oldVal, newVal) ->
      if oldVal isnt newVal
        $scope.searchParams.offset = 0
        getStatResults()
        getSearchResults()
  ]