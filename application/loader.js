
/*
Require JS Configuration
 */
requirejs.config({
  baseUrl: 'application',
  paths: {
    angular: './vendor/angular/angular',
    bootstrap: './vendor/bootstrap/dist/js/bootstrap',
    underscore: './vendor/underscore/underscore',
    jquery: './vendor/jquery/dist/jquery',
    restangular: './vendor/restangular/dist/restangular',
    domReady: './vendor/requirejs-domready/domReady',
    leaflet: './vendor/leaflet/leaflet',
    angularLeaflet: './vendor/angular-leaflet-directive/dist/angular-leaflet-directive',
    angularResource: './vendor/angular-resource/angular-resource',
    angularUiSelect: './vendor/angular-ui-select/dist/select.min',
    angularLoadBar: './vendor/angular-loading-bar/build/loading-bar.min',
    angularAnimate: './vendor/angular-animate/angular-animate'
  },
  shim: {
    angular: {
      exports: 'angular'
    },
    bootstrap: {
      deps: ['jquery']
    },
    angularLeaflet: {
      deps: ['angular']
    },
    angularResource: {
      deps: ['angular']
    },
    angularUiSelect: {
      deps: ['angular', 'underscore']
    },
    angularLoadBar: {
      deps: ['angular']
    },
    angularAnimate: {
      deps: ['angular']
    }
  },
  priority: ['angular']
});

window.name = "NG_DEFER_BOOTSTRAP!";

require(['jquery', 'underscore', 'angular', 'bootstrap', 'main'], function($, _, angular, bootstrap, main) {
  "use strict";
  var $html;
  $html = angular.element(document.getElementsByTagName("html")[0]);
  return angular.element().ready(function() {
    angular.resumeBootstrap(['wheretoeat']);
  });
});
