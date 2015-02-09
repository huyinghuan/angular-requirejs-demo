define ['SimpleComponent', 'echarts', 'echarts/chart/line']
, (SimpleComponent, echarts)->
    template = '
      <div style="width: 80%; height: 400px; background-color: darkolivegreen"></div>
    '
    scope = clazz: '@', title: '@'

    option =
      title:
        text: '某楼盘销售情况'
        subtext: '纯属虚构'
      tooltip: trigger: 'axis'
      legend: data: [
        '意向'
        '预购'
        '成交'
      ]
      toolbox:
        show: true
        feature:
          mark: show: true
          dataView:
            show: true
            readOnly: false
          magicType:
            show: true
            type: [
              'line'
              'bar'
              'stack'
              'tiled'
            ]
          restore: show: true
          saveAsImage: show: true
      calculable: true
      xAxis: [ {
        type: 'category'
        boundaryGap: false
        data: [
          '周一'
          '周二'
          '周三'
          '周四'
          '周五'
          '周六'
          '周日'
        ]
      } ]
      yAxis: [ { type: 'value' } ]
      series: [
        {
          name: '成交'
          type: 'line'
          smooth: true
          itemStyle: normal: areaStyle: type: 'default'
          data: [
            10
            12
            21
            54
            260
            830
            710
          ]
        }
        {
          name: '预购'
          type: 'line'
          smooth: true
          itemStyle: normal: areaStyle: type: 'default'
          data: [
            30
            182
            434
            791
            390
            30
            10
          ]
        }
        {
          name: '意向'
          type: 'line'
          smooth: true
          itemStyle: normal: areaStyle: type: 'default'
          data: [
            1320
            1132
            601
            234
            120
            90
            20
          ]
        }
      ]

    SimpleComponent.directive('sfLineSurface',[->
      restrict: 'E'
      replace: true
      template: template
      scope: scope
      link: ($scope, element, attr)->
        chart = echarts.init(element[0])
        chart.setOption(option)
    ])