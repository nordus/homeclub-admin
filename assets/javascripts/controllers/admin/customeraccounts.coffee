define ['c/controllers', 's/carrier', 's/customeraccount', 's/notifier', 'shared/services/auth-token'], (controllers) ->
	'use strict'

	controllers.controller 'customeraccounts', [
    '$filter'
    '$http'
    '$routeParams'
    '$scope'
    'carrier'
    'customeraccount'
    'notifier'
    'AuthTokenFactory'
    ($filter, $http, $routeParams, $scope, carrier, customerAccount, notifier, AuthTokenFactory) ->

      $scope.openDatePickers = {}

      $scope.open = ( $event, accountId ) ->
        $event.preventDefault()
        $event.stopPropagation()
        $scope.openDatePickers[accountId] = true


      customerAccount.getAll {}, (data) ->

        $scope.accounts = data

        $scope.accountsWithShipDate = []
        $scope.shipDates            = []
        data.forEach ( account ) ->
          if account.shipDate
            $scope.accountsWithShipDate.push account._id
            $scope.shipDates.push account.shipDate.split('T')[0]

        accountIds = data.map ( account ) -> account._id

        query = '?accountIds=' + accountIds.join '&accountIds='
        url   = '/api/google-analytics/page-views' + query

        $http.get( url )
          .success ( resp ) ->

            $scope.stats  = resp

            $scope.histogramOptions =
              renderer  : 'bar'
              height    : 34
              width     : 150

            $scope.histogramFeatures =
              hover:
                formatter: (series, x, y) ->
                  formattedDate = $filter( 'date' )( x, 'MMM dd' )

                  "#{y} #{series.name}<br><span class='date'>#{formattedDate}</span>"


        $scope.selectedAccountsUsageReportUrl = ->
          query = '?accountIds=' + $scope.accountsWithShipDate.join '&accountIds='
          query += '&startDates=' + $scope.shipDates.join '&startDates='

          '/api/google-analytics/usage-report' + query + "&token=#{AuthTokenFactory.getToken()}"


      $scope.usageReportUrl = ( acct ) ->
        query = "?accountIds=#{acct._id}&startDates=#{acct.shipDate.split('T')[0]}"
        '/api/google-analytics/usage-report' + query + "&token=#{AuthTokenFactory.getToken()}"

      $scope.hasShipDate = ( acctId ) ->
        $scope.accountsWithShipDate.indexOf( acctId ) isnt -1


      $scope.warnIfNotAllAccountsHaveShipDate = ->
        nbrOfAcctsWithoutShipDate = $scope.accounts.length - $scope.accountsWithShipDate.length
        if nbrOfAcctsWithoutShipDate isnt 0
          acctOrAccts = if nbrOfAcctsWithoutShipDate is 1 then 'account' else 'accounts'
          notifier.info "#{nbrOfAcctsWithoutShipDate} #{acctOrAccts} with missing 'Ship Date' will not be included"

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


      $scope.customerName = ( macAddress ) ->
        account = $scope.accounts.filter ( account ) ->
          account.gateways[0] == macAddress
        .pop()

        "#{account.name.first} #{account.name.last}"


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