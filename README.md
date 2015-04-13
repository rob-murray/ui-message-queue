# ui-message-queue AKA User Message Queue Javascript implementation

[![Build Status](https://travis-ci.org/rob-murray/ui-message-queue.png?branch=master)](https://travis-ci.org/rob-murray/ui-message-queue)
[![Haz Commitz Status](http://haz-commitz.herokuapp.com/repos/rob-murray/ui-message-queue.svg)](http://haz-commitz.herokuapp.com/repos/rob-murray/ui-message-queue)

## Description

ui-message-queue is a Javascript implementation of a message queue allowing you to push messages (simple Strings) to the queue and display in a DOM element via a First In First Out (FIFO) method. This means that you can load up messages and they each have a defined display time after which will be overwritten with the next message or cleared.

The **goal** is to be as simple as possible to include and use, it's meant for displaying messages to website users rather than queuing backend type tasks.

**Check out** a demo [here](http://rob-murray.github.com/ui-message-queue).

Features:

* No jQuery! Whilst fantastic as it is, can this is intended as a standalone library and not rely on other frameworks - so we're a jQuery free zone.
* Add messages to queue; displayed in FIFO order.
* Select the DOM element to update, falling back to Javascript Alert if not found.


## Getting started

How to use:

1) Copy Javascript source from `lib/ui-message-queue.min.js` or `lib/ui-message-queue.js` to your project.

2) Import source file.

```javascript
<script type="text/javascript" src="ui-message-queue.min.js"></script>
```

3) Options

Takes options in the form of an object literal:

```javascript
options = {
  outputElementId: "output-id",
  delay: TIME_IN_MILISECONDS,
  emptyDisplayString: "A String"
};
```

These are as follows:
* `outputElementId` - **[OPTIONAL]** - The ID of the element in the DOM to add messages to. If this is not found then ui-message-queue falls back to using the alert popup box
* `delay` - **[OPTIONAL]** - Time in milisecs to display each message for. Throws "Invalid argument" Error if not numeric. Default value is 1000 or 1 second.
* `emptyDisplayString` - **[OPTIONAL]** - This is message displayed when no messages are in the queue. Default val is "..."


4) Create instance of object passing options.

```javascript
  var messageQueue = new UiMessageQueue(options);
```

5) Add messages to the queue.

```javascript
  messageQueue.push("Here is a message");
  messageQueue.push("Here is another one");
  messageQueue.push("Finally, one more message");
```

These will be displayed in a first in-first out manner with each message displayed for the set period of time.

See the demo for a cool, super useful example.

## Contributions

Please use the GitHub pull-request mechanism to submit contributions.

Edit the coffeescript source and then compile to js - Do not edit ui-message-queue.js

## Contents

This repository contains the following sections:

1. `src` - this contains the source Coffeescript.
2. `lib/ui-message-queue{.min}.js` - the source is then compiled into Javascript and minified (copy this to use!).
3. `test/*_spec.coffee` - the tests implemented in Mocha and Chai.
4. `example/index.html` - some real life html with proper Javascript to test this project.

### Testing

Run all tests.

```bash
$ grunt test
```

### Code style

Run [CoffeeLint](http://www.coffeelint.org/) over the source:

```bash
$ grunt coffeelint
```

### Build

To produce a release build, run the build script; this compiles to JS and merges into one file to produce `src/ui-message-queue.js` and `lib/ui-message-queue.min.js`.

```bash
$ grunt build
```


## License

This project is available for use under the MIT software license.
See LICENSE
