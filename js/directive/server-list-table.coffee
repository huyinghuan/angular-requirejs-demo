define ['app'], (app)->
  app.directive('serverListTable', [->
    restrict: 'E'
    replace: true
    templateUrl: "views/directive/server-list-table.html"
    scope: {bean: "=", name: '@'}
    link: ($scope, element, attr)->
      bean = $scope.bean
      loadData = (params)->
        bean.getList($scope.name, params).then((data)->
          $scope.tableData = data
          $scope.$broadcast("sf-pager:serverList:go", {
            pageIndex: data.pager.currentPage,
            pageCount: data.pager.totalPage
          })
        )

      loadData()


      $scope.$on("sf-pager:serverList:goto", (e, data)->
        loadData({page: data.pageIndex})
      )

      $scope.getStatus = (serverstatus)->
        return "正常" if "#{serverstatus.status}" is "0"
        return serverstatus.value if serverstatus.value isnt ""
        return "故障"

      $scope.getServerType = (type)->
        if "#{type}" is "0" then "物理机" else "虚拟机"

      $scope.isErrorServer = (value)-> "#{value}" isnt "0"
  ])