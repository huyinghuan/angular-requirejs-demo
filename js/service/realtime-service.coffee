define(
  ['app', 'lodash', 'service/base']
, (app, _)->
  app.factory('RealtimeService', ['$log', '$q', 'Base', 'honey.utils', ($log, $q, Base, honeyUtils)->

    service = {}

    service.getBizList = ()->
      Base.get("businesslist", {}).then((group)->
        queue = []
        queue.push item.name for item in group
        queue
      )

    service.getComputerRoom = (bizName)->
      Base.get("businesslist", {}).then((result)->
        return queue if not result.length
        if not bizName
          checkedItemList = result[0].value
        else
          for item in result
            if item.name is bizName
              checkedItemList = item.value
              break
        checkedItemList
      )

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