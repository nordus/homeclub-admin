define [
  'carrier/controllers/controllers'
  'shared/services/carrieradmin'
  'shared/services/notifier'
  'shared/services/user'
], (controllers) ->

  controllers.controller 'carrieradmincreate', [
    '$rootScope'
    '$routeParams'
    '$scope'
    'carrieradmin'
    'notifier'
    'user'
    ($rootScope, $routeParams, $scope, carrieradmin, notifier, user) ->

      $scope.carrierAdmin         = new carrieradmin
      $scope.carrierAdmin.user    = $routeParams.id
      $scope.carrierAdmin.carrier = $rootScope.currentUser.carrier._id

      $scope.user = user.get id:$routeParams.id

      $scope.save = ->
        $scope.carrierAdmin.$save (ca) ->
          $scope.user.roles.carrierAdmin = ca._id
          $scope.user.$update (u) ->
            notifier.success 'Saved!'
            $location.path "/users/#{u._id}"

  ]