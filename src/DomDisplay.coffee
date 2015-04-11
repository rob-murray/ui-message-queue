class DomDisplay
    "use strict"

    constructor: (domElementId) ->
        if not @_domElement = root.document.getElementById(domElementId)
            throw new Error("Error: cannot find Element Id: '#{domElementId}'.")

    displayMessage: (message) =>
        @_domElement.innerHTML = message

root = exports ? window
root.DomDisplay = DomDisplay
