define ['c/controllers', 's/customeraccount', 's/outboundsms'], (controllers) ->

  controllers.controller 'outboundsms', ['$scope', 'customeraccount', 'outboundsms', ($scope, customeraccount, outboundsms) ->

    $scope.breadcrumb =
      title : 'Outbound SMS'

    $scope.sortOptions = [
      value: '-reading.updateTime', title: 'Sort by Timestamp'
    ,
      value: 'customerAccount', title: 'Sort by Recipient'
    ,
      value: 'reading.msgType', title: 'Sort by Type'
    ]

    $scope.sortOrder = $scope.sortOptions[0].value

    $scope.outboundSms = outboundsms.query()

    customeraccount.query (accounts) ->
      $scope.formattedNames = {}
      accounts.forEach (account) ->
        $scope.formattedNames[account._id] = [
          account.name.first
          account.name.last
          ('(..' + account._id.substr(-4) + ')')
        ].join ' '

  ]