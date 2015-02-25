define ['app', 'jquery'], (app, $)->

  template = '
    <div class="{{clazz}}">
      <sf-title-hr title="{{title}}"></sf-title-hr>
      <div class="viem-cont">
        <sf-pie chart-data="chartData"></sf-pie>
      </div>
      <div class="viem-cont">
        <p ng-repeat="item in numberData">{{item.name}}-{{item.value}}</p>
      </div>
    </div>
  '
  scope =
    bean: '='
    name: '@'
    value: '@'
    clazz: '@'
    title: '@'

  biz =
    parseRtimeData: (rtime)->
      obj = "numberData": [], "pie": []

      for item in rtime
        if item.type is 4
          obj.numberData.push {name: item.name, value: (item.value / 1024 / 1024)}
        else
          obj.pie.push {name: item.name, value: item.value}

      obj

    parseChartData: (data)->
      options = {legendData: []}
      for item in data
        options.legendData.push item.name
      options.data = data
      options

  app.directive('hardwareChartDisk', [->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
      bean = $scope.bean
      params = {}
      params[$scope.name] = $scope.value
      bean.getData($scope.name, params).then((data)->
        result = biz.parseRtimeData data.rtime
        #分离基本数据
        $scope.numberData = result.numberData
        result.pie
      ).then((data)->
        $scope.chartData = biz.parseChartData data
      )
  ])