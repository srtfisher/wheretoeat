###
Main Application
###
define [
  'angular'

  'angularLeaflet'
  'angularResource'
  'service'
  'angularUiSelect'
  'angularAnimate'
  'angularLoadBar'
], (angular) ->
  app = angular.module 'wheretoeat', [
    'leaflet-directive'
    'ngFoursquare'
    'ui.select'
    'angular-loading-bar'
    'ngAnimate'
  ]

  # Configuration
  app.config [
    'uiSelectConfig'
    (uiSelectConfig) ->
      uiSelectConfig.theme = 'bootstrap';
  ]

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
    'Foursquare'
    ($scope, $location, $http, Foursquare) ->
      Foursquare.get('venues/categories')
        .success (data) ->
          # Pull out the food section
          foodCategories = _.find data.response.categories, (section) ->
            section.name == 'Food'

          $scope.baseFoodCategory = foodCategories.id
          $scope.categories = foodCategories.categories
        .error ->
          console.error 'Unable to load Foursquare Categories'

      # Load Places Callback
      $scope.working = false
      $scope.search = []

      $scope.$watch 'search', (old, newValues) ->
        # Only if it's a change
        return if old == newValues

        # Push to load method
        $scope.loadPlaces()

      # Load places based upon map location and categories
      $scope.loadPlaces = ->
        return if $scope.working

        # Apply timeout after 300ms
        window.loadPlaceTimeout = setTimeout ->
          # Ensure no stacking of timeouts
          clearTimeout window.loadPlaceTimeout
          $scope.working = true

          # Build query
          params =
            limit: 50
            radius: 8000
            intent: 'browse'

          # Build the categories
          categoryIds = _.pluck $scope.search, 'id'

          # If there are no categories, limit the results to just food
          unless categoryIds.length
            categoryIds.push $scope.baseFoodCategory

          if $scope.center?
            params.ll = $scope.center.lat + ',' + $scope.center.lng

          if categoryIds.length
            params.categoryId = categoryIds.join ','

          Foursquare.get('venues/search', params)
          .success (data) ->
            # Add venues to the map
            $scope.places = {}

            # Format foursquare venue to marker
            _.each data.response.venues, (venue) ->
              console.log venue
              foursquareUrl = 'https://foursquare.com/v/venue/' + venue.id
              foursquareUrl += '?referralId=' + venue.referralId

              # Build a marker message
              message = '<h6><a href="' + foursquareUrl + '" target="_blank">' + venue.name + '</a></h6>'

              if venue.url?
                message += '<br><a href="' + venue.url + '" target="_blank">(Visit Site)</a>'

              $scope.places[venue.id] =
                lat: venue.location.lat
                lng: venue.location.lng
                message: message
                focus: false

            $scope.working = false
          .error ->
            console.error 'Erroring search Foursquare API'
        , 300

      # Map Logic
      $scope.center =
        lat: 40.7127
        lng: -74.0059
        zoom: 14
        autoDiscover: true

      $scope.tiles =
        url: 'http://api.tiles.mapbox.com/v4/{mapid}/{z}/{x}/{y}.png?access_token={apikey}'
        options:
          mapid: 'srtfisher.k2l8aj89'
          apikey: 'pk.eyJ1Ijoic3J0ZmlzaGVyIiwiYSI6Ikp3V1BmWlUifQ.jeUW0RqxDszY_SckLD_1Gg'

      $scope.$on 'centerUrlHash', (e, hash) ->
        $location.search(c: hash);

      $scope.$watch 'center', (old, newValues) ->
        return if old == newValues

        $scope.loadPlaces()

      # Watching for a drag to reload the places to eat
      # $scope.$on 'leafletDirectiveMap.dragend', (event) ->
      #   $scope.loadPlaces()
  ]
