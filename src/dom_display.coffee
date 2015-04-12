###*
# An object to display a given message in an html dom
###
class DomDisplay
  "use strict"

  ###*
  # Create new instance of DomDisplay
  # @param {string} domElementId The element id of the dom to manipulate. Must
  #   exist or Error thrown.
  ###
  constructor: (domElementId) ->
    if not @_domElement = root.document.getElementById(domElementId)
      throw new Error("Error: cannot find Element Id: '#{domElementId}'.")

  ###*
  # public: display the given message
  # @param {string} message The message to be rendered
  ###
  displayMessage: (message) =>
    @_domElement.innerHTML = message

root = exports ? window
root.DomDisplay = DomDisplay
