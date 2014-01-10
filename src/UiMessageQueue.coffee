###
UiMessageQueue - a User Message Queue Javascript implementation
(c) 2014 Rob Murray
@see https://github.com/rob-murray/ui-message-queue
UiMessageQueue may be freely distributed under the MIT license
###

# testing helper
root = exports ? window

# Imports
AlertDisplay = root.AlertDisplay || require('../lib/AlertDisplay').AlertDisplay
DomDisplay = root.DomDisplay || require('../lib/DomDisplay').DomDisplay
FifoQueue = root.FifoQueue || require('../lib/FifoQueue').FifoQueue

class root.UiMessageQueue

    "use strict"

    # default options

    # timeout value to display message in milisecs
    @DEFAULT_DELAY: 1000

    # default string to display when no messages in queue
    @DEFAULT_EMPTY_DISPLAY_MESSAGE: ""

    # Create new instance with args as options
    constructor: (args) ->
    
        throw new Error("Missing arguments. UiMessageQueue requires arguments to run.") if not args

        # assign ivars
        @_displayer = new AlertDisplay()
        @_delay = UiMessageQueue.DEFAULT_DELAY
        @_emptyDisplayString = UiMessageQueue.DEFAULT_EMPTY_DISPLAY_MESSAGE
        @_messageStack = new FifoQueue()

        @_setOptions args
        @_triggered = false


    # internal; method to set attributes from args passed
    _setOptions: (options)->

        # Test and assign emptyDisplayString
        if options.emptyDisplayString

            throw new Error("Invalid argument: emptyDisplayString is not a String") if not (typeof options.emptyDisplayString == "string")

            @_emptyDisplayString = options.emptyDisplayString


        # Test and assign timeout
        if options.delay

            throw new Error("Invalid argument: delay is not numeric") if not isFinite options.delay
      
            @_delay = options.delay


        if options.outputElementId

            try
                @_displayer = new DomDisplay(options.outputElementId)

            catch e
                @_displayer = new AlertDisplay()

      

    # add a message to the queue
    push: ( message ) =>

        @_messageStack.push message if typeof message == "string"

        # only trigger processing if not already done so,
        # processing will internally work through the queue
        @_processMessageQueue() if @_triggered == false


    # internal; delegate display of message to display strategy
    _displayMessage: (message) =>

        @_displayer.displayMessage message
 

    # internal; grab the first message off the stack, display it
    _processMessageQueue: =>
        
        if @_messageStack.hasItems()

            self = @

            # if the one message in the queue is the first
            # addition then display it immediately
            if @_messageStack.getCount() == 1 and @_triggered == false

                @_displayMessage @_messageStack.getItem()

            # pass reference to this into timeout call and set to run with delay
            setTimeout ((self) ->

                # if there are items in queue then display the next one;
                # otherwise it must be the empty string
                if self._messageStack.hasItems()

                    self._displayMessage self._messageStack.getItem()

                else

                    self._displayMessage self._emptyDisplayString

                # call this method again
                self._processMessageQueue()
          
            ), self._delay, this

            @_triggered = true

        else
            # stop processing
            @_triggered = false

