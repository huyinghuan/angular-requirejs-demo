define ['echarts'], (echarts)->
  class Base
    constructor: (container)->
      @chart = echarts.init(container)

    getDefualtOption: ->
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

