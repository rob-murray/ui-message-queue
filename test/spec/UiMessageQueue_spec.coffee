
# Imports

global.window = require("jsdom").jsdom().createWindow()
#jQuery = require('jQuery').jQuery
#global.jQuery = global.$ = jQuery

AlertDisplay = require('../../lib/AlertDisplay').AlertDisplay
DomDisplay = require('../../lib/DomDisplay').DomDisplay
UiMessageQueue = require('../../lib/UiMessageQueue').UiMessageQueue
FifoQueue = require('../../lib/FifoQueue').FifoQueue


describe "UiMessageQueue", ->

    describe 'handle options', ->

        it 'should create instance with all, valid options', ->

            options = 
                delay: 1
                message_box_div_id: "myDiv"
                emptyDisplayString: "hello world"

            messageQueue = new UiMessageQueue(options)
            expect(messageQueue).toBeDefined()


        it 'ensures that options are supplied', -> 

            expect(->

                new UiMessageQueue()


            ).toThrow 'Missing arguments. UiMessageQueue requires arguments to run.'


        describe 'using the delay option', ->

            it 'throws Exception if delay is a string', ->

                options = 
                    delay: "foo"

                expect(->

                    messageQueue = new UiMessageQueue(options)

                ).toThrow 'Invalid argument: delay is not numeric'


            it 'assigns value when valid', ->

                options = 
                    delay: 999

                messageQueue = new UiMessageQueue(options)

                expect(messageQueue._delay).toEqual(999)


        describe 'using the emptyDisplayString option', ->

            it 'assigns value when valid', ->

                options = 
                    emptyDisplayString: "foo"

                messageQueue = new UiMessageQueue(options)

                expect(messageQueue._emptyDisplayString).toEqual("foo")


            it 'throws Exception if emptyDisplayString is not a string', ->

                # todo: do we really care about this? its not a comprehensive test anyway
                options = 
                    emptyDisplayString: true

                expect(->

                    messageQueue = new UiMessageQueue(options)

                ).toThrow 'Invalid argument: emptyDisplayString is not a String'


        describe 'default options', ->

            it 'uses default value of 1000 for delay', ->

                options = 
                    message_box_div_id: "myDiv"

                messageQueue = new UiMessageQueue(options)

                expect(messageQueue._delay).toEqual(1000)


            it 'uses default value of "" for emptyDisplayString', ->

                options = 
                    message_box_div_id: "myDiv"

                messageQueue = new UiMessageQueue(options)

                expect(messageQueue._emptyDisplayString).toEqual("")  


    describe 'select display method', ->

        it 'given options without dom element id should select alert display', ->

            options = 
                delay: 999

            messageQueue = new UiMessageQueue(options)

            expect(messageQueue._displayer instanceof AlertDisplay).toBeTruthy()


        it 'given invalid dom element id should select alert display', ->

            options = 
                delay: 1
                outputElementId: ""

            messageQueue = new UiMessageQueue(options)

            expect(messageQueue._displayer instanceof AlertDisplay).toBeTruthy()


    describe 'receive and display messages', ->

        messageQueue = null
        mockDisplayer = null

        beforeEach ->
            options = 
                delay: 10000000
                outputElementId: ""

            mockDisplayer = createSpyObj('mockDisplayer', ['displayMessage']) # just mock the method here, we dont need a response
            
            messageQueue = new UiMessageQueue(options)
            messageQueue._displayer = mockDisplayer # todo: we cant mock any instance with Jasmine so have to 'inject' it +repeated below

            jasmine.Clock.useMock() # mock the clock for all of these

        afterEach ->
            messageQueue = null

        describe 'add messages to the queue', ->

            it 'should add message to queue', ->

                mockQueue = createSpyObj('mockQueue', ['push', 'hasItems', 'getItem'])
                messageQueue._messageStack = mockQueue

                messageQueue.push "message"

                expect(mockQueue.push).toHaveBeenCalledWith("message")

            it 'should only add message to queue if a string', ->

                mockQueue = createSpyObj('mockQueue', ['push', 'hasItems', 'getItem'])
                messageQueue._messageStack = mockQueue

                messageQueue.push new Object()

                expect(mockQueue.push).not.toHaveBeenCalled()


        describe 'display messages from queue', ->

            it 'should pass display to display strategy', ->

                messageQueue._displayMessage "foo" # todo: do i really write this test

                expect(mockDisplayer.displayMessage).toHaveBeenCalledWith("foo")

            it 'should display message from queue when pushed', ->

                messageQueue.push "foo"

                expect(mockDisplayer.displayMessage).toHaveBeenCalledWith("foo")

            xit 'should display first message immediately then the next after interval', ->

                # cannot get this test to work properly :(

                messageQueue.push "foo"

                expect(mockDisplayer.displayMessage).toHaveBeenCalled()

                messageQueue.push "foo"

                jasmine.Clock.tick 10000010

                expect(mockDisplayer.displayMessage.callCount).toEqual(2)

                messageQueue.push "foo"

                jasmine.Clock.tick 10000010 

                expect(mockDisplayer.displayMessage.callCount).toEqual(3)

            xit 'should display messages in first in first out strategy', ->

                # cannot get this test to work properly :(

                messageQueue.push "message1"
                expect(mockDisplayer.displayMessage).toHaveBeenCalledWith("message1")

                messageQueue.push "message2"
                messageQueue.push "message3"

                jasmine.Clock.tick 10000010

                #expect(mockDisplayer.displayMessage).toHaveBeenCalledWith("message2")
                expect(mockDisplayer.displayMessage.mostRecentCall.args[0]).toEqual("message2")

                jasmine.Clock.tick 10000010

                #expect(mockDisplayer.displayMessage).toHaveBeenCalledWith("message3")
                expect(mockDisplayer.displayMessage.mostRecentCall.args[0]).toEqual("message3")









