define ['c/controllers', 's/customeraccount', 's/gateway'], (controllers) ->

  controllers.controller 'gatewaycreate', ['$location', '$routeParams', '$scope', 'notifier', 'gateway', 'customeraccount', ($location, $routeParams, $scope, notifier, gateway, account) ->
    $scope.gateway = new gateway
    account.get id:$routeParams.accountId, (data) ->
      $scope.account = data

    $scope.save = ->
      $scope.gateway.customerAccount = $routeParams.accountId
      $scope.gateway.$save (gateway) ->
        $scope.account.gateways.splice($scope.account.gateways.length, 0, gateway._id)
        $scope.account.$update ->
          notifier.success "Gateway #{gateway._id} added!"
          $location.path "/customer-accounts/#{gateway.customerAccount}/gateways/#{gateway._id}"

    $scope.dupeCheck = (form) ->
      if form.macAddress.$valid
        gateway.getAll {}, (gateways) ->
          dupes = gateways.filter (gateway) -> gateway._id is $scope.gateway._id
          $scope.dupes = Boolean(dupes.length)
      else
        $scope.dupes = false
  ]