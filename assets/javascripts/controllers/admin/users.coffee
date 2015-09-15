define ['c/controllers', 'c/rolemgr', 's/user'], (controllers, RoleMgr) ->

	controllers.controller 'users', ['$controller', '$location', '$scope', 'notifier', 'user', ($controller, $location, $scope, notifier, user) ->
#    user.getAll {}, (data) -> $scope.users = data
    $scope.users = user.query()

    $scope.delete = ( user ) ->
      if confirm "Are you sure you want to delete #{user.email}?"
        user.$delete ->
          notifier.success 'Deleted!'
          $scope.users = $scope.users.filter ( u ) -> u._id != user._id

    # handles deleting / disassociating role
    $scope.roleMgr = $controller RoleMgr,
      $scope: $scope.$new()

    $scope.breadcrumb =
      title: 'Users'

    $scope.sortOptions = [
      value: 'email', title: 'Sort by Email'
    ,
      value: 'createdAt', title: 'Sort by Created (ascending)'
    ,
      value: '-createdAt', title: 'Sort by Created (descending)'
    ]

    $scope.sortOrder = $scope.sortOptions[0].value
  ]