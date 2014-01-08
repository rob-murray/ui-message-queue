
# testing helper
root = exports ? window

# Define namespace
#root.UiMessageQueue or= {}


class root.DomDisplay

    "use strict"

    constructor: (domElementId) ->

        throw new Error("Error: cannot find Element Id: '#{domElementId}'.") if not @_domElement = root.document.getElementById(domElementId)

    displayMessage: (message) =>

        @_domElement.innerHTML = message

