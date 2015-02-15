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
              if "1" is "#{data.success}"
                $state.go("main.realtime")
              else
                $scope.status = false
            )
            .catch((error)->
              $scope.status = false
              console.log error
              $state.go("main.realtime")
            )
  ])
)