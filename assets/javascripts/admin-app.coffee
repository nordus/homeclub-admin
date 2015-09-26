define [
  'ng'
  'shared/shared'
  'rickshaw'
  'angular-rickshaw'
  'c/controllers'
  'ngResource'
  'ngRoute'
  's/services'
], (angular) ->

  angular.module 'app', [
    'shared'
    'controllers'
    'ngResource'
    'ngRoute'
    'services'
    'angular-rickshaw'
  ]
