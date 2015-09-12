define ['carrier/controllers/controllers', 'shared/services/user'], ( controllers ) ->

	controllers.controller 'users', ['$rootScope', '$scope', 'user', ($rootScope, $scope, user) ->
    params =
      carrier : $rootScope.currentUser.carrier._id

    $scope.users = user.query params

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