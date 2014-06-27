define ['admin-app'], (app) ->

  app.filter 'dasherize', ->
    (str) ->
      str.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase()