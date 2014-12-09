define [
  'ng'
  'rickshaw'
  'angular-rickshaw'
  'c/controllers'
  'ngResource'
  'ngRoute'
  's/services'
  ], (angular) ->

  angular.module('app', ['controllers', 'ngResource', 'ngRoute', 'services', 'angular-rickshaw'])
