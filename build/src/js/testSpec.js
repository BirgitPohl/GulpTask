var vm;

vm = new ViewModel(0, nextButtonTextArray[0], true);

describe("After opening the login page I want to check the state and", function() {
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
