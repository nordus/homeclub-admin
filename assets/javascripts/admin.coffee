require ['admin-requirejs-config'], ->

  require [
    'ng'
    'admin-app'
    'homeclub-templates'
    'c/carrieradmins'
    'homeclub/controllers/carrieradmincreate'
    'c/carrieradminshow'
    'c/carriercreate'
    'c/carriers'
    'c/carriershow'
    'homeclub/controllers/connectivity'
    'homeclub/controllers/hc1create'
    'homeclub/controllers/hc2create'
    'homeclub/controllers/outboundcommands'
    'homeclub/controllers/outboundsms'
    'c/customeraccounts'
    'c/customeraccountshow'
    'c/dashboard'
    'c/gatewaycreate'
    'c/gatewayshow'
    'c/homeclubadmins'
    'c/homeclubadminshow'
    'c/nav'
    'homeclub/controllers/networkhubs'
    'c/import'
    'c/sensorhubcreate'
    'c/users'
    'c/usershow'
    'filters'
    'bootstrap'
    'shared/services/auth-token'
    'shared/services/auth-interceptor'
  ], (angular, app, templates) ->

    rp = ($routeProvider) ->

      auth =
        isLoggedIn: ['$http', '$rootScope', 'AuthTokenFactory', ($http, $rootScope, AuthTokenFactory) ->
          return true if $rootScope.currentUser
          $http.get('/api/me/home-club-admin')
            .success (data) ->
              $rootScope.currentUser = data.account
              AuthTokenFactory.setToken data.token
              return true
            .error ->
              location.href = '/login'
        ]

      $routeProvider
        .when '/dashboard',
          controller: 'dashboard'
          template    : templates.dashboard
          resolve: auth

        .when '/carrier-admins/:id',
          controller: 'carrieradminshow'
          template: templates.carrieradminshow
          resolve: auth

        .when '/carrier-admins',
          controller: 'carrieradmins'
          template: templates.carrieradmins
          resolve: auth

        .when '/carriers/create',
          controller: 'carriercreate'
          template: templates.carriercreate
          resolve: auth

        .when '/carriers/:id',
          controller: 'carriershow'
          template: templates.carriershow
          resolve: auth

        .when '/carriers',
          controller: 'carriers'
          template: templates.carriers
          resolve: auth

        .when '/customer-accounts/:accountId/gateways/create',
          template: templates.gatewaycreate
          controller: 'gatewaycreate'
          resolve: auth

        .when '/customer-accounts/:accountId/gateways/:id',
          template: templates.gatewayshow
          controller: 'gatewayshow'
          resolve: auth

        .when '/customer-accounts/:accountId/gateways/:gatewayId/sensor-hubs/create',
          template: templates.sensorhubcreate
          controller: 'sensorhubcreate'
          resolve: auth

        .when '/customer-accounts/:id',
          controller: 'customeraccountshow'
          template: templates.customeraccountshow
          resolve: auth

        .when '/customer-accounts',
          controller: 'customeraccounts'
          template: templates.customeraccounts
          resolve: auth

        .when '/home-club-admins/:id',
          controller: 'homeclubadminshow'
          template: templates.homeclubadminshow
          resolve: auth

        .when '/home-club-admins',
          controller: 'homeclubadmins'
          template: templates.homeclubadmins
          resolve: auth

        .when '/import',
          controller: 'import'
          template: templates.import
          resolve: auth

        .when '/users/:id/carrier-admin/create',
          controller: 'carrieradmincreate'
          template: templates.carrieradmincreate
          resolve: auth

        .when '/users/:id',
          controller: 'usershow'
          template: templates.usershow
          resolve: auth

        .when '/users',
          controller: 'users'
          template: templates.users
          resolve: auth

        .when '/connectivity',
          controller: 'connectivity'
          template: templates.connectivity
          resolve: auth

        .when '/network-hubs',
          controller: 'networkhubs'
          template: templates.networkhubs
          resolve: auth

        .when '/outbound-commands/hc1/create',
          controller: 'hc1create'
          template: templates.hc1create
          resolve: auth

        .when '/outbound-commands/hc2/create',
          controller: 'hc2create'
          template: templates.hc2create
          resolve: auth

        .when '/outbound-sms',
          controller: 'outboundsms'
          template: templates.outboundsms
          resolve: auth

        .when '/outbound-commands',
          controller: 'outboundcommands'
          template: templates.outboundcommands
          resolve: auth

        .otherwise
          redirectTo  : '/dashboard'

    app.config ['$routeProvider', '$httpProvider', rp]

    app.config [
      '$httpProvider'
      ( $httpProvider ) ->
        $httpProvider.interceptors.push 'AuthInterceptor'
    ]

    angular.bootstrap document, ['app']