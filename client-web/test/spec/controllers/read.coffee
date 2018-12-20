'use strict'

describe 'Controller: ReadCtrl', ->

  # load the controller's module
  beforeEach module 'ClientCommon'

  ReadCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ReadCtrl = $controller 'ReadCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(ReadCtrl.awesomeThings.length).toBe 3
