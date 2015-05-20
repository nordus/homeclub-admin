define ['c/controllers', 's/gateway'], (controllers) ->

  controllers.controller 'hc2create', ['$scope', 'gateway', ($scope, gateway) ->

    $scope.hc2Fields = ['action', 'sensorHubMac', 'nbrOfBytes', 'temperatureMax', 'temperatureMin', 'lightMax', 'lightMin', 'humidityMax', 'humidityMin']

    $scope.networkHubs = gateway.query()

    $scope.hasPendingOutboundCommand = (item) ->
      item.pendingOutboundCommand != undefined

    $scope.send = ->
      $http.post('/api/hc2', {formInputs:$scope.formInputs, recipients:$scope.recipients}).success (data) ->
        $scope.data = data

  ]