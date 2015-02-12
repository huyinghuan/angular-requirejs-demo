define(
  ['app', 'lodash', 'service/base']
, (app, _)->
  app.factory('RealtimeService', ['$log', '$q', 'Base', ($log, $q, Base)->
    uri = "businesslist"
    dataList = null

    service = {}

    service.getBizList = ()->
      Base.get(uri, {}).then((group)->
        queue = []
        queue.push item.name for item in group
        queue
      )

    service.getCityList = (bizName)->
      Base.get(uri, {}).then((result)->
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

    service.getServeListTable = (params)->
      defaultParams = ()->
        computer_room: "广州长宽",
        business: "ALL",
        servertype: "ALL",
        page: 1,
        IP: ""
      Base.get("serverbasicmsg", _.extend(defaultParams(), params))

    service
  ])
)