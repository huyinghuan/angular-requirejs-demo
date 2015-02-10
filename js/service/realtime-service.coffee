define(
  ['app', 'service/base']
, (app)->
  app.factory('RealtimeService', ['$log', '$q', 'Base', ($log, $q, Base)->
    uri = "businesslist"
    dataList = null

    service = {}

    service.getBizList = ()->
      Base.get(uri, {}).then((result)->
        result.group
      ).then((data)->
        dataList = data
      ).then((group)->
        queue = []
        queue.push item.name for item in group
        queue
      )

    service.getCityList = (bizName)->
      Base.get(uri, {}).then((result)->
        group = result.group or []
        #result.group
        queue = []
        return queue if not group.length
        if not bizName
          checkedItemList = group[0].value
        else
          for item in group
            if item.name is bizName
              checkedItemList = item.value
              break

        for checkedItem in checkedItemList
          queue.push checkedItem.name

        queue

      )

    service
  ])
)