define ['angular'], (angular) ->
  angular.module('ngFoursquare', [])
  .constant(
    'FOURSQUARE_API_URL'
    'https://api.foursquare.com/v2'
  )
  .constant(
    'FOURSQUARE_ACCESS_TOKEN'
    'SCK1DQM2MQ0WYCPSEVAXFVTGATJKS4XQDOBSCDGYFRF0B0RJ'
  )
  .constant(
    'FOURSQUARE_API_VERSION'
    '20140806'
  )
  .factory 'Foursquare', [
    '$http'
    'FOURSQUARE_API_URL'
    'FOURSQUARE_ACCESS_TOKEN'
    'FOURSQUARE_API_VERSION'
    ($http, api_url, token, api_version) ->
      FoursquareResource = (url, token, version) ->
        this.url = url
        this.token = token
        this.version = version

      FoursquareResource::get = (endpoint, args) ->
        internalParams =
          oauth_token: this.token
          callback: 'JSON_CALLBACK'
          v: this.version

        params = _.extend internalParams, args

        console.log 'FoursquareResource::get', endpoint, params
        $http.jsonp this.url + '/' + endpoint,
          params: params

      return new FoursquareResource api_url, token, api_version
  ]
