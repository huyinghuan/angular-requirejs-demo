define(
  [
    'app'
    's/login-service'
    'd/navigator'
    'd/user-panel'
  ],
  (app)->
    app.controller('MainPanelController',
      [
        '$scope'
        '$state'
        'LoginService'
        ($scope, $state, LoginService)->
          $scope.service = LoginService
          $scope.isOff = -> $state.current.name is "main.realtime.one"
          LoginService.getUsername((username)->
            $scope.username = username
          )
      ]
    )
)