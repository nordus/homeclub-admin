define [
  'ng'
  'shared/shared'
  'rickshaw'
  'angular-rickshaw'
  'carrier/controllers/controllers'
  'ngResource'
  'ngRoute'
  'carrier/services/services'
], (angular) ->

  angular.module 'app', [
    'shared'
    'controllers'
    'ngResource'
    'ngRoute'
    'services'
    'angular-rickshaw'
    'shared'
  ]
