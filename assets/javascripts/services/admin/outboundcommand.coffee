define ['ng', 's/services', 'ngResource'], (angular, services) ->
  'use strict'

  services.factory 'outboundcommand', ['$resource', ($resource) ->

    $resource '/api/outbound-commands'


  ]