require ['admin-requirejs-config'], ->

  require [
    'ng'
    'admin-app'
    'admin-templates'
    'c/carrieradmins'
    'c/carrieradminshow'
    'c/carriercreate'
    'c/carriers'
    'c/carriershow'
    'c/customeraccounts'
    'c/customeraccountshow'
    'c/gatewaycreate'
    'c/gatewayshow'
    'c/homeclubadmins'
    'c/homeclubadminshow'
    'c/nav'
    'c/import'
    'c/sensorhubcreate'
    'c/users'
    'c/usershow'
    'filters'
    'bootstrap'
  ], (angular, app, templates) ->

    rp = ($routeProvider) ->

      auth =
        isLoggedIn: ['$http', '$q', '$rootScope', ($http, $q, $rootScope) ->
          return true if $rootScope.currentUser
          dfd = $q.defer()
          $http.get('/api/me/home-club-admin')
            .success (data) ->
              $rootScope.currentUser = data
              dfd.resolve true
            .error ->
              location.href = '/login'
          dfd.promise
        ]

      $routeProvider
        .when '/',
          template    : templates.admin
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

        .when '/users/:id',
          controller: 'usershow'
          template: templates.usershow
          resolve: auth

        .when '/users',
          controller: 'users'
          template: templates.users
          resolve: auth

        .otherwise
          redirectTo  : '/'

    app.config ['$routeProvider', '$httpProvider', rp]

    angular.bootstrap document, ['app']