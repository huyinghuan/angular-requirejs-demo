define ['echarts', 'lodash'], (echarts, _)->
  class Base
    constructor: (container)->
      @chart = echarts.init(container)
      @initDefualtOption()

    initDefualtOption: ->
      @option =
        title:
          text: ''
          subtext: ''
        tooltip: trigger: 'axis'
        legend: data: []
        toolbox: false
        calculable: true
        xAxis: []
        yAxis: [ { type: 'value' } ]
        series: []
      @

    setTitle: (title)->
      _.extend @option.title, title
      @

    setLegend: (legend)->
      _.extend @option.legend, legend
      @

    #从series中获取legend数据
    parseLegendFromSeries: (series)->
      series = series or []
      queue = []
      queue.push item.name for item in series
      @setLegend(data: queue)
      @

    setXAixs: (xAixs)->
      @option.xAxis = xAixs or []
      @

    setYAixs: (yAixs)->
      @option.yAxis = yAixs if yAixs
      @

    setSeries: (series)->
      @option.series = series or []
      @

    finish: ->
      @chart.setOption @option