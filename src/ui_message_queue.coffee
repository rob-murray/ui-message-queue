# Imports
root = exports ? window
FifoQueue = root.FifoQueue || require('../src/fifo_queue').FifoQueue
DomDisplay = root.DomDisplay || require('../src/dom_display').DomDisplay
AlertDisplay = root.AlertDisplay || require('../src/alert_display').AlertDisplay

###*
# User Message Queue Javascript implementation
###
class UiMessageQueue
  "use strict"

  # timeout value to display message in milisecs
  @DEFAULT_DELAY: 1000

  # default string to display when no messages in queue
  @DEFAULT_EMPTY_DISPLAY_MESSAGE: ""

  ###*
  # Create new instance with given options
  # @param {object} options Object with configuration properties. See README for details.
  ###
  constructor: (options) ->
    throw new Error("Missing arguments. UiMessageQueue requires arguments to run.") if not options

    @_displayer = new AlertDisplay()
    @_delay = UiMessageQueue.DEFAULT_DELAY
    @_emptyDisplayString = UiMessageQueue.DEFAULT_EMPTY_DISPLAY_MESSAGE
    @_messageStack = new FifoQueue()

    @_setOptions options
    @_triggered = false

  ###* internal: method to set attributes from args passed###
  _setOptions: (options)->
    if options.emptyDisplayString
      throw new Error("Invalid argument: emptyDisplayString is not a String") if not (typeof options.emptyDisplayString == "string")
      @_emptyDisplayString = options.emptyDisplayString

    if options.delay
      throw new Error("Invalid argument: delay is not numeric") if not isFinite options.delay
      @_delay = options.delay

    if options.outputElementId
      try
        @_displayer = new DomDisplay(options.outputElementId)
      catch e
        @_displayer = new AlertDisplay()

  ###*
  # public: add a message to the queue
  # @param {string} message The message to be displayed as a string.
  ###
  push: ( message ) =>
    @_messageStack.push message if typeof message == "string"

    # only trigger processing if not already done so;
    @_processMessageQueue() if not @_isProcessing()

  ###* internal: delegate display of message to display strategy###
  _displayMessage: (message) =>
    @_displayer.displayMessage message

  ###* internal: stop processing messages###
  _haltProcessing: =>
    @_triggered = false

  ###* internal: start processing messages on loop###
  _startProcessing: =>
    @_triggered = true

  ###* internal: is currently processing messages###
  _isProcessing: =>
    @_triggered

  ###* internal: grab the next message off the stack and display it###
  _processMessageQueue: =>
    if @_messageStack.hasItems()
      self = @

      # if the one message in the queue is the first
      # addition then display it immediately
      if @_messageStack.getCount() == 1 and not @_isProcessing()
        @_displayMessage @_messageStack.getItem()

      setTimeout ((self) ->
        if self._messageStack.hasItems()
          self._displayMessage self._messageStack.getItem()
        else
          self._displayMessage self._emptyDisplayString

        self._processMessageQueue()
      ), self._delay, this

      @_startProcessing()
    else
      @_haltProcessing()

root.UiMessageQueue = UiMessageQueue
