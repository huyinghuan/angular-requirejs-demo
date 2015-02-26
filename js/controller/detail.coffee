define(['app', 'moment', 'jquery','d/hardware-chart', 'd/hardware-chart-disk','s/detail-service'],
  (app, moment, $)->
    class Biz
      constructor: (@service, @$q)->

      q: (data)->
        deferred = @$q.defer()
        deferred.resolve(data)
        deferred.promise

      computer_room: (params)->
        @service.getBroomList(params.business).then((data)->
          [{name: "全部", value: "ALL"}].concat(data)
        )

      hostname: (params)->
        return @service.getHostName(params.hostname) if params.computer_room is "ALL"
        @service.getHostnameList(params.business, params.computer_room)

      hardware: (params)->
        @service.getHardware(params)

      timeBucket: ->
        @q({startDate: new Date(), endDate: moment()})

    app.controller('DetailController',
      [
        '$scope'
        '$state'
        '$log'
        '$q'
        'DetailService'
        'honey.utils'
        ($scope, $state, $log, $q, service, honeyUtils)->

          biz = new Biz(service, $q)

          getParams = (params = {})->
            _.extend {}, $state.params, honeyUtils.getHashObj(), params

          getData = (name, params = {})->
            if biz[name] then biz[name](getParams(params)) else biz['default']()

          $scope.params = getParams()

          formChange = (name, value)->
            obj = {}
            obj[name] = value
            $log.log obj
            switch name
              when 'computer_room'
                #重新加载服务器列表
                $scope.$broadcast("sf-select:hostname:load", obj)
              when 'timeBucket'
                time = starttime: value[0].startOf('day').unix(), endtime: value[1].endOf('day').unix()
                honeyUtils.setHash(time)

          loadChartData = (params)->
            console.log params
            $scope.nowTime = moment().format("HH:mm:ss")
            $scope.$broadcast("hardwareChart:load", params)
            $scope.$broadcast("hardwareChartDisk:load", params)

          formAction = (name)->
            params =  getParams({"hostname": $("select[name='hostname']").val()})
            loadChartData(params)

          $scope.bean = {
            getList: getData
            getData: getData
            formChange: formChange
            formAction: formAction
          }

          $scope.nowTime = moment().format("HH:mm:ss")
      ]
    )
)