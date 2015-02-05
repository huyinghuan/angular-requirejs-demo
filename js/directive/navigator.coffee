define ['app'], (app)->
  app.directive('navigator', [->
    restrict: 'E'
    replace: true
    templateUrl: "views/directive/navigator.html"
    scope: {}
    link: ($scope, element, attr)->
  ])