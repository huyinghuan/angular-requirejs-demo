define ['app'], (app)->
  app.factory('Base', ['$http', '$q', '$log',($http, $q, $log)->
    baseUrl = '/iaas/api'

    buildUrl = (uri)->
      url = "#{baseUrl}/#{uri}".replace(/\/\//g, "")
      $log.log "Get from #{url}"
      url

    service = {}

    ajax = (type)->
      (uri, params)->
        url = buildUrl(uri)
        deferred = $q.defer()
        $http(
          method: type
          url: url
          params: params
          timeout: 5000
        ).success((data)->
          deferred.resolve(data)
        ).error((msg, code)->
          $log.error(msg, code)
          #错误处理
          #switch(xxx)
          deferred.reject(msg)
        )
        deferred.promise

    service.get = ajax('get')

    service.post = ajax('post')

    service

  ])