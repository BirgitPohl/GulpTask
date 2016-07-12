ko.bindingHandlers.debug =
  init: (element, valueAccessor) ->
    console.log 'KnockoutBinding:'
    console.log element
    console.log ko.toJS(valueAccessor())


 ## .rotator.extend({ displayMessage: value}) ## trigger's even if the value is the same
##Todo create ViewModel file
class ViewModel
  constructor: (rotator, inputHasFocus ) ->
    @nextButtonTextArray = [
      'Next'
      'Continue'
      'Yes!'
    ]

    @rotator             = ko.observable(rotator)
    @nextButtonText      = ko.computed =>
      @nextButtonTextArray[@rotator()]

    @userName            = ko.observable()
    @emailAddress        = ko.observable()
    @password            = ko.observable()

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
    @inputHasFocus      = ko.observable(inputHasFocus)
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
    if @rotator() < 2
      @rotator @rotator() + 1
      return true
    else
      @rotator 0
      return true
    return
#  setIsSelected : ->
#    @displayMessage 'Congrats! You have successfully selected an input field!'

  spy_on_left: =>
    @toTheLeft()

$ ->
  viewModel = new ViewModel(0, true)
  ko.applyBindings viewModel, document.getElementById 'trigger'  ##needs one DOMelement to listen to.
  return

