###
Main Application
###
define [
  'angular'

  # 'leaflet'
  'angularLeaflet'
  'restangular'
], (angular) ->
  app = angular.module 'wheretoeat', ['restangular', 'leaflet-directive']

  # Application Controller
  app.controller 'AppCtrl', [
    '$scope'
    ($scope) ->
      #
  ]

  # Map Controller
  app.controller 'MapCtrl', [
    '$scope'
    ($scope) ->
      console.log 'mapCtrl'
  ]
