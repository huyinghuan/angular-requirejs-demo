define ['app', 'lodash'], (app, _)->
  app.directive('serverListTable', ['$timeout', '$location', "$state", "$log", "$q", "honey.utils",
    ($timeout, $location, $state, $log, $q, honeyUtils)->
      restrict: 'E'
      replace: true
      templateUrl: "views/directive/server-list-table.html"
      scope: {bean: "=", name: '@'}
      link: ($scope, element, attr)->
        bean = $scope.bean

        loadData = (params = {})->
          bean.getList($scope.name, params).then((data)->
            $scope.tableData = data
            $scope.$broadcast("sf-pager:serverTablePager:go", {
              pageIndex: data.pager.currentPage,
              pageCount: data.pager.totalPage
            })
          )

        loadData()

        $scope.$on("table:#{$scope.name}:load", (e, params)-> loadData(params))

        #表格 数据值 可读化
        $scope.getStatus = (serverstatus)->
          return "正常" if "#{serverstatus.status}" is "0"
          return serverstatus.value if serverstatus.value isnt ""
          return "故障"
        #表格 数据值 可读化
        $scope.getServerType = (type)-> if "#{type}" is "0" then "物理机" else "虚拟机"
        #表格 数据值 可读化
        $scope.isErrorServer = (value)-> "#{value}" isnt "0"

        #超链接跳转
        $scope.gotoRouter = (name)->
          params = _.extend {}, $state.params, honeyUtils.getHashObj(), {hostname: name}
          $state.go("main.detail", params)
  ])