
# Imports

global.window = require("jsdom").jsdom().createWindow();
#jQuery = require('jQuery').jQuery
#global.jQuery = global.$ = jQuery

DomDisplay = require('../../lib/DomDisplay').DomDisplay


describe "DomDisplay", ->

    display = null

    beforeEach ->

        spyOn(document, 'getElementById').andReturn({})

        #display = new DomDisplay("myDiv")

    xit 'should create instance from constructor', ->

        expect(display).toBeDefined()

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

        ).toThrow "Error: cannot find Element Id: 'foo'."


    xit 'respond to displayMessage method', ->

        expect(typeof display.displayMessage).toBe("function")





