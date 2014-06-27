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

  shim:
    ng:
      exports: 'angular'
    bootstrap   : ['jquery']
    ngResource  : ['ng']
    ngRoute     : ['ng']
    toastr      : ['jquery']