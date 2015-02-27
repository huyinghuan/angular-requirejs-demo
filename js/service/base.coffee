define ['app', 'lodash', 'jquery'], (app, _, $)->
  count = 0
  loading = ->
    count = count + 1
    $("#loading").fadeIn()

  loaded = ->
    count = count - 1
    if count < 1
      $("#loading").fadeOut()

  app.factory('Base', ['$http', '$q', '$log', ($http, $q, $log)->
    baseUrl = '/iaas/api'

    buildUrl = (uri)-> "#{baseUrl}/#{uri}".replace(/\/\//g, "")

    service = {}
    username = '刘悦'
    ajax = (type)->
      (uri, params)->
        loading()
        username = params.username if params.username
        _.extend params, {username: username}
        url = buildUrl(uri)
        deferred = $q.defer()
        $http(
          method: type
          url: url
          params: params
          timeout: 20000
        ).success((data)->
          loaded()
          deferred.resolve(data)
        ).error((msg, code)->
          loaded()
          $log.error(msg, code)
          #错误处理
          switch code
            when 403 then $state.go("login")
            when 500 then alert("服务器内部错误，请刷新页面重试！")
            when 0 then  alert("服务器内部错误，请刷新页面重试！")
            else
              console.log code
              return deferred.resolve(msg)
        )
        deferred.promise

    service.get = ajax('get')

    service.post = ajax('post')

    service

  ])