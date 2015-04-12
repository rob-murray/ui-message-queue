
/**
 * An object to display a given message as an alert message.
 */

(function() {
  var AlertDisplay, root;

  AlertDisplay = (function() {
    "use strict";
    function AlertDisplay() {}


    /**
     * public: display the given message
     * @param {string} message The message to be displayed
     */

    AlertDisplay.prototype.displayMessage = function(message) {
      return alert(message);
    };

    return AlertDisplay;

  })();

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.AlertDisplay = AlertDisplay;

}).call(this);


/**
 * An object to display a given message in an html dom
 */

(function() {
  var DomDisplay, root,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  DomDisplay = (function() {
    "use strict";

    /**
     * Create new instance of DomDisplay
     * @param {string} domElementId The element id of the dom to manipulate. Must
     *   exist or Error thrown.
     */
    function DomDisplay(domElementId) {
      this.displayMessage = bind(this.displayMessage, this);
      if (!(this._domElement = root.document.getElementById(domElementId))) {
        throw new Error("Error: cannot find Element Id: '" + domElementId + "'.");
      }
    }


    /**
     * public: display the given message
     * @param {string} message The message to be rendered
     */

    DomDisplay.prototype.displayMessage = function(message) {
      return this._domElement.innerHTML = message;
    };

    return DomDisplay;

  })();

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.DomDisplay = DomDisplay;

}).call(this);

(function() {
  var FifoQueue, root;

  FifoQueue = (function() {
    "use strict";

    /**
     * Create new instance of FifoQueue
     * @param {object} options Object with configuration properties. See README for details.
     */
    function FifoQueue() {
      this._stack = [];
    }


    /**
     * public: Add an to the queue
     * @param {object} obj Object to be added to the queue. Must not be `null`.
     */

    FifoQueue.prototype.push = function(obj) {
      if (obj !== null) {
        return this._stack.push(obj);
      }
    };


    /**
     * public: Return the number of items in the queue
     */

    FifoQueue.prototype.getCount = function() {
      return this._stack.length;
    };


    /**
     * public: Return boolean, true if queue currently has items, false if empty
     */

    FifoQueue.prototype.hasItems = function() {
      return this.getCount() > 0;
    };


    /**
     * public: Fetch, remove and return the first item in the queue, unless queue empty
     *   then throws Error - should check hasItems() first
     */

    FifoQueue.prototype.getItem = function() {
      if (!this.hasItems()) {
        throw new Error("Queue empty, ensure not empty by using FifoQueue.hasItems().");
      }
      return this._stack.shift();
    };

    return FifoQueue;

  })();

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.FifoQueue = FifoQueue;

}).call(this);

(function() {
  var AlertDisplay, DomDisplay, FifoQueue, UiMessageQueue, root,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  FifoQueue = root.FifoQueue || require('../src/fifo_queue').FifoQueue;

  DomDisplay = root.DomDisplay || require('../src/dom_display').DomDisplay;

  AlertDisplay = root.AlertDisplay || require('../src/alert_display').AlertDisplay;


  /**
   * User Message Queue Javascript implementation
   */

  UiMessageQueue = (function() {
    "use strict";
    UiMessageQueue.DEFAULT_DELAY = 1000;

    UiMessageQueue.DEFAULT_EMPTY_DISPLAY_MESSAGE = "";


    /**
     * Create new instance with given options
     * @param {object} options Object with configuration properties. See README for details.
     */

    function UiMessageQueue(options) {
      this._processMessageQueue = bind(this._processMessageQueue, this);
      this._isProcessing = bind(this._isProcessing, this);
      this._startProcessing = bind(this._startProcessing, this);
      this._haltProcessing = bind(this._haltProcessing, this);
      this._displayMessage = bind(this._displayMessage, this);
      this.push = bind(this.push, this);
      if (!options) {
        throw new Error("Missing arguments. UiMessageQueue requires arguments to run.");
      }
      this._displayer = new AlertDisplay();
      this._delay = UiMessageQueue.DEFAULT_DELAY;
      this._emptyDisplayString = UiMessageQueue.DEFAULT_EMPTY_DISPLAY_MESSAGE;
      this._messageStack = new FifoQueue();
      this._setOptions(options);
      this._triggered = false;
    }


    /** internal: method to set attributes from args passed */

    UiMessageQueue.prototype._setOptions = function(options) {
      var e;
      if (options.emptyDisplayString) {
        if (!(typeof options.emptyDisplayString === "string")) {
          throw new Error("Invalid argument: emptyDisplayString is not a String");
        }
        this._emptyDisplayString = options.emptyDisplayString;
      }
      if (options.delay) {
        if (!isFinite(options.delay)) {
          throw new Error("Invalid argument: delay is not numeric");
        }
        this._delay = options.delay;
      }
      if (options.outputElementId) {
        try {
          return this._displayer = new DomDisplay(options.outputElementId);
        } catch (_error) {
          e = _error;
          return this._displayer = new AlertDisplay();
        }
      }
    };


    /**
     * public: add a message to the queue
     * @param {string} message The message to be displayed as a string.
     */

    UiMessageQueue.prototype.push = function(message) {
      if (typeof message === "string") {
        this._messageStack.push(message);
      }
      if (!this._isProcessing()) {
        return this._processMessageQueue();
      }
    };


    /** internal: delegate display of message to display strategy */

    UiMessageQueue.prototype._displayMessage = function(message) {
      return this._displayer.displayMessage(message);
    };


    /** internal: stop processing messages */

    UiMessageQueue.prototype._haltProcessing = function() {
      return this._triggered = false;
    };


    /** internal: start processing messages on loop */

    UiMessageQueue.prototype._startProcessing = function() {
      return this._triggered = true;
    };


    /** internal: is currently processing messages */

    UiMessageQueue.prototype._isProcessing = function() {
      return this._triggered;
    };


    /** internal: grab the next message off the stack and display it */

    UiMessageQueue.prototype._processMessageQueue = function() {
      var self;
      if (this._messageStack.hasItems()) {
        self = this;
        if (this._messageStack.getCount() === 1 && !this._isProcessing()) {
          this._displayMessage(this._messageStack.getItem());
        }
        setTimeout((function(self) {
          if (self._messageStack.hasItems()) {
            self._displayMessage(self._messageStack.getItem());
          } else {
            self._displayMessage(self._emptyDisplayString);
          }
          return self._processMessageQueue();
        }), self._delay, this);
        return this._startProcessing();
      } else {
        return this._haltProcessing();
      }
    };

    return UiMessageQueue;

  })();

  root.UiMessageQueue = UiMessageQueue;

}).call(this);
