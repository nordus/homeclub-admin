define ['c/controllers', 's/customeraccount', 's/gateway', 's/notifier', 's/sensorhub', 's/meta'], (controllers) ->

  controllers.controller 'networkhubs', ['$scope', 'customeraccount', 'gateway', 'notifier', 'sensorhub', 'meta', ($scope, customeraccount, gateway, notifier, sensorhub, meta) ->

    $scope.meta = meta

    $scope.networkHubs = gateway.query()

    sensorhub.query (sensorHubs) ->
      $scope.sensorHubTypeByMac = {}
      sensorHubs.forEach (sh) ->
        @[sh._id] = meta.sensorHubTypes[sh.sensorHubType]
      , $scope.sensorHubTypeByMac

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

    $scope.save = (networkHub) ->
      unless Array.isArray(networkHub.sensorHubs)
        networkHub.sensorHubs = networkHub.sensorHubs.split ','
      networkHub.$update (updatedNetworkHub) ->
        notifier.success 'Saved!'

    $scope.delete = (networkHub) ->
      if confirm "Delete #{networkHub._id}?"
        networkHub.$delete (deletedNetworkHub) ->
          notifier.success "Network Hub #{networkHub._id} deleted!"

  ]