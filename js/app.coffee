define(['angularAMD', 'uiRouter'], (angularAMD)->
  app = angular.module("app", ['ui.router'])
  app.config([
    '$locationProvider',
    '$urlRouterProvider',
    '$stateProvider', ($locationProvider, $urlRouterProvider, $stateProvider)->
      $locationProvider.html5Mode true
      $urlRouterProvider.otherwise('/login')
      $stateProvider.state("login", angularAMD.route({
        url: "/login"
        templateUrl: 'login.html',
        controller: 'loginController',
        controllerUrl: 'controller/login-controller'
      }))
      $urlRouterProvider.when("/", "/login");
  ])
  angularAMD.bootstrap(app)
)