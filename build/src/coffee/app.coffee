ko.bindingHandlers.debug =
  init: (element, valueAccessor) ->
    console.log 'KnockoutBinding:'
    console.log element
    console.log ko.toJS(valueAccessor())


 ## .rotator.extend({ displayMessage: value}) ## trigger's even if the value is the same
##Todo create ViewModel file
class ViewModel
  constructor: (rotator) ->
    @nextButtonTextArray = [
      'Next'
      'Continue'
      'Yes!'
    ]

    @rotator             = ko.observable(rotator)
    @nextButtonText      = ko.computed =>
      @nextButtonTextArray[@rotator()]

    @show_next_button     = ko.computed =>
      return @rotator() < 2

    @userName            = ko.observable()
    @emailAddress        = ko.observable()
    @password            = ko.observable()

    @xmlHttp             = new XMLHttpRequest()

    @showInformation     = ko.observable("Some information")
    #@nextButtonTextArray.subscribe

    ## Todo save array before the event
    ## Todo get rid of syntax error
    ## Todo See what kind of magic happens
#    @lastCheckedItem    = ko.computed =>
#      currentArray([])
#      l for l in @checkCheckbox hangedArray([]).push(@checkCheckbox)
#      if currentArray.length > changedArray.length
#        i for i in currentArray when currentArray() is not changedArray()
#          return changedArray()
    #@displayMessage     = ko.observable(displayMessage)

  #Instance attribute. Create this to specify certain attributes that all instances should have and that don't change.
    #It goes inside the constructor
    #@toTheLeft = ->
    #console.log 'attr abc'

  #prototype attibute. Create this to define certain attributes that is available in all classes, but the value changes.
  #For example: console.log @backgroundColor
  ## Todo length is n? Right now it does not depends on the length of some array, but it can
  ## Todo enter verification, is name set, is password set?
  toTheLeft : ->
    if @rotator() > 0
      @rotator @rotator() - 1
      return true
    else
      @rotator 2
      return true

  toTheRight : ->
    if @userName()? and @emailAddress()?
      if @rotator() < 2
        @rotator @rotator() + 1
        return true
      else
        @rotator 0
        return true
      return
    else
      @showInformation "Please, set User name and email address."

  submitData : (formElements) ->
    @httpRequest()

  httpRequest: () ->
    url = 'http://localhost:3000/build/'
    @xmlHttp.open "POST", url, true # true for asynchronous
    @xmlHttp.setRequestHeader("Content-type", "application/json")
    @xmlHttp.onreadystatechange = @processRequest

    @xmlHttp.send(ko.toJSON(@))

  processRequest: (event) =>
    if @xmlHttp.readyState is 4 and @xmlHttp.status is 200
      response = JSON.parse(@xmlHttp.responseText())
      @showJSON(response)
      console.log("We are here")
    if @xmlHttp.status is 404
      @showJSON("404 bad request. Page not found. We are sorry.")
    else
      @showJSON("Something else happened. We are sorry.")

  showJSON: (data) ->
#    @showInformation ko.toJSON(@)
    @showInformation data
#  setIsSelected : ->
#    @displayMessage 'Congrats! You have successfully selected an input field!'

  spy_on_left: =>
    @toTheLeft()

$ ->
  window.viewModel = new ViewModel(0)
  ko.applyBindings viewModel, document.getElementById 'trigger'  ##needs one DOMelement to listen to.
  return

