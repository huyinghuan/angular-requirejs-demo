define ['app', 'jquery'], (app, $)->

  template = '
    <div class="{{clazz}}">
      <sf-title-hr title="{{title}}"></sf-title-hr>
      <div class="viem-cont" style="float:left; width: 45%" ng-repeat="chartData in chartDataList">
        <sf-pie chart-data="chartData"></sf-pie>
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
    getFormatterFunction: (type)->
      if type is 3
        return [((value)-> value), '%']
      if type is 4
        return [((value)-> (value/1024/1024/1024).toFixed(2)), "GB"]

    formatQueue: (data, fn)->
      queue = []
      for item in data
        continue if item.name is "total"
        item.value = fn(item.value)
        queue.push item
      queue

    parseRtimeData: (rtime)->
      queue = []

      for item in rtime
        format = biz.getFormatterFunction(item.type)
        fn = format[0]
        unit = format[1]
        item.value = biz.formatQueue(item.value, fn)
        queue.push biz.parseChartData(item, unit)

      queue

    parseChartData: (data, unit)->
      options = {legendData: []}
      for item in data.value
        options.legendData.push item.name
      options.title = data.name
      options.data = data.value
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
          $scope.chartDataList = result
        )

      loadData()

      $scope.$on("hardwareChartDisk:load", (e, params)->
        loadData(params)
      )
  ])