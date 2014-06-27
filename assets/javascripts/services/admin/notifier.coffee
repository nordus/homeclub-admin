define ['ng', 's/services', 'toastr'], (angular, services, toastr) ->
  
  toastr.options =
    closeButton   : true
    timeOut       : '600000'
  
  services.factory 'notifier', ->
    error   : (title, msg) ->
      toastr.error msg, title

    info    : (title, msg) ->
      toastr.info msg, title
      
    success : (title, msg) ->
      toastr.success msg, title