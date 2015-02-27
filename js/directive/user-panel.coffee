define ['app'], (app)->
  template = '
    <div class="main-menu">
      <a href="#" class="system"></a>
      <span>{{username}}</span>
    </div>
  '
  app.directive('userPanel', [->
    restrict: 'E'
    replace: true
    template: template
    scope: {username: '='}
    link: ($scope, element, attr)->
  ])