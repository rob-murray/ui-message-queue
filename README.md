# ui-message-queue AKA User Message Queue Javascript implementation

## Description

ui-message-queue is a Javascript implementation of a message queue allowing you to push messages (String) to the queue and display  via a First In First Out (FIFO) method. This means that you can load up messages and they each have a defined display time after which will be overwritten with the next message or cleared.

## Contents

This repository contains the following sections:

1. src - this contains the source Coffeescript.
2. ui-message-queue.js - this is the Javascript implementation (copy this to use!)
3. demo - this contains a simple demo to show the functionality

## Getting started

How to use:

1. Copy Javascript source to project
2. Import source file

	<script type="text/javascript" src="ui-message-queue.js"></script>

3. Options:
Takes options in the form of an object literal:

```
    options = {
        message_box_div_id: "output-id",
        timeout_val: TIME_IN_MSECS,
        empty_display_str: "STRING"
    };
```

These are as follows:
* message_box_div_id [OPTIONAL] - The ID of the element in the DOM to add messages to. If this is not found then ui-message-queue falls back to using the alert popup box
* timeout_val [OPTIONAL] - Time in milisecs to display each message for. Throws "Invalid argument" Error if not numeric. Default val is 1000
* empty_display_str [OPTIONAL] - This is message displayed when no messages are in the queue. Default val is "..."

If no options passed then throws "Missing arguments" Error.

4. Create instance of object

```
    var myMq = new uiMessageQueue(options);
```

5. Add messages to the queue

```
    myMq.push("Here is a message");
    myMq.push("Here is another one");
    myMq.push("Finally, one more message");
```

These will be displayed in a FIFO method.

Please see the demo for full example.

## Contributions

Please use the GitHub pull-request mechanism to submit contributions.
Please end the coffeescript source and then compile to js - Do not edit ui-message-queue.js!!

Simply compile with "coffee -c ui-message-queue.coffee"

## License

This project is available for use under the MIT software license.
See LICENSE
