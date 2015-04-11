class AlertDisplay
    "use strict"

    displayMessage: (message) ->
        alert(message)

root = exports ? window
root.AlertDisplay = AlertDisplay
