define ['c/controllers', 's/gateway'], (controllers) ->

  controllers.controller 'hc2create', ['$scope', 'gateway', ($scope, gateway) ->

    $scope.hc2Fields = ['sequenceNumber', 'action', 'sensorHubMac', 'nbrOfBytes', 'temperatureMax', 'temperatureMin', 'lightMax', 'lightMin', 'humidityMax', 'humidityMin']

    $scope.networkHubs = gateway.query()

  ]