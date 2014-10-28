###
Require JS Configuration
###
requirejs.config
  baseUrl: 'application'
  paths:
    angular: './vendor/angular/angular'
    bootstrap: './vendor/bootstrap/dist/js/bootstrap'
    underscore: './vendor/underscore/underscore'
    jquery: './vendor/jquery/dist/jquery'
    restangular: './vendor/restangular/dist/restangular'
    domReady: './vendor/requirejs-domready/domReady'
    leaflet: './vendor/leaflet/leaflet'
    angularLeaflet: './vendor/angular-leaflet-directive/dist/angular-leaflet-directive'

  shim:
    angular:
      exports: 'angular'
    bootstrap:
      deps: ['jquery']
    angularLeaflet:
      deps: ['angular']
    restangular:
      deps: ['angular', 'underscore']

  priority: [
    'angular'
  ]


# http://code.angularjs.org/1.2.1/docs/guide/bootstrap#overview_deferred-bootstrap
window.name = "NG_DEFER_BOOTSTRAP!";

# Load the application
require [
  'jquery'
  'underscore'
  'angular'
  'bootstrap'
  'main'
], ($, _, angular, bootstrap, main) ->
  "use strict"
  $html = angular.element(document.getElementsByTagName("html")[0])

  angular.element().ready ->
    angular.resumeBootstrap ['wheretoeat']
    return
