define ['c/controllers', 'c/rolemgr', 's/user'], (controllers, RoleMgr) ->

	controllers.controller 'users', ['$controller', '$scope', 'user', ($controller, $scope, user) ->
    user.getAll {}, (data) -> $scope.users = data

    $scope.roleMgr = $controller RoleMgr,
      $scope: $scope.$new()
  ]