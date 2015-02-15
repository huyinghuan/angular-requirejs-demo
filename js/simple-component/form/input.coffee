define ['SimpleComponent', 'jquery'], (SimpleComponent, $)->
  template = '
    <div class="simple-component {{clazz}}">
      <span class="seltext">{{title}}</span>
      <div class="selbg">
        <input type="text" name="{{name}}" honey-hash-bind>
      </div>
    </div>
  '
  scope = bean: '=', clazz: '@', title: '@', name: '@'

  SimpleComponent.directive('sfInput',[->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
      bean = $scope.bean
      bean.getList($scope.name).then((data)->
        $scope.itemList = data
      )

      $(element).find("input").on("keyup", (e)->
        if e.keyCode is 13
          e.preventDefault()
          bean.formChange and bean.formChange($scope.name, $(@).val())
      )

  ])
