###
Main Application
###
define [
  'angular'

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
    '$location'
    '$http'
    ($scope, $location, $http) ->
      # Category Logic
      $scope.categories = []

      # Load Places Callback
      $scope.loadPlaces = ->


      # Map Logic
      $scope.center =
        lat: 40.7127
        lng: -74.0059
        zoom: 10
        autoDiscover: true

      $scope.tiles =
        url: 'http://api.tiles.mapbox.com/v4/{mapid}/{z}/{x}/{y}.png?access_token={apikey}'
        options:
          mapid: 'srtfisher.k2l8aj89'
          apikey: 'pk.eyJ1Ijoic3J0ZmlzaGVyIiwiYSI6Ikp3V1BmWlUifQ.jeUW0RqxDszY_SckLD_1Gg'

      # $scope.$on 'centerUrlHash', (e, hash) ->
      #   $location.search(c: hash);

      # Watching for a drag to reload the places to eat
      $scope.$on 'leafletDirectiveMap.dragend', (event) ->
        $scope.loadPlaces()
  ]
