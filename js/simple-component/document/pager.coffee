define ['SimpleComponent', 'jquery.honey.pagination'], (SimpleComponent)->
  template = '<div></div>'

  scope = clazz: '@', title: '@'

  SimpleComponent.directive('sfPager',[->
    restrict: 'E'
    replace: true
    template: template
    scope: {name: "@"}
    link: ($scope, element, attr)->
      pager = $(element).pagination({pageIndex:1, pageCount: 1, href: false})

      $scope.$on("sf-pager:#{$scope.name}:go", (event, pageData)->
        pager.goto({pageIndex: pageData.pageIndex, pageCount: pageData.pageCount})
      )

      pager.on('goto', (e, data)->
        $scope.$emit("sf-pager:#{$scope.name}:goto", data)
      )
  ])