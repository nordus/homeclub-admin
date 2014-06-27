define ['c/controllers', 's/customeraccount', 's/gateway'], (controllers) ->

  controllers.controller 'gatewayshow', ['$routeParams', '$scope', 'gateway', 'customeraccount', ($routeParams, $scope, gateway, account) ->
    gateway.get id:$routeParams.id, (data) -> $scope.gateway = data
    account.get id:$routeParams.accountId, (data) ->
      $scope.account = data

  ]