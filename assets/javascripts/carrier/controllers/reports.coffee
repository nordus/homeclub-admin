define ['carrier/controllers/controllers', 'carrier/services/search', 'carrier/services/buildurl', 'shared/services/auth-token'], (controllers) ->

	controllers.controller 'reports', ['$location', '$rootScope', '$scope', 'search', 'buildurl', 'AuthTokenFactory', ($location, $rootScope, $scope, search, buildurl, AuthTokenFactory) ->

#	  $scope.searchParams =
#	    carrier     : $rootScope.currentUser.carrier._id
#	    msgType     : $routeParams.msgType
#	    fields      : ['sensorHubData1', 'sensorHubData2', 'sensorHubData3']
#	    offset      : 0
#	    start       : '30 days ago'
#
#    $scope.downloadUrl = ->
#      params = angular.extend { download:'true', limit:5000000 }, $scope.searchParams
#      baseUrl = "http://#{$location.host()}/api/search"
#      buildurl(baseUrl, params)
#
#    getStatResults = ->
#      return if $routeParams.msgType isnt '5'
#      search.sensorHubStats $scope.searchParams, (resp) -> $scope.statResults = resp
#
#    getSearchResults = ->
#      params = angular.extend { limit:20, filtered:true }, $scope.searchParams
#      search.sensorHubData params, (resp) -> $scope.searchResults = resp
#
#    getStatResults()
#    getSearchResults()
#
#    $scope.$watch 'searchParams.offset', (oldVal, newVal) ->
#      if oldVal isnt newVal
#        getSearchResults()
#
#    $scope.$watch 'searchParams.start', (oldVal, newVal) ->
#      if oldVal isnt newVal
#        $scope.searchParams.offset = 0
#        getStatResults()
#        getSearchResults()

    $scope.token  = AuthTokenFactory.getToken()

    $scope.reportParams =
      carrier : $rootScope.currentUser.carrier._id
      endDt     : new Date()
      fields  : ['sensorHubData1', 'sensorHubData2', 'sensorHubData3']
      startDt   : undefined
      token     : $scope.token

    $scope.downloadUrlByMsgType = (msgType) ->
      paramsToMerge = { msgType:msgType, download:'true', limit:5000000 }
      if $scope.reportParams.endDt
        paramsToMerge.end = $scope.reportParams.endDt.toDateString()
      if $scope.reportParams.startDt
        paramsToMerge.start = $scope.reportParams.startDt.toDateString()
      params = angular.extend paramsToMerge, $scope.reportParams
      baseUrl = "http://#{$location.host()}/api/search"
      buildurl(baseUrl, params)
  ]
