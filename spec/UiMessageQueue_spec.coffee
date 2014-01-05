#global.window = require("jsdom").jsdom().createWindow();

window = require('jsdom').jsdom('<html><body><div id="myDiv"></div></body></html>').createWindow()

UiMessageQueue = require('../lib/UiMessageQueue').UiMessageQueue
#$ = require("jasmine-jquery")

describe "UiMessageQueue", ->

    fixture = null

    describe 'handling options', ->

        it 'should create instance with valid options', ->

            options = 
                timeoutMiliSecs: 1
                message_box_div_id: "myDiv"

            messageQueue = new UiMessageQueue(options)
            expect(messageQueue).toBeDefined()


        it 'ensures that options are supplied', -> 

            expect(->

                new UiMessageQueue()


            ).toThrow 'Missing arguments. UiMessageQueue requires arguments to run.'


        it 'throws Exception if timeoutMiliSecs is a string', ->

            options = 
                timeoutMiliSecs: "foo"

            expect(->

                new UiMessageQueue(options)

            ).toThrow 'Invalid argument: timeoutMiliSecs is not numeric'


    describe 'displays messages', ->

        it 'displays one message immediately', ->

            #el = document.createElement("div");
            #el.id = "myDiv"
            #document.body.appendChild(el)

            #loadFixtures('fixture.html');
            #fixture = $('#tabs')

            #spyOn(global.window.document, 'getElementById').andReturn(el)

            options = 
                timeoutMiliSecs: 1
                message_box_div_id: "myDiv"

            messageQueue = new UiMessageQueue(options)
            messageQueue.push "Foo"

            expect(el.innerHtml).toBe("Foo")




