###*
# An object to display a given message as an alert message.
###
class AlertDisplay
  "use strict"

  ###*
  # public: display the given message
  # @param {string} message The message to be displayed
  ###
  displayMessage: (message) ->
    alert(message)

root = exports ? window
root.AlertDisplay = AlertDisplay
