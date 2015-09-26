define [
  'ng'
  'shared/filters/sharedfilters'
  'shared/services/sharedservices'
  'shared/filters/dasherize'
  'shared/services/auth-interceptor'
  'shared/services/auth-token'
], ( angular ) ->

  angular.module 'shared', ['sharedfilters', 'sharedservices']
