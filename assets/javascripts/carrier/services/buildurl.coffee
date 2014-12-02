define ['ng', 'carrier/services/services'], (angular, services) ->
	'use strict'

	services.factory 'buildurl', ->

    encodeUriQuery = (val, pctEncodeSpaces) ->
      encodeURIComponent(val).replace(/%40/g, "@").replace(/%3A/g, ":").replace(/%24/g, "$").replace(/%2C/g, ",").replace(/%3B/g, ";").replace /%20/g, ((if pctEncodeSpaces then "%20" else "+"))

    sortedKeys = (obj) ->
      keys = []
      for key of obj
        keys.push key  if obj.hasOwnProperty(key)
      keys.sort()

    forEachSorted = (obj, iterator, context) ->
      keys = sortedKeys(obj)
      i = 0
    
      while i < keys.length
        iterator.call context, obj[keys[i]], keys[i]
        i++
      keys

    (url, params) ->
      return url  unless params
      parts = []
      forEachSorted params, (value, key) ->
        return  if value is null or angular.isUndefined(value)
        value = [value]  unless angular.isArray(value)
        angular.forEach value, (v) ->
          if angular.isObject(v)
            if angular.isDate(v)
              v = v.toISOString()
            else v = toJson(v)  if angular.isObject(v)
          parts.push encodeUriQuery(key) + "=" + encodeUriQuery(v)
          return
    
        return
    
      url += ((if (url.indexOf("?") is -1) then "?" else "&")) + parts.join("&")  if parts.length > 0
      url