
/*
Main Application
 */
define(['angular', 'angularLeaflet', 'angularResource', 'service', 'angularUiSelect', 'angularAnimate', 'angularLoadBar'], function(angular) {
  var app;
  app = angular.module('wheretoeat', ['leaflet-directive', 'ngFoursquare', 'ui.select', 'angular-loading-bar', 'ngAnimate']);
  app.config([
    'uiSelectConfig', function(uiSelectConfig) {
      return uiSelectConfig.theme = 'bootstrap';
    }
  ]);
  app.controller('AppCtrl', ['$scope', function($scope) {}]);
  return app.controller('MapCtrl', [
    '$scope', '$location', '$http', 'Foursquare', function($scope, $location, $http, Foursquare) {
      Foursquare.get('venues/categories').success(function(data) {
        var foodCategories;
        foodCategories = _.find(data.response.categories, function(section) {
          return section.name === 'Food';
        });
        $scope.baseFoodCategory = foodCategories.id;
        return $scope.categories = foodCategories.categories;
      }).error(function() {
        return console.error('Unable to load Foursquare Categories');
      });
      $scope.working = false;
      $scope.search = [];
      $scope.$watch('search', function(old, newValues) {
        if (old === newValues) {
          return;
        }
        return $scope.loadPlaces();
      });
      $scope.loadPlaces = function() {
        if ($scope.working) {
          return;
        }
        return window.loadPlaceTimeout = setTimeout(function() {
          var categoryIds, params;
          clearTimeout(window.loadPlaceTimeout);
          $scope.working = true;
          params = {
            limit: 50,
            radius: 8000,
            intent: 'browse'
          };
          categoryIds = _.pluck($scope.search, 'id');
          if (!categoryIds.length) {
            categoryIds.push($scope.baseFoodCategory);
          }
          if ($scope.center != null) {
            params.ll = $scope.center.lat + ',' + $scope.center.lng;
          }
          if (categoryIds.length) {
            params.categoryId = categoryIds.join(',');
          }
          return Foursquare.get('venues/search', params).success(function(data) {
            $scope.places = {};
            _.each(data.response.venues, function(venue) {
              var foursquareUrl, message;
              console.log(venue);
              foursquareUrl = 'https://foursquare.com/v/venue/' + venue.id;
              foursquareUrl += '?referralId=' + venue.referralId;
              message = '<h6><a href="' + foursquareUrl + '" target="_blank">' + venue.name + '</a></h6>';
              if (venue.url != null) {
                message += '<br><a href="' + venue.url + '" target="_blank">(Visit Site)</a>';
              }
              return $scope.places[venue.id] = {
                lat: venue.location.lat,
                lng: venue.location.lng,
                message: message,
                focus: false
              };
            });
            return $scope.working = false;
          }).error(function() {
            return console.error('Erroring search Foursquare API');
          });
        }, 300);
      };
      $scope.center = {
        lat: 40.7127,
        lng: -74.0059,
        zoom: 14,
        autoDiscover: true
      };
      $scope.tiles = {
        url: 'http://api.tiles.mapbox.com/v4/{mapid}/{z}/{x}/{y}.png?access_token={apikey}',
        options: {
          mapid: 'srtfisher.k2l8aj89',
          apikey: 'pk.eyJ1Ijoic3J0ZmlzaGVyIiwiYSI6Ikp3V1BmWlUifQ.jeUW0RqxDszY_SckLD_1Gg'
        }
      };
      $scope.$on('centerUrlHash', function(e, hash) {
        return $location.search({
          c: hash
        });
      });
      return $scope.$watch('center', function(old, newValues) {
        if (old === newValues) {
          return;
        }
        return $scope.loadPlaces();
      });
    }
  ]);
});
