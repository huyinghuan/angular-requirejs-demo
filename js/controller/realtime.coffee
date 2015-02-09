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
        data = [{name: 1, value: 1},{name: 2, value: 2}]
        @q(data)

      cityList: ->
        data = [{name: "长沙", value: "changsha"},{name: "株洲", value: "zhuzhou"}]
        @q(data)

      timeBucket: ->
        @q({startDate: new Date(), endDate: moment()})

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
          getData = (name)-> if biz[name] then biz[name]() else biz['default']()
          $scope.bean = {
            getList: getData
            getData: getData
          }
      ]
    )
)