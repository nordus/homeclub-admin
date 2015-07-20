define ['c/controllers', 's/carrier', 's/customeraccount', 's/notifier'], (controllers) ->
	'use strict'

	controllers.controller 'customeraccounts', ['$http', '$routeParams', '$scope', 'carrier', 'customeraccount', 'notifier', ($http, $routeParams, $scope, carrier, customerAccount, notifier) ->

    $scope.openDatePickers = {}

    $scope.open = ( $event, accountId ) ->
      $event.preventDefault()
      $event.stopPropagation()
      $scope.openDatePickers[accountId] = true


    customerAccount.getAll {}, (data) ->

      $scope.accounts = data

      $scope.customerNameByMac = {}
      data.forEach ( account ) ->
        if mac = account.gateways[0]
          @[account.gateways[0]] = "#{account.name.first} #{account.name.last}"
      , $scope.customerNameByMac

      $scope.customerName = ( mac ) -> $scope.customerNameByMac[mac]


    carrier.getAll {}, (data) -> $scope.carriers = data

    $scope.selectedCarrier = $routeParams.carrier

    $scope.breadcrumb =
      title: 'Accounts'

    $scope.sortOptions = [
      value: 'name.last', title: 'Sort by Last Name'
    ,
      value: 'name.first', title: 'Sort by First Name'
    ,
      value: 'city', title: 'Sort by City'
    ,
      value: 'state', title: 'Sort by State'
    ]

    $scope.sortOrder = $scope.sortOptions[0].value

    $scope.accountStatuses = ['New', 'Active', 'Suspended', 'Cancelled']

    $scope.save = ( account ) ->
      account.$update()
      notifier.success 'Saved!'

    $scope.checked = []

    $scope.toggleChecked = ( macAddress ) ->
      idx               = $scope.checked.indexOf macAddress
      currentlyChecked  = idx > -1

      if currentlyChecked
        $scope.checked.splice idx, 1
      else
        $scope.checked.push macAddress

    $scope.backup = ( macAddress ) ->
      $http.post( '/api/test-data/backup', macAddresses:macAddress )
        .success ( data, status, headers, config ) ->
          notifier.success "#{$scope.customerName(macAddress)} - Backup started!"

    $scope.backupChecked = ->
      for macAddress in $scope.checked
        $scope.backup macAddress

    $scope.toggleAll = ->
      $scope.accounts.forEach ( account ) ->
        return unless account.gateways[0]
        $scope.toggleChecked( account.gateways[0] )

    $scope.verifyBackup = ( macAddress ) ->
      $http.post( '/api/test-data/check-for-backup', macAddresses:macAddress )
        .error( ->
          notifier.error "#{$scope.customerName( macAddress )} - No backup found"
        ).success ( resp ) ->
          googleDriveFolderUrl = 'https://drive.google.com/drive/u/0/folders/' + resp.id
          notifier.info "<p>#{$scope.customerName(macAddress)} - Backup found!</p><a class='btn btn-default btn-xs' target='_blank' href='" + googleDriveFolderUrl + "'><i class='glyphicon glyphicon-eye-open'></i> VIEW BACKUP</a>"

    $scope.verifyBackupsOfChecked = ->
      for macAddress in $scope.checked
        $scope.verifyBackup macAddress

    $scope.deleteFromGraylog = ( macAddress ) ->
      $http.post( '/api/test-data/delete-from-graylog', macAddress: macAddress )
        .error( ->
          notifier.error "#{$scope.customerName( macAddress )} - Delete failed"
        ).success ( resp ) ->
          notifier.success "#{$scope.customerName( macAddress )} - Test data deleted!"

    $scope.deleteCheckedFromGraylog = ->
      for macAddress in $scope.checked
        $scope.deleteFromGraylog macAddress

    $scope.confirmDeleteFromGraylog = ( macAddress ) ->
      if confirm 'Are you sure?'
        $scope.deleteFromGraylog macAddress

  ]