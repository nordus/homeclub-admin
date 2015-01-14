define ['c/controllers', 's/customeraccount', 's/gateway'], (controllers) ->

  controllers.controller 'networkhubs', ['$scope', 'customeraccount', 'gateway', ($scope, customeraccount, gateway) ->

    $scope.networkHubs = gateway.query()
    customeraccount.query
      select: 'name'
    , (customers) ->
        $scope.customerNames = {}
        customers.forEach (c) ->
          @[c._id] = "#{c.name.first} #{c.name.last} (..#{c._id.substr(-4)})"
        , $scope.customerNames

    $scope.title = 'Network Hubs'

    $scope.sortOptions = [
      value: 'customerAccount', title: 'Sort by Customer'
    ,
      value: '_id', title: 'Sort by MAC'
    ]

    $scope.sortOrder = $scope.sortOptions[0].value

  ]