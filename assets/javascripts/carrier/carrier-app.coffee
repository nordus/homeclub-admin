define [
  'ng'
  'rickshaw'
  'angular-rickshaw'
  'carrier/controllers/controllers'
  'ngResource'
  'ngRoute'
  'carrier/services/services'
  'shared/shared'
], (angular) ->

  angular.module('app', ['controllers', 'ngResource', 'ngRoute', 'services', 'angular-rickshaw', 'shared'])