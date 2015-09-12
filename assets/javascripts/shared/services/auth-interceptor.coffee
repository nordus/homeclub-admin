define ['ng', 'shared/services/sharedservices', 'shared/services/auth-token'], (angular, services) ->
  services.factory 'AuthInterceptor', [ 'AuthTokenFactory', ( AuthTokenFactory ) ->

    request  : ( config ) ->
      token = AuthTokenFactory.getToken()

      if token
        config.headers  = config.headers || {}
        config.headers.Authorization  = "Bearer #{token}"

      return config
  ]