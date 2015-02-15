define(['app', 'd/harddisk-table', 's/detail-service'],
  (app)->
    class Biz
      constructor: (@service, @params)->
      computer_room: ->
        @service.getBroomList(@params.business)
      hostname: ->
        @service.getHostnameList(@params.business, @params.computer_room)

    app.controller('DetailController',
      [
        '$scope'
        '$state'
        '$log'
        'DetailService'
        ($scope, $state, $log, service)->
          $log.log $state.params

          biz = new Biz(service, $state.params)
          getData = (name, params)-> if biz[name] then biz[name](params) else biz['default']()

          $scope.bean = {
            getList: getData
            getData: getData
          }

      ]
    )
)