define ['c/controllers', 's/gateway', 's/sensorhub', 's/meta'], (controllers) ->

  controllers.controller 'sensorhubcreate', ['$location', '$routeParams', '$scope', 'meta', 'notifier', 'gateway', 'sensorhub', ($location, $routeParams, $scope, meta, notifier, gateway, sensorhub) ->
    $scope.meta = meta

    $scope.sensorHub = new sensorhub

    gateway.get id:$routeParams.gatewayId, (data) -> $scope.gateway = data

    $scope.save = ->
      if $scope.dupes
        $scope.gateway.sensorHubs.splice($scope.gateway.sensorHubs.length, 0, $scope.sensorHub._id)
        $scope.gateway.$update ->
          notifier.success "Sensor Hub #{$scope.sensorHub._id} created!"
          $location.path "/customer-accounts/#{$scope.gateway.customerAccount}/gateways/#{$scope.gateway._id}"
      else
        $scope.sensorHub.$save (sensorHub) ->
          $scope.gateway.sensorHubs.splice($scope.gateway.sensorHubs.length, 0, sensorHub._id)
          $scope.gateway.$update ->
            notifier.success "Sensor Hub #{sensorHub._id} created!"
            $location.path "/customer-accounts/#{$scope.gateway.customerAccount}/gateways/#{$scope.gateway._id}"

    $scope.dupeCheck = (form) ->
      if form.macAddress.$valid
        sensorhub.getAll {}, (sensorHubs) ->
          dupes = sensorHubs.filter (sensorHub) -> sensorHub._id is $scope.sensorHub._id
          $scope.dupes = Boolean(dupes.length)
      else
        $scope.dupes = false
  ]