'use strict'

###*
 # @ngdoc overview
 # @name ClientCommon
 # @description
 # # ClientCommon
 #
 # Main module of the application.
###

-EPUBJS.VERSION = "0.3"
-EPUBJS.filePath = "scripts/vendors/epub.js"
-EPUBJS.cssPath = "styles/"

angular
  .module 'ClientCommon', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'ngAria',
    'ng-token-auth',
    'ngMaterial',
    'door3.css',
    'ngFileUpload',
    'angular-inview',
    'ui.router',
    'permission'
]

.config ($mdThemingProvider) ->
      $mdThemingProvider.theme('default')

  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
        controllerAs: 'about'
        css: 'styles/main.css'
      .when '/auth',
        templateUrl: 'views/auth.html'
        controller: 'AuthCtrl'
        controllerAs: 'auth'
        css: 'styles/main.css'
      .when '/shelf',
        templateUrl: 'views/shelf.html'
        controller: 'ShelfCtrl'
        controllerAs: 'shelf'
        css: 'styles/main.css'
      .when '/read/:id',
        templateUrl: 'views/read.html'
        controller: 'ReadCtrl'
        controllerAs: 'read'
        css: 'styles/main.css'
      .otherwise
        redirectTo: '/'

  .config ($authProvider) ->
    $authProvider.configure([
      default:
        apiUrl: 'http://localhost:3000/'
        omniauthWindowType: 'sameWindow'
        tokenValidationPath:  'auth/validate_token'
        signOutUrl: 'auth/sign_out'
        storage:  'localStorage'
        forceValidateToken: false
        validateOnPageLoad: true
        authProviderPaths: {
          google:   '/auth/google'
        }
        tokenFormat: {
          "access-token": "{{ token }}",
          "token-type":   "Bearer",
          "client":       "{{ clientId }}",
          "expiry":       "{{ expiry }}",
          "uid":          "{{ uid }}"
        }
        parseExpiry: (headers) ->
          return (parseInt(headers['expiry']) * 1000) || null
        handleLoginResponse: (response) ->
          return response.data
        handleAccountUpdateResponse: (response) ->
          return response.data
        handleTokenValidationResponse: (response) ->
          return response.data
    ])

  .factory 'User', ($auth) ->
    $auth.validateUser()

  .factory 'Book', ($resource) ->
    $resource 'http://localhost:3000/api/books/:id'

  .factory 'Resume', ($resource) ->
    $resource 'http://localhost:3000/api/resumes/:id', null, 'update': method: 'PUT'

  .factory 'Bookmark', ($resource) ->
    $resource 'http://localhost:3000/api/bookmarks/:id'

  .factory 'Annotation', ($resource) ->
    $resource 'http://localhost:3000/api/annotations/:id'
