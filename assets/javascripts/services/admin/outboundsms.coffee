define ['ng', 's/services', 'ngResource'], (angular, services) ->
  'use strict'

  services.factory 'outboundsms', ['$resource', ($resource) ->

    $resource '/api/outbound-sms'


  ]