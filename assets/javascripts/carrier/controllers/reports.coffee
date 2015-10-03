define [
  'carrier/controllers/controllers'
  'carrier/services/search'
  'carrier/services/buildurl'
  'shared/services/auth-token'
], (controllers) ->

	controllers.controller 'reports', [
    '$location'
    '$scope'
    'search'
    'buildurl'
    'AuthTokenFactory'
    ($location, $scope, search, buildurl, AuthTokenFactory) ->

      $scope.token  = AuthTokenFactory.getToken()

      $scope.reportParams =
        end     : new Date()
        token   : $scope.token

      $scope.downloadUrlByMsgType = (msgType) ->
        baseUrl = "http://#{$location.host()}/api/search"
        params  = angular.extend {}, $scope.reportParams,
          download  : true
          end       : $scope.reportParams.end.toDateString() + ' 23:59:59 -1200'
          limit     : 5000000
          msgType   : msgType
          start     : $scope.reportParams.start?.toDateString()

        buildurl(baseUrl, params)
  ]
