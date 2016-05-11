ko.bindingHandlers.debug =
  init: (element, valueAccessor) ->
    console.log 'KnockoutBinding:'
    console.log element
    console.log ko.toJS(valueAccessor())

contentTextArray = [
  'Box 1'
  'Box 2'
  'Box 3'
]

cssBGArray = [
  '#00cc99'
  'MediumOrchid'
  'yellowgreen'
]
 ## .rotator.extend({ displayMessage: value}) ## trigger's even if the value is the same
##Todo create ViewModel file
class ViewModel
  constructor: (rotator, contentText, backgroundColor, displayMessage, redChecked, greenChecked, blueChecked) ->

    @rotator            = ko.observable(rotator)
    @contentText        = ko.computed =>
      contentTextArray[@rotator()]
    @backgroundColor    = ko.computed =>
      cssBGArray[@rotator()]
    @displayMessage     = ko.observable(displayMessage)
    @redChecked         = ko.observable(redChecked)     ##boolean
    @greenChecked       = ko.observable(greenChecked)   ##boolean
    @blueChecked        = ko.observable(blueChecked)    ##boolean
    @red                = ko.observable(0)
    @green              = ko.observable(255)
    @blue               = ko.observable(255)
    @colorChecker       = ko.computed =>
      if @redChecked()    is true then @red   255 else @red   0
      if @greenChecked()  is true then @green 255 else @green 0
      if @blueChecked()   is true then @blue  255 else @blue  0
    @calculatedBGColor  = ko.computed =>
      return "rgb(#{@red()},#{@green()},#{@blue()})"

  #Instance attribute. Create this to specify certain attributes that all instances should have and that don't change.
    #It goes inside the constructor
    #@toTheLeft = ->
    #console.log 'attr abc'

  #prototype attibute. Create this to define certain attributes that is available in all classes, but the value changes.
  #For example: console.log @backgroundColor
  ## Todo length is n? Right now it does not depends on the length of some array, but it can
  toTheLeft : ->
    if @rotator() > 0
      @rotator @rotator() - 1
    else
      @rotator 2

  toTheRight : ->
    if @rotator() < 2
      @rotator @rotator() + 1
    else
      @rotator 0
    return

#  setIsSelected : ->
#    @displayMessage 'Congrats! You have successfully selected an input field!'

$ ->
  viewModel = new ViewModel(0, contentTextArray[0], cssBGArray[0], 'blubb', true, false, false)
  ko.applyBindings viewModel, document.getElementById 'trigger'  ##needs one DOMelement to listen to.
  return

