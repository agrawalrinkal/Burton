'use strict'

describe 'Controller: AuthCtrl', ->

  # load the controller's module
  beforeEach module 'ClientCommon'

  AuthctrlCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    AuthctrlCtrl = $controller 'AuthctrlCtrl', {
      # place here mocked dependencies
    }

#  it 'should attach a list of awesomeThings to the scope', ->
#    expect(AuthctrlCtrl.awesomeThings.length).toBe 3
