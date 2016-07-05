## Start Testing with command: gulp jasmine
vm = new ViewModel(0, nextButtonTextArray[0], true)

describe "After opening the login page I want to check the state and", ->
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