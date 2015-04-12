# A First In First Out (FIFO) queue implementation
#
class FifoQueue
  "use strict"

  ###*
  # Create new instance of FifoQueue
  # @param {object} options Object with configuration properties. See README for details.
  ###
  constructor: ->
    @_stack = []

  ###*
  # public: Add an to the queue
  # @param {object} obj Object to be added to the queue. Must not be `null`.
  ###
  push: ( obj ) ->
    @_stack.push obj unless obj == null

  ###*
  # public: Return the number of items in the queue
  ###
  getCount: ->
    @_stack.length

  ###*
  # public: Return boolean, true if queue currently has items, false if empty
  ###
  hasItems: ->
    @getCount() > 0

  ###*
  # public: Fetch, remove and return the first item in the queue, unless queue empty
  #   then throws Error - should check hasItems() first
  ###
  getItem: ->
    if not @hasItems()
      throw new Error("Queue empty, ensure not empty by using FifoQueue.hasItems().")
    @_stack.shift()

root = exports ? window
root.FifoQueue = FifoQueue
