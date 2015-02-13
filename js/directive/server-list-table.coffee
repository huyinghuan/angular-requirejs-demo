define ['app'], (app)->
  app.directive('serverListTable', ['$timeout', '$location', "honey.utils", ($timeout, $location, honeyUtils)->
    restrict: 'E'
    replace: true
    templateUrl: "views/directive/server-list-table.html"
    scope: {bean: "=", name: '@'}
    link: ($scope, element, attr)->
      bean = $scope.bean
      loadData = ->
        bean.getList($scope.name).then((data)->
          $scope.tableData = data
          $scope.$broadcast("sf-pager:serverList:go", {
            pageIndex: data.pager.currentPage,
            pageCount: data.pager.totalPage
          })
        )

      loadData()
      watchLoad = ->
        $scope.$watch(->
          $location.hash()
        , ->
          loadData()
        )
      $timeout(watchLoad, 2000)


      $scope.$on("sf-pager:serverList:goto", (e, data)->
        console.log data
        $scope.$apply(-> honeyUtils.setHash({page:data.pageIndex}))

      )

      $scope.getStatus = (serverstatus)->
        return "正常" if "#{serverstatus.status}" is "0"
        return serverstatus.value if serverstatus.value isnt ""
        return "故障"

      $scope.getServerType = (type)->
        if "#{type}" is "0" then "物理机" else "虚拟机"

      $scope.isErrorServer = (value)-> "#{value}" isnt "0"
  ])