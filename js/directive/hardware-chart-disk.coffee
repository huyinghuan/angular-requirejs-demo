define ['app', 'jquery'], (app, $)->

  template = '
    <div class="{{clazz}}">
      <sf-title-hr title="{{title}}"></sf-title-hr>
      <div class="viem-cont" style="float:left; width: 45%">
        <sf-pie chart-data="chartData"></sf-pie>
      </div>
      <div class="viem-cont" style="float:left; width: 45%">
        <sf-pie chart-data="numberData"></sf-pie>
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
          obj.numberData.push {name: item.name, value: (item.value / 1024 / 1024 / 1024).toFixed(2)}
        else
          obj.pie.push {name: item.name, value: item.value}

      obj

    parseChartData: (data, unit)->
      options = {legendData: []}
      for item in data
        options.legendData.push item.name
      options.data = data
      options.unit = unit
      options

  app.directive('hardwareChartDisk', [->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
      bean = $scope.bean
      loadData = (params = {})->
        params[$scope.name] = $scope.value
        bean.getData($scope.name, params).then((data)->
          result = biz.parseRtimeData data.rtime
          #分离基本数据
          $scope.numberData = biz.parseChartData result.numberData, "GB"
          $scope.chartData = biz.parseChartData result.pie, "%"
        )

      loadData()

      $scope.$on("hardwareChartDisk:load", (e, params)->
        loadData(params)
      )
  ])