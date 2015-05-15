define ['c/controllers', 's/carrier', 's/customeraccount', 's/outboundcommand'], (controllers) ->

  controllers.controller 'outboundcommands', ['$routeParams', '$scope', 'carrier', 'customeraccount', 'outboundcommand', ($routeParams, $scope, carrier, customeraccount, outboundcommand) ->

    $scope.outboundCommands = outboundcommand.query()

    carrier.getAll {}, (data) -> $scope.carriers = data

    $scope.selectedCarrier = $routeParams.carrier
    $scope.searchText = $routeParams.customerAccount

    $scope.breadcrumb =
      title: 'Outbound Commands'

    $scope.sortOptions = [
      value: '-sentAt', title: 'Sort by Sent At'
    ,
      value: ['msgType', 'params.action', '-sentAt'], title: 'Sort by Type'
    ]

    $scope.sortOrder = $scope.sortOptions[0].value

    customeraccount.query (accounts) ->
      $scope.formattedNames = {}
      accounts.forEach (account) ->
        $scope.formattedNames[account._id] = [
          account.name.first
          account.name.last
          ('(..' + account._id.substr(-4) + ')')
        ].join ' '

    $scope.msgTypesFormatted = (msgType, action) ->

      msgTypes =
        HC1:
          '0': 'No action'
          '1': 'Reset network hub'
          '3': 'Add MAC to white list'
          '4': 'Remove MAC from white list'
          '5': 'Request MAC white list'
          '6': 'Change heartbeat frequency'
        HC2:
          '0': 'No action'
          '1': 'Update sensorHubType 1 (Water)'
          '2': 'Update sensorHubType 2 (Indoor Climate)'
          '3': 'Update sensorHubType 3 (Item Movement)'
          '4': 'Update sensorHubType 4 (Human Motion)'

      "#{[msgType,action].join('/')} - #{msgTypes[msgType][action]}"

  ]