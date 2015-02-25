define ['SimpleComponent', './base', 'echarts', 'echarts/chart/pie']
, (SimpleComponent, Base, echarts)->
  template = '<div></div>'

  scope =
    bean: '='
    name: '@'
    clazz: '@'
    chartData: '='

  class Pie extends Base
    constructor: ->
      super
      @option =
        title:
          text: ''
          subtext: ''
        tooltip:
          trigger: 'item',
          formatter: "{a} <br/>{b} : {c} ({d}%)"
        legend:
          orient : 'vertical',
          x : 'left',
          orient : 'vertical'
          data: []
        toolbox: false
        calculable: true
        series: [{
          name: "Disk"
          type: 'pie'
          radius: ['50%', '70%']
          data: []
          itemStyle:
            normal:
              label: show : false
              labelLine:  show : false
            emphasis:
              label:
                formatter: (seriesName, itemName, value, precent)->
                  return "#{itemName.replace("vfs.fs.size", "")} \n #{precent}%"
                show: true,
                position: 'center'
                textStyle: fontSize : '30', fontWeight : 'bold'
        }]
        animation: false

  SimpleComponent.directive('sfPie',['$timeout', ($timeout)->
    restrict: 'AE'
    replace: true
    template: template
    scope: scope
    link: ($scope, element, attr)->
      chartElement = element[0]
      chart = null

      setChartOptions = (data)->
        chart.option.legend.data = data.legendData
        chart.option.series[0].data = data.data
        chart.finish()

      initChart = (data)->
        chart = new Pie(chartElement, { width: null,height: null })
        data = data or {}
        chart.setTitle(text: "")
        setChartOptions(data)

      $scope.$on('SimpleComponent:chart:data:change', (e, data)->
        setChartOptions(data)
      )

      $timeout(->
        initChart($scope.chartData)
      , 5000)
  ])