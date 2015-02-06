define ['sc/index'], (SimpleComponent)->
  template = '
     <div class="{{clazz}}">
      <span class="seltext">{{title}}</span>
      <div class="selbg">
        <a href=""></a>
        <select class="sellist" name="{{name}}">
          <option
            ng-repeat="item in itemList"
             value="{item.value}">
            {{item.name}}
          </option>
        </select>
      </div>
    </div>
  '
  scope = bean: '=', clazz: '@', title: '@', name: '@'
  console.log(SimpleComponent)

  SimpleComponent.directive('sfSelect',[->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
      bean = $scope.bean
      bean.getList($scope.name).then((data)->
        $scope.itemList = data
      )
  ])
