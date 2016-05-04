ViewModel = ->

  self = this
  someArray = [
    {name: "Box 1"},
    {name: "Box 2"},
    {name: "Box 3"}
  ]

#  cssBGArray = [
#    {bgColor: "yellowBackground"},
#    {bgColor: "blueBackground"},
#    {bgColor: "greenBackground"}
#  ]

  cssBGArray = [
    '#00cc99'
    'yellow'
    'yellowgreen'
  ]
  self.rotator = ko.observable(0)
  self.result = ko.observable(someArray[self.rotator()])
  self.backColor = ko.observable(cssBGArray[self.rotator()])

#  self.backColor = ko.pureComputed ->
#    switch self.rotator()
#      when 0 then return "yellowBackground"
#      when 1 then return "blueBackground"
#      else        return "greenBackground"
#  ,self

  self.backColor = ko.computed ->
    return cssBGArray[self.rotator()]
    #todo this adds but doesn't remove a class as long as there

  self.toTheLeft = ->
    if self.rotator() > 0
      self.rotator self.rotator() - 1
#      self.result someArray[self.rotator()]
#      return
    else
      self.rotator 2
#      self.result someArray[self.rotator()]
#      return

    self.result someArray[self.rotator()]
    #self.backColor #cssBGArray[self.rotator()]


  self.toTheRight = ->
    if self.rotator() < 2
      self.rotator self.rotator() + 1
#      self.result someArray[self.rotator()]
#      return
    else
      self.rotator 0
#      self.result someArray[self.rotator()]
#      return

    self.result someArray[self.rotator()]
    #self.backColor #cssBGArray[self.rotator()]

  return

#  self.toTheLeft = ->
#    if self.rotator() > 1
#      self.rotator self.rotator() - 1
#      return
#    else
#      self.rotator 3
#      return
#
#  self.toTheRight = ->
#    if self.rotator() < 3
#      self.rotator self.rotator() + 1
#      return
#    else
#      self.rotator 1
#      return
#  return





  #creates h.apply is not a function error, this may be an internal JQuery error
#  $('#toTheRight').click ->
#    self.rotator self.rotator() + 1
#    return
#  $('#toTheLeft').click ->
#    self.rotator self.rotator() - 1
#    return
#  return

$ ->
  ko.applyBindings new ViewModel
#  ko.applyBindings new ClickCounterViewModel
  return

