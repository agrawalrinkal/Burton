'use strict'

###*
 # @ngdoc function
 # @name ClientCommon.controller:AuthCtrl
 # @description
 # # AuthCtrl
 # Controller of the ClientCommon
###

angular.module 'ClientCommon'
.controller 'AuthCtrl', ($scope, $auth, $location, $window)->

  # Force redirect to app path to remove auth query string
  hash = '/#'
  path = $location.path()
  url = hash.concat(path)

  $window.location.href = url

  return
