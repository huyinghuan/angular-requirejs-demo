define(
  ['app', 'lodash', 'service/base']
, (app, _)->
  app.factory('RealtimeService', ['$log', '$q', 'Base', 'honey.utils', ($log, $q, Base, honeyUtils)->

    service = {}

    service.getBizList = ()->
      Base.get("businesslist", {})

    service.getComputerRoom = (params)->
      Base.get("broomlist", params)

    service.getChartListData = (params)->
      Base.get("businessvalue", params)

    service.getServeListTable = (params)->

      defaultParams = ()->
        computer_room: "ALL",
        business: "ALL",
        servertype: "ALL",
        page: 1,
        IP: ""

      Base.get("serverbasicmsg", _.extend(defaultParams(), honeyUtils.getHashObj(), params))

    service
  ])
)