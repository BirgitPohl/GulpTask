var vm;

vm = new ViewModel(0, nextButtonTextArray[0], true);

describe("I'm on the registration page", function() {
  var state;
  state = vm.rotator();
  return it("bla", function() {
    return expect(state).toBe(0);
  });
});

describe("I'm on the Enter-the-password page", function() {
  var a;
  a = false;
  return xit("let's me enter my password", function() {
    a = true;
    return expect(a).toBe(true);
  });
});

describe("I'm on the verification page", function() {
  var a;
  a = false;
  return xit("let's me verify my settings", function() {
    a = true;
    return expect(a).toBe(true);
  });
});
