Copyright (C) 2012 Rob Murray

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  window.UiMessageQueue = (function() {

    UiMessageQueue.prototype.messageBoxDivEl = null;

    UiMessageQueue.prototype.messagesArr = new Array();

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
        this.useMessageBox = true;
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

