define(
  ['app', 'moment', 'lodash', 'utils', 's/realtime-service', 'd/server-list-table'],
  (app, moment, _, utils)->
    class Biz
      constructor: (@service, @$q)->

      q: (data)->
        deferred = @$q.defer()
        deferred.resolve(data)
        deferred.promise

      business: ->
        @service.getBizList()

      computer_room: (params)->
        @service.getComputerRoom(params).then((data)->

          [{name:"全部",value: "ALL"}].concat(data)
        )

      servertype: ->
        data = [
          {name: "全部", value: "ALL"}
          {name: "物理机", value: "0"}
          {name: "虚拟机", value: "1"}
        ]
        @q(data)

      timeBucket: ->
        @q({startDate: new Date(), endDate: moment()})

      serverListTable: (params)->
        @service.getServeListTable(params)

      chartListData: (params)->
        @service.getChartListData(params)

      parseChartData: (data, fn = ((v)-> v), unit = "GB")->
        chart =
          title: text: data.name
          tooltip:
            trigger: 'axis'
            formatter: (item)->
              itemName = item[0]
              itemAxis = item[1]
              itemValue = item[2]
              date = moment(new Date(itemAxis)).format("YYYY-MM-DD HH:mm:ss")
              return "#{itemName}<br>#{date}   #{itemValue[1]}"
          xAxis: [
            { type : 'time', splitNumber: 10}
          ]
          yAxis: [ { type: 'value', name: unit}]

        lineDataList = data.value

        series = []
        getTimeData = (arr, a = 0)->
          [item.name * 1000, fn(item.value) - a] for item in arr

        for lineData in lineDataList
          series.push [lineData.name, getTimeData(lineData.value)]
          chart.series = series

        chart

      #获取数据转换函数
      getConvertFunction: (type)->
        return utils.convertBit if "#{type}" is "1"
        return (value)-> value

      default: ->
        @q(null)

    #重定向
    app.controller('RealtimeRedirectController', [
      '$scope',
      '$q',
      '$state',
      'RealtimeService',
      ($scope, $q, $state, RealtimeService)->
        biz = new Biz(RealtimeService)
        biz.business().then((data)->
          $state.go("main.realtime.one", {
            business: data[0],
            computer_room: "ALL"
            servertype: "ALL"
          })
        )
    ])
    app.controller('RealtimeController',
      [
        '$scope'
        '$state'
        '$q'
        '$log'
        '$interval'
        'RealtimeService'
        'honey.utils'
        ($scope, $state, $q, $log, $interval, RealtimeService, honeyUtils)->

          #获取查询参数
          getParams = (params)->
            _.extend {}, $state.params, honeyUtils.getHashObj(), params

          biz = new Biz(RealtimeService, $q)

          getData = (name, params = {})->
            if biz[name] then biz[name](getParams(params)) else biz['default']()

          #表单控件值改变
          formChange = (name, value)->
            obj = {}
            obj[name] = value
            switch name
              when "business"
                console.log obj
                loadDataChart(obj) #业务改变了
                obj.page = 1
                loadDataTable(obj)
              when "serverTablePager" #翻页
                $scope.$apply(-> honeyUtils.setHash({page:value}))
                $log.log "serverTablePager"
                loadDataTable(obj)
              when "computer_room", "servertype", "IP" #机房，机器类型， 服务器ip
                obj.page = 1
                loadDataTable(obj)
              when "timeBucket"
                time = starttime: value[0].startOf('day').unix(), endtime: value[1].endOf('day').unix()
                honeyUtils.setHash(time)
                loadDataTable(time)

          $scope.bean = {
            getList: getData
            getData: getData
            formChange: formChange
          }

          #加载表格数据
          loadDataTable = (params)->
            $scope.$broadcast("table:serverListTable:load", params)

          #加载图形数据
          loadDataChart = (params = {})->
            $scope.nowTime = moment().format("HH:mm:ss")
            #优先hash值，hash没有参数则使用默认值
            params = _.extend {}, $state.params, honeyUtils.getHashObj(), params
            $log.log params
            #图形数据
            biz.chartListData(params)
            .then((data)->
              data.fn = biz.getConvertFunction(data.type)
              data
            ).then((data)->
              queue = []
              queue.push biz.parseChartData item, data.fn for item in data.history
              return queue if queue.length
              [biz.parseChartData({name: "", value: []})]
            ).then((data)->
              $scope.chartList = data
            )

          loadDataChart()

          $interval(loadDataChart, 1000 * 60 * 5)

      ]
    )
)