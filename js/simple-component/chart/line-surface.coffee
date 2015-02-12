define ['SimpleComponent', './base', 'echarts', 'echarts/chart/line']
, (SimpleComponent, Base, echarts)->
    template = '<div></div>'

    scope =
      bean: '='
      name: '@'
      clazz: '@'
      headTitle: '@'
      chartWidth: '@'
      chartHeight: '@'
      chartData: '='

    class LineSurface extends Base
      constructor: -> super

    SimpleComponent.directive('sfLineSurface',['$timeout', ($timeout)->
      restrict: 'AE'
      replace: true
      template: template
      scope: scope
      link: ($scope, element, attr)->
        chart = null
        setChartOptions = (data)->
          chart.parseLegendFromSeries(data.series)
            .setXAixs(data.xAxis)
            .setYAixs(data.yAxis)
            .setSeries(data.series)
            .setTitle(data.title)
            .setTooltip(data.tooltip)
            .finish()

        initChart = (data)->
          chart = new LineSurface(element[0],
            {
              width: $scope.chartHeight,
              height: $scope.chartWidth
            })
          data = data or {}
          chart.setTitle(text: $scope.title, subtext: $scope.subTitle)
          setChartOptions(data)

        $scope.$on('SimpleComponent:chart:data:change', (e, data)->
          setChartOptions(data)
        )

        $timeout(->
          initChart($scope.chartData)
        )
    ])