
# testing helper
root = exports ? window

# A First In First Out (FIFO) queue implementation
class root.FifoQueue

    "use strict"

    # Create new instance of FifoQueue
    constructor: () ->

        @_stack = []


    # Add an to the queue, not so if null
    push: ( obj ) ->

        @_stack.push obj unless obj == null


    # Return the number of items in the queue
    getCount: () ->
        @_stack.length


    # Return boolean, true if queue currently has items, false if empty
    hasItems: () ->
        @getCount() > 0


    # Get, remove and return the first item in the queue,
    # unless queue empty then throws Error - should check hasItems() first
    getItem: () ->

        if not @hasItems()
            throw new Error("Queue empty, ensure not empty by using FifoQueue.hasItems().")

        item = @_stack[0]
        @_stack.shift()
        return item