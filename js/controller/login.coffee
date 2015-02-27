define(['app', 's/login-service'], (app)->
  app.controller('loginController',
    [
      '$scope',
      '$state',
      '$log'
      'LoginService',
      ($scope, $state, $log, LoginService)->
        #登陆状态
        $scope.status = true
        $scope.submit = ->
          LoginService.login($scope.username, $scope.password)
            .then((data)->
              if +data.success > 0
                $state.go("main.realtime")
                LoginService.username = $scope.username
              else
                $scope.status = false
            )
            .catch((error)->
              $scope.status = false
            )
  ])
)