define ['app'], (app)->
  app.directive('userPanel', [->
    restrict: 'E'
    replace: true
    templateUrl: "views/directive/user-panel.html"
    scope: {}
    link: ($scope, element, attr)->
  ])