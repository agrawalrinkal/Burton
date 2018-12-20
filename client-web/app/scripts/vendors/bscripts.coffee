#
# Burton Scripts
#
# Additional scripts embedded in Epub.js iframes
#


#
# Append Annotator.js to <body>
#

defer = (method) ->
  if window.jQuery
    method()
  else
    setTimeout (->
      defer method
    ), 50

defer ->

  s = document.createElement('script')
  s.type = 'text/javascript'
  s.src = 'http://localhost:9000/scripts/vendors/annotator.js'
  $('body').append s


  #
  # Retrieve Headers & Routing ID
  #

  bookID = window.location.hash.split('/')[2]
  baseURI = document.getElementsByTagName('body')[0].baseURI
  localHeaders = JSON.parse('[' + localStorage.getItem('auth_headers') + ']')[0]


  setAnnotation = ->
    beforeAnnotationCreated: (annotation) ->
      annotation.book_id = bookID
      annotation.base_uri = baseURI
      return
    annotationCreated: (annotation) ->
      console.log annotation

  #
  # Declare & configure Annotator.js
  #

  app = new (annotator.App)
  app.include annotator.ui.main

  app.include annotator.storage.http,
    prefix: 'http://localhost:3000/api'
    headers: localHeaders

  app.include setAnnotation
#  app.include annotator.storage.debug

  app.start().then ->
    app.annotations.load
      book_id: bookID
      base_uri: baseURI

