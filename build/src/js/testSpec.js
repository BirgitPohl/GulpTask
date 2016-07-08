var vm;

vm = new ViewModel(0, true);

describe('What is a double, dummy, fake, stub, mock and a spy?', function() {
  afterEach(function() {
    return vm.rotator(0);
  });
  it('tests a Dummy like this', function() {
    return expect(true).toBe(true);
  });
  it('tests a Fake like this', function() {
    vm.nextButtonTextArray = ["I'm first", "I'm second", "I'm thirsty"];
    vm.rotator(1);
    vm.rotator(0);
    expect(vm.nextButtonText()).toBe("I'm first");
    vm.rotator(1);
    return expect(vm.nextButtonText()).toBe("I'm second");
  });
  it('tests a Stub like this', function() {
    spyOn(vm, 'spy_on_left').and.callFake(function() {
      return this.toTheRight();
    });
    vm.spy_on_left();
    expect(vm.spy_on_left.calls.count()).toEqual(1);
    return expect(vm.rotator()).toBe(1);
  });
  it('tests a Mock like this', function() {
    spyOn(vm, 'spy_on_left').and.callThrough().and.returnValue(true);
    return expect(vm.spy_on_left()).toEqual(true);
  });
  return it('tests a Spy like this', function() {
    spyOn(vm, 'spy_on_left').and.callThrough();
    vm.spy_on_left();
    expect(vm.spy_on_left.calls.count()).toEqual(1);
    return expect(vm.rotator()).toBe(2);
  });
});

xdescribe("After opening the login page I want to check the state and", function() {
  var myEmailAddress, myUsername;
  myUsername = 'Peddington Bear';
  myEmailAddress = 'peddy@bear.com.uk';
  it("I see I can register", function() {
    expect(vm.rotator()).toBe(0);
    expect(vm.nextButtonText()).toBe('Next');
    expect(vm.userName()).toBe();
    vm.userName(myUsername);
    return expect(vm.userName()).toBe(myUsername);
  });
  it("I clicked on next and I see I can enter my password", function() {
    vm.toTheRight();
    expect(vm.rotator()).toBe(1);
    expect(vm.nextButtonText()).toBe('Continue');
    vm.emailAddress(myEmailAddress);
    return expect(vm.emailAddress()).toBe(myEmailAddress);
  });
  it("I clicked on continue I see I can confirm my registration", function() {
    vm.toTheRight();
    expect(vm.rotator()).toBe(2);
    expect(vm.nextButtonText()).toBe('Yes!');
    return expect(vm.userName()).toBe(myUsername);
  });
  return xit("I clicked on yes I see an email was send to my email account", function() {
    vm.toTheRight();
    return expect(vm.rotator()).toBe(0);
  });
});
