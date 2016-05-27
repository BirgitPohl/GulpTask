vm = new ViewModel(0, nextButtonTextArray[0], true)

describe "I'm on the registration page", ->
  # 'beforeEach' performs setup before each 'it' test
#  beforeEach ->
#    pageState = ko.observable(0)
#    buttonText = ko.obersvable("Next")

  #create an observable and test a function
  #how to test the state of an observable?
  state = vm.rotator()
  it "bla", ->
    expect(state).toBe(0)
  

describe "I'm on the Enter-the-password page", ->
  a = false
  xit "let's me enter my password", ->
    a = true
    ##test
    expect(a).toBe(true)

describe "I'm on the verification page", ->
  a = false
  xit "let's me verify my settings", ->
    a = true
    ##test
    expect(a).toBe(true)