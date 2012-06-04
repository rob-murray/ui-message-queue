###
ui-message-queue - a User Message Queue Javascript implementation
(c) 2012 Robert Murray
UiMessageQueue may be freely distributed under the MIT license
###



# Create class in window namespace
# TODO: best practice here??
class window.UiMessageQueue

  #vars
  messageBoxDivEl : null
  messagesArr : new Array()
  messagesCount : 0
  useMessageBox : true
  
  #default vars
  timeOut : 1000 #timeout value to display message
  emptyDisplayString : "..." #default string to display when no messages in queue

  # constructor taking arguments
  constructor: (args) ->
  
    @clear()
    
    if args
      @setAttributes args
      #show initial message
      @dispMsg @emptyDisplayString
    else
      throw "Missing arguments. UiMessageQueue requires arguments to run."
    
  # method to set attributes from args passed  
  setAttributes: (attrs)->
  
      # Optional div id
      if attrs.message_box_div_id
        messageBoxId = attrs.message_box_div_id        
      
      # Assign optional values
      if attrs.timeout_val
        #test if timeout_val is numeric
        if isFinite attrs.timeout_val
          @timeOut = attrs.timeout_val
        else
          throw "Invalid argument: timeout_val is not numeric"
          
      if attrs.empty_display_str
        @emptyDisplayString = attrs.empty_display_str
        
      # Try and find the El by ID
      try
        if document.getElementById(messageBoxId)
        
          #Found ok so set to var instead of searching each time
          @useMessageBox = true
          @messageBoxDivEl = document.getElementById(messageBoxId)
        else
          # Unable to find El so fall back to alert message
          @useMessageBox = false
          
      catch e
        # Caught error searching for El so fall back to alert message
        @useMessageBox = true
      
      return
  
  # cleardown obj, reset count and queue  
  clear: =>
    @messagesCount = 0
    @messagesArr = []
  
  # Add a message to the queue  
  push: ( message ) =>
  
    # If we are using an el then add to queue
    if @useMessageBox == true

      # if the queue has messages then just add to the end
      if @messagesArr.length > 0
        @messagesArr.push message
      else
        #else add and call display timer
        @messagesArr.push message
        @updateMsgBox()
        
     else
       # otherwise just alert
       alert message
       
  
  # Method to display message
  dispMsg: (val) =>
    if @useMessageBox == true
      @messageBoxDivEl.innerHTML = val
      
  # Timeout method to work through queue
  updateMsgBox: =>
    self = @
    
    if self.messagesArr[self.messagesCount] == undefined
    
      # If at the end of the queue then display the empty string and cleardown
      self.dispMsg self.emptyDisplayString
      self.clear()
      
    else
    
      # Otherwise display the message, inc the counter and call timeout
      self.dispMsg self.messagesArr[self.messagesCount]
      self.messagesCount++
      
      # pass obj ref to timeout func and call with timeOut value
      setTimeout ((self) ->
        self.updateMsgBox()
      ), self.timeOut, this



# End
