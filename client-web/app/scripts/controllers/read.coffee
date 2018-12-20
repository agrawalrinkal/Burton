'use strict'

###*
 # @ngdoc function
 # @name ClientCommon.controller:ReadCtrl
 # @description
 # # ReadCtrl
 # Controller of the ClientCommon
###

angular.module 'ClientCommon'
.controller 'ReadCtrl', ($auth, $scope, $rootScope, $routeParams, $location, $resource, $mdSidenav, $window, Book, Resume, Bookmark, Annotation) ->

  #
  # Bookmarks
  #

  Bookmark.query {book_id: $routeParams.id}, (bookmarks) ->
    $scope.bookmarks = bookmarks

  #
  # Annotations
  #

  Annotation.query {book_id: $routeParams.bookId}, (annotations) ->
    $scope.annotations = annotations


  #
  # Resume
  #

  Resume.query {book_id: $routeParams.id}, (resume) ->
    $scope.resume = resume[0]


  #
  # Book
  #

  Book.get { id: $routeParams.id }, (source) ->

    #
    # Resume settings - Set to default if resume is not loaded
    #

    spinePosition = if $scope.resume then $scope.resume.spine_position else 0

    #
    # Set Book to scope and epub.js
    #

    $scope.book = source
    book = ePub(source.url)

    # Render book

    rendition = book.renderTo 'render'
    rendition.display(spinePosition)

    jqueryPath = if $location.port() == 80 then "#{$location.protocol()}://#{$location.host()}/bower_components/jquery/dist/jquery.js" else "#{$location.protocol()}://#{$location.host()}:#{$location.port()}/bower_components/jquery/dist/jquery.js"
    bscriptsPath = if $location.port() == 80 then "#{$location.protocol()}://#{$location.host()}/scripts/vendors/bscripts.js" else "#{$location.protocol()}://#{$location.host()}:#{$location.port()}/scripts/vendors/bscripts.js"

    rendition.hooks.content.register (view) ->
      view.addScript(jqueryPath)

    rendition.hooks.content.register (view) ->
      view.addScript(bscriptsPath)


    # TOC

    book.loaded.navigation.then (toc) ->
      $scope.chapters = toc
      return

    $scope.goToChap = (chapHref) ->
      rendition.display(chapHref)

    # Pagination Controls

    $scope.slider =
      position: spinePosition
      length: book.spine.length

    $scope.next = () ->
      spinePosition = spinePosition + 1
      $scope.slider.position = spinePosition
      $scope.resume.spine_position = spinePosition
      Resume.update { id: $scope.resume.id }, $scope.resume
      rendition.next()
#      console.log rendition.currentLocation()

    $scope.prev = () ->
      spinePosition = spinePosition - 1
      $scope.slider.position = spinePosition
      $scope.resume.spine_position = spinePosition
      Resume.update { id: $scope.resume.id }, $scope.resume
      rendition.prev()


    # Text Options

    $scope.enlargeText = () ->
      return

    $scope.shrinkText = () ->
      return

    $scope.changeFont = (font) ->
      # $scope.book.setStyle('font-family', font)
      return


    # Bookmarking

    $scope.newBookmark = () ->
      bookmark = new Bookmark
      bookmark = {
        book_id: $routeParams.id,
        ref: spinePosition
        snippet: "#{spinePosition}"
      }
      Bookmark.save bookmark
      $scope.bookmarks.push bookmark

    $scope.goToBookmark = (bookmarkRef) ->
      rendition.display(bookmarkRef)


    # Annotations

    $scope.newAnnotation = () ->
      console.log $window.document.getSelection()


#        $scope.annotation = new Annotation
#        $scope.annotation = {
#          book_id: $routeParams.bookId,
#          ref: locationCfi
#          snippet: snippet
#        }
#        Annotation.save $scope.annotation, ->
#          return
#        $scope.annotations.push $scope.annotation
#
#    )


    # Rendition Scrolling

    scroll = () ->
      rendition.scrollTo(x, y, silent)


  #
  # Menu Toggling
  #

  buildToggler = (navID) ->
    return ->
      $mdSidenav(navID).toggle().then ->
        # $log.debug 'toggle ' + navID + ' is done'
        return
      return

  $scope.toggleToc = buildToggler('toc')
  $scope.toggleText = buildToggler('text')
  $scope.toggleBookmarks = buildToggler('bookmarks')
  $scope.toggleAnnotations = buildToggler('annotations')

  $scope.isOpenSidenav = (sidenav) ->
    $mdSidenav(sidenav).isOpen()

  $scope.closeSidenav = (sidenav) ->
    $mdSidenav(sidenav).close().then ->
      return
    return



return
