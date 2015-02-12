define(
  ['app', 'moment', 'lodash','s/realtime-service', 'd/server-list-table'],
  (app, moment, _)->
    class Biz
      constructor: (service, $q)->
        @service = service
        @$q = $q

      q: (data)->
        deferred = @$q.defer()
        deferred.resolve(data)
        deferred.promise

      bizList: ->
        @service.getBizList()

      cityList: ->
        @service.getCityList()

      timeBucket: ->
        @q({startDate: new Date(), endDate: moment()})

      serverListTable: (params)->
        @service.getServeListTable(params)

      chartListData: (params)->
        @service.getChartListData(params)

      parseChartData: (data)->
        chart =
          title: text: data.name
          tooltip:
            trigger: 'axis'
            formatter: (params)->
              console.log(params)
              item = params.value
              time = moment(item[0]).format("MM-DD HH:mm:ss")
              "#{time} <br/> item[1]"
          xAxis: [
            { type : 'time',splitNumber: 10}
          ]
          yAxis: [ { type: 'value' }]

        lineDataList = data.value

        series = []
        getTimeData = (arr)->
          [item.name, item.value] for item in arr

        for lineData in lineDataList
          series.push [lineData.name, getTimeData(lineData.value)]
          chart.series = series

        chart

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
            data.history
          ).then((data)->
            biz.parseChartData item for item in data
          ).then((data)->
            $scope.chartList = data
          )

      ]
    )
)