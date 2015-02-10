define(
  ['app', 'moment', 's/realtime-service', 'd/server-list-table'],
  (app, moment)->
    class Biz
      constructor: (service, $q)->
        @service = service
        @$q = $q

      q: (data)->
        deferred = @$q.defer()
        deferred.resolve(data)
        deferred.promise

      bizList: ->
        data = [{name: 1, value: 1},{name: 2, value: 2}]
        @q(data)

      cityList: ->
        data = [{name: "长沙", value: "changsha"},{name: "株洲", value: "zhuzhou"}]
        @q(data)

      timeBucket: ->
        @q({startDate: new Date(), endDate: moment()})

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
          getData = (name)-> if biz[name] then biz[name]() else biz['default']()

          $scope.bean = {
            getList: getData
            getData: getData
          }

          $scope.chartList = [
            {
              title: "CPU状态"
              subTitle: ""
              xAxis: [ {
                type: 'category'
                boundaryGap: false
                data: ['周一','周二','周三','周四','周五','周六','周日']
              }]
              yAxis: [ { type: 'value' } ]
              series: [
                {
                  name: '成交'
                  type: 'line'
                  smooth: true
                  itemStyle: normal: areaStyle: type: 'default'
                  data:[10, 12, 21, 54, 260, 830, 710]
                }
                {
                  name: '预购'
                  type: 'line'
                  smooth: true
                  itemStyle: normal: areaStyle: type: 'default'
                  data:[30, 182, 434, 791, 390, 30, 10]
                }
                {
                  name: '意向'
                  type: 'line'
                  smooth: true
                  itemStyle: normal: areaStyle: type: 'default'
                  data:[1320, 1132, 601, 234, 120, 90, 20]
                }
              ]
            }
          ]
      ]
    )
)