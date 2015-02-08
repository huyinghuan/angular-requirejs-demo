requirejs.config({
  urlArgs: 'v=v' + new Date().getTime(),
  baseUrl: '/js',
  packages: [{
    name:"sc",
    location: 'simple-component'
  }],
  paths: {
    d: 'directive',
    c: 'controller',
    s: 'service',
    jquery: 'vendor/jquery/dist/jquery',
    lodash: '.vendor/lodash/lodash',
    angular: 'vendor/angular/angular',
    'ngCookies': 'vendor/angular-cookies/angular-cookies',
    'uiRouter': 'vendor/angular-ui-router/release/angular-ui-router',
    angularAMD: 'vendor/angularAMD/angularAMD'
  },
  shim: {
    angular: {exports: 'angular'},
    'angularAMD': ['angular'],
    'ngCookies': { deps: ['angular']},
    'uiRouter': { deps: ['angular']},
    lodash: { exports: '_'}
  },
  deps: ['app']
});
