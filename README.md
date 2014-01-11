# ui-message-queue AKA User Message Queue Javascript implementation

[![Build Status](https://travis-ci.org/rob-murray/ui-message-queue.png?branch=master)](https://travis-ci.org/rob-murray/ui-message-queue)

## Description

ui-message-queue is a Javascript implementation of a message queue allowing you to push messages (simple Strings) to the queue and display in a DOM element via a First In First Out (FIFO) method. This means that you can load up messages and they each have a defined display time after which will be overwritten with the next message or cleared.

The **goal** is to be as simple as possible to include and use, it's meant for displaying messages to website users rather than queuing backend type tasks.

**Check out** a demo [here](http://rob-murray.github.com/ui-message-queue).

Features:

* Add messages to queue; displayed in FIFO order.
* Select the DOM element to update, falling back to Javascript Alert if not found.
* No jQuery! Whilst fantastic as it is, can be a pain to have to include jQuery just for one library so we're jQuery free zone.

## Contents

This repository contains the following sections:

1. `src` - this contains the source Coffeescript.
2. `lib/UiMessageQueue-release.js` - the source is then compiled into this Javascript file (copy this to use!).
3. `test/spec/*_spec.coffee` - the tests implemented in Jasmine.
4. `test/html/index.html` - some real life html with proper Javascript to test this project.
5. A working demo is available [here](http://rob-murray.github.com/ui-message-queue) - check it out to see what UiMessageQueue can do.


## Getting started

How to use:

1) Copy Javascript source from `lib/UiMessageQueue-release.js` to project

2) Import source file


```javascript
    <script type="text/javascript" src="UiMessageQueue-release.js"></script>
```


3) Options


Takes options in the form of an object literal:

```javascript
    options = {
        outputElementId: "output-id",
        delay: TIME_IN_MSECS,
        emptyDisplayString: "STRING"
    };
```

These are as follows:
* outputElementId [OPTIONAL] - The ID of the element in the DOM to add messages to. If this is not found then ui-message-queue falls back to using the alert popup box
* delay [OPTIONAL] - Time in milisecs to display each message for. Throws "Invalid argument" Error if not numeric. Default val is 1000
* emptyDisplayString [OPTIONAL] - This is message displayed when no messages are in the queue. Default val is "..."

If no options passed then it throws "Missing arguments" Error.


4) Create instance of object passing options


```javascript
    var messageQueue = new UiMessageQueue(options);
```


5) Add messages to the queue


```javascript
    messageQueue.push("Here is a message");
    messageQueue.push("Here is another one");
    messageQueue.push("Finally, one more message");
```

These will be displayed in a FIFO method with each message for that set period of time.

See the demo for a cool, super useful example.

## Contributions

Please use the GitHub pull-request mechanism to submit contributions.

Edit the coffeescript source and then compile to js - Do not edit UiMessageQueue-release.js

### Testing

Checkout the `Cakefile` for build and test commands.

```bash
# do a build for the test suite
cake build.test

# run tests
cake test
```

### Code style

Run [CoffeeLint](http://www.coffeelint.org/) over the source:

```bash
cake test.quality
# or the indentical call
coffeelint src/
```

### Build

To produce a release build, run the build script; this compiles to JS and merges into one file to produce `src/UiMessageQueue-release.js`.

```bash
cake build.release
```


## License

This project is available for use under the MIT software license.
See LICENSE
