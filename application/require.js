
/*
Require JS Configuration
 */
requirejs.config({
  baseUrl: 'application',
  paths: {
    angular: './vendor/angular/angular.js',
    bootstrap: './vendor/dist/js/bootstrap.js',
    jquery: './vendor/jquery/dist/jquery.js',
    restangular: './vendor/dist/restangular.js',
    domReady: './vendor/requirejs-domready/domReady.js'
  },
  shim: {
    angular: {
      exports: 'angular'
    }
  },
  priority: ['angular']
});

window.name = "NG_DEFER_BOOTSTRAP!";

requirejs(['jquery', 'angular', 'bootstrap', 'main'], function($, angular, bootstrap, main) {});
