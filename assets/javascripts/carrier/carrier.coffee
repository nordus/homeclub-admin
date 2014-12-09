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
  'carrier/controllers/carrieradmins'
  'carrier/controllers/carrieradminshow'
  'carrier/controllers/connectivity'
  'carrier/controllers/customeraccounts'
  'carrier/controllers/customeraccountshow'
  'carrier/controllers/gatewayshow'
  'carrier/controllers/nav'
  'carrier/controllers/dashboard'
  'carrier/controllers/reports'
  'bootstrap'
], (angular, app, templates) ->
  
  rp = ($routeProvider, $httpProvider) ->
    
    auth =
      isLoggedIn: ['$http', '$q', '$rootScope', ($http, $q, $rootScope) ->
        return true if $rootScope.currentUser
        dfd = $q.defer()
        $http.get('/api/me/carrier-admin')
          .success (data) ->
            $rootScope.currentUser = data
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

      .when '/reports/:msgType',
        controller  : 'reports'
        template    : (routeParams) ->
          switch routeParams.msgType
            when '5' then templates.reportssensorreadings()
            when '4' then templates.reportssensoralerts()
            when '2' then templates.reportshomebasealerts()
        resolve     : auth
        
      .otherwise
        redirectTo  : '/dashboard'

  app.config ['$routeProvider', '$httpProvider', rp]

  app.filter 'fahrenheit', ->
    (num) ->
      ((num * 9) / 5) + 32

  angular.bootstrap document, ['app']