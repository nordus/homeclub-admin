define ['c/controllers', 'c/rolemgr', 's/user'], (controllers, RoleMgr) ->

	controllers.controller 'users', ['$controller', '$scope', 'user', ($controller, $scope, user) ->
    user.getAll {}, (data) -> $scope.users = data

    $scope.roleMgr = $controller RoleMgr,
      $scope: $scope.$new()

    $scope.title = 'Users'

    $scope.sortOptions = [
      value: 'email', title: 'Sort by Email'
    ,
      value: 'createdAt', title: 'Sort by Created (ascending)'
    ,
      value: '-createdAt', title: 'Sort by Created (descending)'
    ]

    $scope.sortOrder = $scope.sortOptions[0].value
  ]