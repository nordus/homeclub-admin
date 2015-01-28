define ['c/controllers', 's/carrier', 's/carrieradmin', 's/customeraccount', 's/notifier', 's/user'], (controllers) ->

  controllers.controller 'carrieradmincreate', ['$location', '$routeParams', '$scope', 'carrier', 'carrieradmin', 'customeraccount', 'notifier', 'user', ($location, $routeParams, $scope, carrier, carrieradmin, customeraccount, notifier, user) ->

    $scope.carrierAdmin = new carrieradmin
    $scope.carrierAdmin.user = $routeParams.id

    carrier.query (carriers) ->
      $scope.carriers = {}
      carriers.forEach (c) ->
        @[c._id] = c.name
      , $scope.carriers

    user.get id:$routeParams.id, (userData) ->
      $scope.user = userData
      # use customerAccount.carrier to pre-populate select box
      customeraccount.get id:$scope.user.roles.customerAccount, (customerAccountData) ->
        $scope.customerAccount = customerAccountData
        $scope.carrierAdmin.carrier = $scope.customerAccount.carrier

    $scope.save = ->
      $scope.carrierAdmin.$save (ca) ->
        $scope.user.roles.carrierAdmin = ca._id
        $scope.user.$update (u) ->
          notifier.success 'Saved!'
          $location.path "/carrier-admins/#{ca._id}"

  ]