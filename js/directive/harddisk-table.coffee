define ['app'], (app)->
  app.directive('harddiskTable', [->
    restrict: 'E'
    replace: true
    templateUrl: "views/directive/harddisk-table.html"
    scope: {}
    link: ($scope, element, attr)->
  ])