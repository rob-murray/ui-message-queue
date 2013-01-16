
/*
ui-message-queue - a User Message Queue Javascript implementation
(c) 2013 Robert Murray
@see https://github.com/rob-murray/ui-message-queue
UiMessageQueue may be freely distributed under the MIT license
*/

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  window.UiMessageQueue = (function() {
    "use strict";
    UiMessageQueue.prototype.messageBoxDivEl = null;

    UiMessageQueue.prototype.messagesArr = [];

    UiMessageQueue.prototype.messagesCount = 0;

    UiMessageQueue.prototype.useMessageBox = true;

    UiMessageQueue.prototype.timeOut = 1000;

    UiMessageQueue.prototype.emptyDisplayString = "...";

    function UiMessageQueue(args) {
      this.updateMsgBox = __bind(this.updateMsgBox, this);
      this.dispMsg = __bind(this.dispMsg, this);
      this.push = __bind(this.push, this);
      this.clear = __bind(this.clear, this);      this.clear();
      if (args) {
        this.setAttributes(args);
        this.dispMsg(this.emptyDisplayString);
      } else {
        throw "Missing arguments. UiMessageQueue requires arguments to run.";
      }
    }

    UiMessageQueue.prototype.setAttributes = function(attrs) {
      var messageBoxId;
      if (attrs.message_box_div_id) messageBoxId = attrs.message_box_div_id;
      if (attrs.timeout_val) {
        if (isFinite(attrs.timeout_val)) {
          this.timeOut = attrs.timeout_val;
        } else {
          throw "Invalid argument: timeout_val is not numeric";
        }
      }
      if (attrs.empty_display_str) {
        this.emptyDisplayString = attrs.empty_display_str;
      }
      try {
        if (document.getElementById(messageBoxId)) {
          this.useMessageBox = true;
          this.messageBoxDivEl = document.getElementById(messageBoxId);
        } else {
          this.useMessageBox = false;
        }
      } catch (e) {
        this.useMessageBox = false;
      }
    };

    UiMessageQueue.prototype.clear = function() {
      this.messagesCount = 0;
      return this.messagesArr = [];
    };

    UiMessageQueue.prototype.push = function(message) {
      if (this.useMessageBox === true) {
        if (this.messagesArr.length > 0) {
          return this.messagesArr.push(message);
        } else {
          this.messagesArr.push(message);
          return this.updateMsgBox();
        }
      } else {
        return alert(message);
      }
    };

    UiMessageQueue.prototype.dispMsg = function(val) {
      if (this.useMessageBox === true) return this.messageBoxDivEl.innerHTML = val;
    };

    UiMessageQueue.prototype.updateMsgBox = function() {
      var self;
      self = this;
      if (self.messagesArr[self.messagesCount] === void 0) {
        self.dispMsg(self.emptyDisplayString);
        return self.clear();
      } else {
        self.dispMsg(self.messagesArr[self.messagesCount]);
        self.messagesCount++;
        return setTimeout((function(self) {
          return self.updateMsgBox();
        }), self.timeOut, this);
      }
    };

    return UiMessageQueue;

  })();

}).call(this);
