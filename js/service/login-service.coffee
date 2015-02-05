define(
  ['app', 'service/base']
, (app)->
    app.factory('LoginService', ['$log', 'Base', ($log, Base)->
      url = 'login'
      service = {}

      service.login = (username, password)->
        Base.get(url, {username: username, password: password})

      service
    ])
)