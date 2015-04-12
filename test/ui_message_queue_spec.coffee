# Imports
chai = require 'chai'
expect = chai.expect
sinon = require 'sinon'

FifoQueue = require('../src/fifo_queue').FifoQueue
DomDisplay = require('../src/dom_display').DomDisplay
AlertDisplay = require('../src/alert_display').AlertDisplay
UiMessageQueue = require('../src/ui_message_queue').UiMessageQueue

describe "UiMessageQueue", ->
  describe 'handle options', ->
    it 'should create instance with all, valid options', ->
      options =
        delay: 1
        message_box_div_id: "myDiv"
        emptyDisplayString: "hello world"

      messageQueue = new UiMessageQueue(options)
      expect(messageQueue).to.exist

    it 'allows that options to be optional', ->
      expect(->
        new UiMessageQueue()
      ).to.not.throw /Missing arguments/

    describe 'using the delay option', ->
      it 'throws Exception if delay is a string', ->
        options =
          delay: "foo"
        expect(->
          messageQueue = new UiMessageQueue(options)
        ).to.throw 'Invalid argument: delay is not numeric'

      it 'assigns value when valid', ->
        options =
          delay: 999
        messageQueue = new UiMessageQueue(options)

        expect(messageQueue._delay).to.equal(999)

    describe 'using the emptyDisplayString option', ->
      it 'assigns value when valid', ->
        options =
          emptyDisplayString: "foo"
        messageQueue = new UiMessageQueue(options)

        expect(messageQueue._emptyDisplayString).to.equal("foo")


      it 'throws Exception if emptyDisplayString is not a string', ->
        # todo: do we really care about this? its not a comprehensive test anyway
        options =
          emptyDisplayString: true
        expect(->
          messageQueue = new UiMessageQueue(options)
        ).to.throw 'Invalid argument: emptyDisplayString is not a String'

    describe 'default options', ->
      it 'uses default value of 1000 for delay', ->
        options =
          message_box_div_id: "myDiv"

        messageQueue = new UiMessageQueue(options)
        expect(messageQueue._delay).to.equal(1000)

      it 'uses default value of "" for emptyDisplayString', ->
        options =
          message_box_div_id: "myDiv"
        messageQueue = new UiMessageQueue(options)

        expect(messageQueue._emptyDisplayString).to.equal("")

  describe 'select display method', ->
    it 'given options without dom element id should select alert display', ->
      options =
        delay: 999
      messageQueue = new UiMessageQueue(options)

      expect(messageQueue._displayer).to.be.an.instanceof(AlertDisplay)

    it 'given invalid dom element id should select alert display', ->
      options =
        delay: 1
        outputElementId: ""
      messageQueue = new UiMessageQueue(options)

      expect(messageQueue._displayer).to.be.an.instanceof(AlertDisplay)

  describe 'receive and display messages', ->
    beforeEach ->
      options =
        delay: 10000000
        outputElementId: ""
      @mockDisplayer = sinon.createStubInstance(AlertDisplay)
      @messageQueue = new UiMessageQueue(options)
      @messageQueue._displayer = @mockDisplayer


    describe 'add messages to the queue', ->
      it 'should add message to queue', ->
        fakeQueue = sinon.stub(new FifoQueue)
        @messageQueue._messageStack = fakeQueue

        @messageQueue.push "message"

        expect(fakeQueue.push.calledWith("message")).be.true

      it 'should only add message to queue if a string', ->
        fakeQueue = sinon.stub(new FifoQueue)
        @messageQueue._messageStack = fakeQueue

        @messageQueue.push new Object()

        expect(fakeQueue.push.notCalled).to.be.true

    describe 'display messages from queue', ->
      it 'should display message from queue when pushed', ->
        @messageQueue.push "foo"
        expect(@mockDisplayer.displayMessage.calledWith("foo")).to.be.true

      xit 'xx should display first message immediately then the next after interval', ->
        # cannot get this test to work properly :(

        messageQueue.push "foo"

        expect(mockDisplayer.displayMessage).toHaveBeenCalled()

        messageQueue.push "foo"

        jasmine.Clock.tick 10000010

        expect(mockDisplayer.displayMessage.callCount).toEqual(2)

        messageQueue.push "foo"

        jasmine.Clock.tick 10000010

        expect(mockDisplayer.displayMessage.callCount).toEqual(3)

      xit 'xx should display messages in first in first out strategy', ->
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
