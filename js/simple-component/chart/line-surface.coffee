define ['SimpleComponent', './base', 'echarts', 'echarts/chart/line']
, (SimpleComponent, Base, echarts)->
    template = '
      <div></div>
    '
    #默认图形的宽和高
    defaultChartHeight = "400px"
    defaultChartWidth = "90%"
    scope =
      bean: '='
      clazz: '@'
      title: '@'
      subTitle: '@'
      chartWidth: '@'
      chartHeight: '@'
      chartData: '='

    class LineSurface extends Base
      constructor: -> super


    SimpleComponent.directive('sfLineSurface',['$timeout', ($timeout)->
      restrict: 'E'
      replace: true
      template: template
      scope: scope
      link: ($scope, element, attr)->
        chartHeight = $scope.chartHeight or defaultChartHeight
        chartWidth = $scope.chartWidth or defaultChartWidth
        $(element).css('height', chartHeight)
        $(element).css('width', chartWidth)

        chart = new LineSurface(element[0])

        initChart = (data)->
          data = data or {}
          chart.setTitle(text: $scope.title, subtext: $scope.subTitle)
            .parseLegendFromSeries(data.series)
            .setXAixs(data.xAxis)
            .setYAixs(data.yAxis)
            .setSeries(data.series)
            .finish()

        $timeout(->
          initChart($scope.chartData)
        )
    ])