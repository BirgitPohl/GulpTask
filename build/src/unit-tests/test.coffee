## Start Testing with command: gulp jasmine
vm = new ViewModel(0, true)

describe 'What is a double, dummy, fake, stub, mock and a spy?', ->
  #This is a double
  afterEach ->
    vm.rotator 0

  it 'tests a Dummy like this', ->
    expect(true).toBe true

  it 'tests a Fake like this', ->
    vm.nextButtonTextArray = [
      "I'm first"
      "I'm second"
      "I'm thirsty"
    ]
    
    vm.rotator 1
    vm.rotator 0
    expect(vm.nextButtonText()).toBe "I'm first"
    vm.rotator 1
    expect(vm.nextButtonText()).toBe "I'm second"

  it 'tests a Stub like this', ->
    spyOn(vm, 'spy_on_left').and.callFake ->
      @toTheRight()
    vm.spy_on_left()
    expect(vm.spy_on_left.calls.count()).toEqual(1)
    expect(vm.rotator()).toBe 1

  it 'tests a Mock like this', ->
    spyOn(vm, 'spy_on_left').and.callThrough().and.returnValue(true)
    expect(vm.spy_on_left()).toEqual true

  it 'tests a Spy like this', ->
    spyOn(vm, 'spy_on_left').and.callThrough()
    vm.spy_on_left()
    expect(vm.spy_on_left.calls.count()).toEqual(1)
    expect(vm.rotator()).toBe 2

xdescribe "After opening the login page I want to check the state and", ->
  # 'beforeEach' performs setup before each 'it' test
  #  beforeEach ->
  #    pageState = ko.observable(0)
  #    buttonText = ko.obersvable("Next")

  myUsername      = 'Peddington Bear'
  myEmailAddress  = 'peddy@bear.com.uk'
  it "I see I can register", ->
    expect(vm.rotator()).toBe(0)
    expect(vm.nextButtonText()).toBe('Next')
    
    ##Todo I enter my user name
    expect(vm.userName()).toBe()
    vm.userName(myUsername)
    expect(vm.userName()).toBe(myUsername)
    

  it "I clicked on next and I see I can enter my password", ->
    vm.toTheRight()
    expect(vm.rotator()).toBe(1)
    expect(vm.nextButtonText()).toBe('Continue')

    vm.emailAddress(myEmailAddress)
    expect(vm.emailAddress()).toBe(myEmailAddress)
    

  it "I clicked on continue I see I can confirm my registration", ->
    vm.toTheRight()
    expect(vm.rotator()).toBe(2)
    expect(vm.nextButtonText()).toBe('Yes!')

    expect(vm.userName()).toBe(myUsername)

  xit "I clicked on yes I see an email was send to my email account", ->
    ##Todo change that as soon as there is something to go further
    vm.toTheRight()
    expect(vm.rotator()).toBe(0) 