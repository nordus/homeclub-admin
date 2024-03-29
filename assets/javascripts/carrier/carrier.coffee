requirejs.config
  baseUrl: '/javascripts'
  urlArgs: "b=#{(new Date()).getTime()}"

  paths:
    jquery: 'vendor/jquery/jquery'
    ng          : 'vendor/angular/angular'
    ngResource  : 'vendor/angular-resource/angular-resource'
    ngRoute     : 'vendor/angular-route/angular-route'
    bootstrap   : 'vendor/bootstrap/bootstrap'
    toastr      : 'vendor/toastr/toastr'
    d3          : 'vendor/d3/d3'
    rickshaw    : 'vendor/rickshaw/rickshaw.min'
    'angular-rickshaw': 'angular-rickshaw.min'

  shim:
    ng:
      exports: 'angular'
    bootstrap   : ['jquery']
    ngResource  : ['ng']
    ngRoute     : ['ng']
    toastr      : ['jquery']
    d3:
      exports: 'd3'
    rickshaw:
      exports: 'Rickshaw'
      deps: ['d3']
    'angular-rickshaw':
      deps: ['ng', 'd3', 'rickshaw']

require [
  'ng'
  'carrier/carrier-app'
  'carrier-templates'
  'carrier/controllers/carrieradmincreate'
  'carrier/controllers/carrieradmins'
  'carrier/controllers/carrieradminshow'
  'carrier/controllers/connectivity'
  'carrier/controllers/customeraccounts'
  'carrier/controllers/customeraccountshow'
  'carrier/controllers/gatewayshow'
  'carrier/controllers/nav'
  'carrier/controllers/dashboard'
  'carrier/controllers/reports'
  'carrier/controllers/users'
  'carrier/controllers/usershow'
  'bootstrap'
], (angular, app, templates) ->

  rp = ($routeProvider) ->

    auth =
      isLoggedIn: ['$http', '$q', '$rootScope', 'AuthTokenFactory', ($http, $q, $rootScope, AuthTokenFactory) ->
        return true if $rootScope.currentUser
        dfd = $q.defer()
        $http.get('/api/me/carrier-admin')
          .success (data) ->
            $rootScope.currentUser = data.account
            AuthTokenFactory.setToken data.token
            dfd.resolve true
          .error ->
            location.href = '/login'
        dfd.promise
      ]

    $routeProvider
      .when '/dashboard',
        controller  : 'dashboard'
        template    : templates.dashboard
        resolve     : auth

      .when '/carrier-admins/:id',
        controller: 'carrieradminshow'
        template: templates.carrieradminshow
        resolve: auth

      .when '/carrier-admins',
        controller  : 'carrieradmins'
        template    : templates.carrieradmins
        resolve     : auth

      .when '/customer-accounts/:accountId/gateways/:id',
        template: templates.gatewayshow
        controller: 'gatewayshow'
        resolve: auth

      .when '/customer-accounts/:id',
        controller: 'customeraccountshow'
        template: templates.customeraccountshow
        resolve: auth

      .when '/customer-accounts',
        controller: 'customeraccounts'
        template: templates.customeraccounts
        resolve: auth

      .when '/connectivity',
        controller: 'connectivity'
        template: templates.connectivity
        resolve: auth

      .when '/reports',
        controller  : 'reports'
        template    : templates.reports
        resolve     : auth

      .when '/reports/:msgType',
        controller  : 'reports'
        template    : (routeParams) ->
          switch routeParams.msgType
            when '5' then templates.reportssensorreadings()
            when '4' then templates.reportssensoralerts()
            when '2' then templates.reportshomebasealerts()
        resolve     : auth

      .when '/users/:id/carrier-admin/create',
        controller: 'carrieradmincreate'
        template: templates.carrieradmincreate
        resolve: auth

      .when '/users/:id',
        controller: 'usershow'
        template: templates.usershow
        resolve: auth

      .when '/users',
        controller  : 'users'
        template    : templates.users
        resolve     : auth

      .otherwise
        redirectTo  : '/dashboard'

  app.config ['$routeProvider', rp]

  app.config [
    '$httpProvider'
    ( $httpProvider ) ->
      $httpProvider.interceptors.push 'AuthInterceptor'
  ]

  app.filter 'fahrenheit', ->
    (num) ->
      ((num * 9) / 5) + 32

  angular.bootstrap document, ['app']
