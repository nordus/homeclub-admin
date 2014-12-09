requirejs.config

  urlArgs: "b=#{(new Date()).getTime()}"

  paths:
    jquery: 'vendor/jquery/jquery'
    ng          : 'vendor/angular/angular'
    ngResource  : 'vendor/angular-resource/angular-resource'
    ngRoute     : 'vendor/angular-route/angular-route'
    bootstrap   : 'vendor/bootstrap/bootstrap'
    c           : 'controllers/admin'
    s           : 'services/admin'
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