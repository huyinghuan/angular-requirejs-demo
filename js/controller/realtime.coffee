define(
  ['app', 'moment', 'lodash', 'utils', 's/realtime-service', 'd/server-list-table'],
  (app, moment, _, utils)->
    class Biz
      constructor: (service, $q)->
        @service = service
        @$q = $q

      q: (data)->
        deferred = @$q.defer()
        deferred.resolve(data)
        deferred.promise

      businessname: ->
        @service.getBizList()

      computer_room: ->
        @service.getComputerRoom().then((data)->
          [{name:"全部",value: "ALL"}].concat(data)
        )

      timeBucket: ->
        @q({startDate: new Date(), endDate: moment()})

      serverListTable: (params)->
        @service.getServeListTable(params)

      chartListData: (params)->
        @service.getChartListData(params)

      parseChartData: (data, fn = ((v)-> v), unit = "")->
        chart =
          title: text: data.name
          tooltip:
            trigger: 'axis'
          xAxis: [
            { type : 'time', splitNumber: 10}
          ]
          yAxis: [ { type: 'value' }]

        lineDataList = data.value

        series = []
        getTimeData = (arr, a = 0)->
          [item.name * 1000, fn(item.value) - a] for item in arr

        for lineData in lineDataList
          series.push [lineData.name, getTimeData(lineData.value)]
          series.push ['as', getTimeData(lineData.value, 50)]
          chart.series = series

        chart

      #获取数据转换函数
      getConvertFunction: (type)->
        return utils.convertBit if "#{type}" is "1"
        return (value)-> value

      default: ->
        @q(null)


    app.controller('RealtimeController',
      [
        '$scope'
        '$state'
        '$q'
        '$log'
        'RealtimeService'
        ($scope, $state, $q, $log, RealtimeService)->

          biz = new Biz(RealtimeService, $q)
          getData = (name, params)-> if biz[name] then biz[name](params) else biz['default']()

          $scope.bean = {
            getList: getData
            getData: getData
          }

          headTitle = 'CDN.node-nginx'
          biz.chartListData(businessname: headTitle).then((data)->
            data.fn = biz.getConvertFunction(data.type)
            data
          ).then((data)->
            biz.parseChartData item, data.fn for item in data.history
          ).then((data)->
            $scope.chartList = data
          )

      ]
    )
)