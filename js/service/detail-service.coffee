define(
  ['app', 'service/base']
, (app)->
  app.factory('DetailService', ['$log', 'Base', ($log, Base)->
    service = {}

    service.getBroomList = (business)->
      Base.get("broomlist", {business: business})

    service.getHostnameList = (business, computer_room)->
      Base.get('roomserverlist', {business: business, computer_room: computer_room})

    service.getHardware = (hostname, hardware)->
      Base.get("servermsg", {hostname: hostname, hardware: hardware})

    service.getHostName = (hostname)->
      Base.get("hostfindname", {hostname: hostname}).then((data)->
        [data]
      )

    service
  ])
)