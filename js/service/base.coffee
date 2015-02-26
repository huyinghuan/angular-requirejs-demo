define ['app', 'lodash'], (app, _)->
  app.factory('Base', ['$http', '$q', '$log',($http, $q, $log)->
    baseUrl = '/iaas/api'

    buildUrl = (uri)-> "#{baseUrl}/#{uri}".replace(/\/\//g, "")

    service = {}

    ajax = (type)->
      (uri, params)->
        _.extend params, {username: '刘悦'}
        url = buildUrl(uri)
        deferred = $q.defer()
        $http(
          method: type
          url: url
          params: params
          timeout: 20000
        ).success((data)->
          deferred.resolve(data)
        ).error((msg, code)->
          $log.error(msg, code)
          #错误处理
          switch code
            when 403 then $state.go("login")
            when 500 then alert("服务器内部错误，请刷新页面重试！")
            else
              console.log code
              return deferred.resolve(msg)
        )
        deferred.promise

    service.get = ajax('get')

    service.post = ajax('post')

    service

  ])