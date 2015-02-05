define ['app'], (app)->
  app.directive('serverListTable', [->
    restrict: 'E'
    replace: true
    templateUrl: "views/directive/server-list-table.html"
    scope: {}
    link: ($scope, element, attr)->
  ])