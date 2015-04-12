# Imports
chai = require 'chai'
expect = chai.expect
AlertDisplay = require('../src/alert_display').AlertDisplay

describe "AlertDisplay", ->
  beforeEach ->
    @display = new AlertDisplay()

  it 'should create instance from constructor', ->
    expect(@display).to.exist

  it 'respond to displayMessage method', ->
    expect(@display).to.respondTo('displayMessage')
