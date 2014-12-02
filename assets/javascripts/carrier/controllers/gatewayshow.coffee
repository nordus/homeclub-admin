define ['carrier/controllers/controllers', 'carrier/services/customeraccount', 'carrier/services/gateway'], (controllers) ->

  controllers.controller 'gatewayshow', ['$routeParams', '$scope', 'gateway', 'customeraccount', ($routeParams, $scope, gateway, account) ->
    gateway.get id:$routeParams.id, (data) -> $scope.gateway = data
    account.get id:$routeParams.accountId, (data) ->
      $scope.account = data

  ]