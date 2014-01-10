
# Imports

global.window = require("jsdom").jsdom().createWindow();
#jQuery = require('jQuery').jQuery
#global.jQuery = global.$ = jQuery

AlertDisplay = require('../../lib/AlertDisplay').AlertDisplay


describe "AlertDisplay", ->

    display = null

    beforeEach ->
        display = new AlertDisplay()

    it 'should create instance from constructor', ->

        expect(display).toBeDefined()

    it 'respond to displayMessage method', ->

        expect(typeof display.displayMessage).toBe("function")



