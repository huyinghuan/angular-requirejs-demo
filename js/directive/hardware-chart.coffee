define ['app', 'jquery'], (app, $)->

  template = '
    <div class="{{clazz}}">
      <sf-title-hr title="{{title}}"></sf-title-hr>
      <div class="viem-cont" ng-repeat="chartData in chartList track by $index">
       <div sf-stacked-area  chart-data="chartData" ></div>
      </div>
      <div class="viem-cont">
        <p ng-repeat="item in rtime">{{item.name}}-{{item.value}}</p>
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
    getConvertFunction: (type)->
      type = "#{type}"
      switch type
        when "1"
          [
            (value)-> (value / 1024 / 1024).toFixed(2)
            "MB/s"
          ]
        when "3"
          [
            (value)-> value
            "%"
          ]
        when "4"
          [
            (value)-> (value / 1024 / 1024).toFixed(2)
            "MB"
          ]
        else
          [
            (value)-> value
            ""
          ]
    parseChartData: (data)->
      convert = @getConvertFunction(data.type)
      fn = convert[0]
      unit  = convert[1]
      chart =
        title: text: data.name
        tooltip:
          trigger: 'axis'
        xAxis: [
          { type : 'time', splitNumber: 10}
        ]
        yAxis: [ { type: 'value', name: unit}]

      lineDataList = data.value

      series = []
      getTimeData = (arr, a = 0)->
        [item.name * 1000, fn(item.value) - a] for item in arr

      for lineData in lineDataList
        series.push [lineData.name, getTimeData(lineData.value)]
        chart.series = series

      chart

    parseRtimeData: (rtime)->
      obj = {}

      for item in rtime
        if not obj["#{item.type}"]
          obj["#{item.type}"] = [{name: item.name, value: item.value}]
        else
          obj["#{item.type}"].push {name: item.name, value: item.value}

      {type: key, data: value} for key, value of obj

  app.directive('hardwareChart', [->
    restrict: 'E'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
      bean = $scope.bean
      params = {}
      params[$scope.name] = $scope.value
      bean.getData($scope.name, params).then((data)->
        #分离基本数据
        console.log biz.parseRtimeData data.rtime
        data.history
      ).then((data)->
        #抽取图形数据
        biz.parseChartData item for item in data
      ).then((data)->
        $scope.chartList = data
      )
  ])