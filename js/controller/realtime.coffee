define(
  ['app', 's/realtime-service', 'd/server-list-table', 'scf/select'],
  (app)->
    class Biz
      constructor: (service, $q)->
        @service = service
        @$q = $q

      bizList: ->
        deferred = @$q.defer()
        data = [{name: 1, value: 1},{name: 2, value: 2}]
        deferred.resolve(data)
        deferred.promise

      cityList: ->
        deferred = @$q.defer()
        data = [{name: "长沙", value: "changsha"},{name: "株洲", value: "zhuzhou"}]
        deferred.resolve(data)
        deferred.promise

    app.controller('RealtimeController',
      [
        '$scope'
        '$state'
        '$q'
        '$log'
        'RealtimeService'
        ($scope, $state, $q, $log, RealtimeService)->
          biz = new Biz(RealtimeService, $q)
          $scope.bean = {
            getList: (name)-> biz[name]()
          }
      ]
    )
)