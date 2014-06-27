define [
  'ng'
  'c/controllers'
  'ngResource'
  'ngRoute'
  's/services'
  ], (angular) ->

  angular.module('app', ['controllers', 'ngResource', 'ngRoute', 'services'])