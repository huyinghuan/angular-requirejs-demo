define ['app'], (app)->
  template = '
    <div class="cont-left">
      <ul>
        <li class="on">
          <a ui-sref="main.realtime"><span class="real-time">实时概览</span></a>
        </li>
      </ul>
    </div>'
  app.directive('navigator', [->
    restrict: 'E'
    replace: true
    template: template
    scope: {}
    link: ($scope, element, attr)->
  ])