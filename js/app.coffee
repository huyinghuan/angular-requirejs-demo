define(
  ['angularAMD', 'sc', 'angular-ui-router'],
  (angularAMD)->
    app = angular.module("app", ['ui.router', 'simple.component'])
    app.config([
      '$locationProvider',
      '$urlRouterProvider',
      '$stateProvider',
      '$logProvider'
      ($locationProvider, $urlRouterProvider, $stateProvider, $logProvider)->
        #$locationProvider.html5Mode true
        $urlRouterProvider.otherwise('/login')
        $stateProvider
          .state("login", angularAMD.route(
            url: "/login"
            templateUrl: 'views/login.html'
            controller: 'loginController'
            controllerUrl: 'controller/login'
          ))
          .state("main", angularAMD.route(
            url: "/main-panel"
            abstract: true
            templateUrl: 'views/main.html'
            controller: 'MainPanelController'
            controllerUrl: 'controller/main-panel'
          ))
          #重定向
          .state("main.realtime", angularAMD.route(
            url: "/realtime"
            template: '<div ui-view></div>'
            controller: 'RealtimeRedirectController'
            controllerUrl: 'controller/realtime'
          ))
          .state("main.realtime.one", angularAMD.route(
            url: "/:business/:computer_room/:servertype"
            templateUrl: 'views/realtime.html'
            controller: 'RealtimeController'
            controllerUrl: 'controller/realtime'
          ))
          .state("main.detail", angularAMD.route(
            url: "/detail/:business/:computer_room/:hostname"
            templateUrl: 'views/detail.html'
            controller: 'DetailController'
            controllerUrl: 'controller/detail'
          ))

        $urlRouterProvider.when("/", "/login")
        $urlRouterProvider.when("/main-panel", "/main-panel/realtime")
        $logProvider.debugEnabled(true)
    ])
    angularAMD.bootstrap(app)
)