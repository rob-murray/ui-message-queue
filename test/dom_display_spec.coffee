# Imports
chai = require 'chai'
sinon = require 'sinon'
expect = chai.expect
DomDisplay = require('../src/dom_display').DomDisplay

describe "DomDisplay", ->
  beforeEach ->
    sinon.stub(document, 'getElementById').returns({})

  xit 'should create instance from constructor', ->
    expect(new DomDisplay()).to.exist

  xit 'ensures that dom element id is supplied', ->
    expect(->
      new DomDisplay()
    ).toThrow 'Missing DOM Element Id param.'

  # todo: this is the same as 'should create instance from constructor'
  xit 'creates instance when valid dom element id', ->
    # to do

  xit 'throws Exception when dom element id is invalid', ->
    expect(->
      new DomDisplay("foo")
    ).to.throw "Error: cannot find Element Id: 'foo'."

  xit 'respond to displayMessage method', ->
    expect(new DomDisplay("element_id")).to.respondTo('displayMessage')
