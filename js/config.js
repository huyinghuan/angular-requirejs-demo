requirejs.config({
  baseUrl: '/js',
  paths: {
    jquery: '../vendor/jquery/dist/jquery',
    lodash: '../vendor/lodash/lodash',
    angular: '../vendor/angular/angular',
    'ngCookies': '../vendor/angular-cookies/angular-cookies',
    'uiRouter': '../vendor/angular-ui-router/release/angular-ui-router',
    angularAMD: '../vendor/angularAMD/angularAMD'
  },
  packages: [

  ],
  shim: {
    angular: {exports: 'angular'},
    'angularAMD': ['angular'],
    'ngCookies': { deps: ['angular']},
    'uiRouter': { deps: ['angular']},
    lodash: { exports: '_'}
  },
  deps: ['app']
});
