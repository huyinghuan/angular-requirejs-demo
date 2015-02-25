define ['SimpleComponent', 'jquery'], (SimpleComponent, $)->
  template = '
    <div class="simple-component">
      <div class="selbg">
        <button type="button" name="{{name}}" class="btn-default">{{title}}</button>
      </div>
    </div>
  '
  scope = bean: '=', clazz: '@', title: '@', name: '@'

  SimpleComponent.directive('sfButton',[->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
      bean = $scope.bean

      $(element).find("button").on('click', ->
        bean.formAction($scope.name)
      )
  ])