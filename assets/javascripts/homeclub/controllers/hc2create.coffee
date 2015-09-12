define ['ng', 'c/controllers', 's/customeraccount', 's/gateway', 's/sensorhub', 'shared/services/meta', 's/notifier'], (angular, controllers) ->

  controllers.controller 'hc2create', ['$http', '$scope', 'customeraccount', 'gateway', 'meta', 'notifier', 'sensorhub', ($http, $scope, customeraccount, gateway, meta, notifier, sensorhub) ->

    $scope.deletePendingOutboundCommand = ( nh ) ->
      if confirm 'Cancel pending command?'
        nh.pendingOutboundCommand = null
        nh.$update()

    $scope.meta = meta

    $scope.customThresholdInputRanges =

      temperatureMin:
        min: 32
        max: 140

      temperatureMax:
        min: 32
        max: 140

      humidityMin:
        min: 0
        max: 100

      lightMin:
        min: 0
        max: 100

      lightMax:
        min: 0
        max: 999

    $scope.formInputs =
      action: '1'

    $scope.actions =
      '1': 'Update sensorHubType 1 (Water)'
      '2': 'Update sensorHubType 2 (Indoor Climate)'
      '3': 'Update sensorHubType 3 (Item Movement)'
#      '4': 'Update sensorHubType 4 (Human Motion)'

    $scope.sensorTypes = ['humidity', 'light', 'motion', 'movement', 'temperature', 'water']

    sensorTypesBySensorHubTypeId =
      '1' : ['temperature']
      '2' : ['humidity', 'light', 'temperature']
      '3' : ['movement']
      '4' : ['motion']

    $scope.hasSensorType = (sensorType) ->
      sensorTypesOfCurrentSensorHub = sensorTypesBySensorHubTypeId[$scope.formInputs.action]

      sensorType in sensorTypesOfCurrentSensorHub

    $scope.sensorTypeHasMinMax = (sensorType) ->
      sensorType in ['humidity', 'light', 'temperature']

    $scope.networkHubs = gateway.query()

    $scope.recipients = []

    $scope.$watch 'formInputs.action', ->
      $scope.recipients = []

    $scope.isChecked = ( networkHubMAC, sensorHubMAC ) ->
      $scope.recipients.filter ( recipient ) ->
        [recipientNetworkHubMAC, recipientSensorHubMAC] = recipient

        networkHubMAC == recipientNetworkHubMAC and sensorHubMAC == recipientSensorHubMAC
      .length

    $scope.toggleRecipients = ( networkHubMAC, sensorHubMAC ) ->
      idx               = $scope.recipients.indexOf networkHubMAC
      currentlySelected = idx > -1

      if currentlySelected
        $scope.recipients.splice idx, 1
      else
        $scope.recipients.push [networkHubMAC, sensorHubMAC]


    customeraccount.query (accounts) ->
      $scope.formattedNames = {}
      accounts.forEach (account) ->
        $scope.formattedNames[account._id] = [
          account.name.first
          account.name.last
          ('(..' + account._id.substr(-4) + ')')
        ].join ' '

    sensorhub.query (sensorHubs) ->

      $scope.sensorHubTypeByMac = {}

      sensorHubs.forEach ( sh ) ->
        @[sh._id] = sh.sensorHubType
      , $scope.sensorHubTypeByMac

      $scope.sensorHubTypeMatchesSelectedAction = ( sensorHubMac ) ->
        $scope.sensorHubTypeByMac[sensorHubMac] == +$scope.formInputs.action

    $scope.hasPendingOutboundCommand = (item) ->
      item.pendingOutboundCommand != undefined

    $scope.noPendingOutboundCommand = (item) ->
      item.pendingOutboundCommand == undefined

    $scope.send = ->

      $scope.sending = true

      defaults =
        movementSensitivity: 255
        humidityMin: 65535
        humidityMax: 65535
        lightMin: 65535
        lightMax: 65535
        temperatureMin: 65535
        temperatureMax: 65535

      params = angular.extend defaults, $scope.formInputs

      $scope.recipients.forEach (recipient) ->

        [params.networkHubMAC, params.sensorHubMAC] = recipient

        $http.post('/api/hc2', {formInputs:params}).success (data) ->

          updatedNetworkHub = $scope.networkHubs.filter ( nh ) ->
            nh._id == params.networkHubMAC
          .pop()

          updatedNetworkHub.pendingOutboundCommand = data._id

      $scope.recipients = []
      $scope.sending    = false

      notifier.success 'Sent!'

  ]