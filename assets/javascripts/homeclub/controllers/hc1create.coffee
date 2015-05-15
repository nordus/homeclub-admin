define ['c/controllers', 's/gateway'], (controllers) ->

  controllers.controller 'hc1create', ['$http', '$scope', 'gateway', ($http, $scope, gateway) ->

    $scope.networkHubs = gateway.query()

    $scope.recipients = []

    $scope.toggleRecipients = ( networkHubMAC ) ->
      idx               = $scope.recipients.indexOf networkHubMAC
      currentlySelected = idx > -1

      if currentlySelected
        $scope.recipients.splice idx, 1
      else
        $scope.recipients.push networkHubMAC

    nbrOfBytesByAction =
      '0': '00'
      '1': '00'
      '2': '00'
      '3': '06'
      '4': '06'
      '5': '00'
      '6': '01'

    $scope.formInputs = {}

    $scope.$watch 'formInputs.action', ( newActionVal ) ->
      $scope.formInputs.nbrOfBytes = nbrOfBytesByAction[ newActionVal ]

    $scope.actions =
      'No action'                   : 0
      'Reset network hub'           : 1
      'Add MAC to white list'       : 3
      'Remove MAC from white list'  : 4
      'Request MAC white list'      : 5
      'Change heartbeat frequency'  : 6

    $scope.hasPhone = (item) ->
      item.phone != undefined && item.phone != ''

    $scope.nbrOfBytesIsZero = ->
      $scope.formInputs.nbrOfBytes is '00'

    $scope.send = ->
      $http.post('/api/hc1', {formInputs:$scope.formInputs, recipients:$scope.recipients}).success (data) ->
        $scope.data = data
  ]