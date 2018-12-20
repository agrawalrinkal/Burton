'use strict'

###*
 # @ngdoc function
 # @name ClientCommon.controller:ShelfCtrl
 # @description
 # # ShelfCtrl
 # Controller of the ClientCommon
###

angular.module 'ClientCommon'
.controller 'ShelfCtrl', ($scope, $mdSidenav, Book, Upload, $location)->

  #
  # Book Query for Shelf
  #

  $scope.books = Book.query()

  #
  # New Books
  #

  $scope.newBook = {}

  $scope.uploadNewBook = () ->
    Upload.upload(
      url: 'http://localhost:3000/api/books'
      method: 'POST'
      fields:
        'title': $scope.newBook.title
      file: $scope.newBook.epub
      fileFormDataName: 'book[epub]')

    $scope.books.push $scope.newBook
    $scope.newBook = {}

  $scope.read = (book) ->
    $location.path("/read/#{book}")

  #
  # Menu Toggling
  #

  buildToggler = (navID) ->
    return ->
      $mdSidenav(navID).toggle().then ->
        # $log.debug 'toggle ' + navID + ' is done'
        return
      return

  $scope.toggleProfile = buildToggler('profile')
  $scope.toggleNewBook = buildToggler('newBook')
  $scope.toggleGroups = buildToggler('groups')

  $scope.isOpenSidenav = (sidenav) ->
    $mdSidenav(sidenav).isOpen()

  $scope.closeSidenav = (sidenav) ->
    $mdSidenav(sidenav).close().then ->
      return
    return


  return
