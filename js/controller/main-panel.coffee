define(
  [
    'app'
    'd/navigator'
    'd/user-panel'
  ],
  (app)->
    app.controller('MainPanelController',
      [
        '$scope'
        '$state'
        '$log'
        ($scope, $state, $log)->
          $log
      ]
    )
)