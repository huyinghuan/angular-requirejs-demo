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
        @service.getBizList()

      cityList: ->
        @service.getCityList()

      timeBucket: ->
        @q({startDate: new Date(), endDate: moment()})

      serverListTable: (params)->
        @service.getServeListTable(params)

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


          $scope.chartList = [
            {
              headTitle: 'cpu状态'
              title: text: 'cpu状态', subtext: '192.16'
              xAxis: [
                ['周一','周二','周三','周四','周五','周六','周日']
              ]
              yAxis: [ { type: 'value' } ]
              series: [
                ['成交', [10, 12, 21, 54, 260, 830, 710]]
                ['预购', [30, 182, 434, 791, 390, 30, 10]]
                ['意向', [1320, 1132, 601, 234, 120, 90, 20]]
              ]
            }
          ]
      ]
    )
)