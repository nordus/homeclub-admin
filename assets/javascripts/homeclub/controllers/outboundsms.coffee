define ['c/controllers', 's/customeraccount', 's/outboundsms'], (controllers) ->

  controllers.controller 'outboundsms', ['$scope', 'customeraccount', 'outboundsms', ($scope, customeraccount, outboundsms) ->

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