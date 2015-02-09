define ['SimpleComponent', './base', 'echarts', 'echarts/chart/line']
, (SimpleComponent, Base, echarts)->
    template = '
      <div style="width: 80%; height: 400px; background-color: darkolivegreen"></div>
    '

    initOption = (obj)->
      defOption =
        title:
          text: obj.title or ''
          subtext: obj.subTitle or ''
        tooltip: trigger: 'axis'
        legend: data: []
        toolbox: false
        calculable: true
        xAxis: [ {
          type: 'category'
          boundaryGap: false
          data: []
        }]
        yAxis: [ { type: 'value' } ]
        series: []


    scope =
      clazz: '@'
      title: '@'
      subTitle: '@'
      bean: '='
      name: '@'

    drawImage = (params)->


    class LineSurface extends Base
      constructor: -> super



    SimpleComponent.directive('sfLineSurface',[->
        restrict: 'E'
        replace: true
        template: template
        scope: scope
        link: ($scope, element, attr)->
          chart = new LineSurface(element[0])

    ])