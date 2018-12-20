'use strict'

###*
 # @ngdoc function
 # @name ClientCommon.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the ClientCommon
###

angular.module 'ClientCommon'
.controller 'AboutCtrl', ($scope, $auth, $location, $window)->

  $scope.login = () ->
    authenticate('google')

  # Force redirect to app path to remove auth query string

  if (window.location.search.length > 0)
    $window.location.href = '/#/shelf'




  return
