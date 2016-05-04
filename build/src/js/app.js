var ViewModel;

ViewModel = function() {
  var cssBGArray, self, someArray;
  self = this;
  someArray = [
    {
      name: "Box 1"
    }, {
      name: "Box 2"
    }, {
      name: "Box 3"
    }
  ];
  cssBGArray = ['#00cc99', 'yellow', 'yellowgreen'];
  self.rotator = ko.observable(0);
  self.result = ko.observable(someArray[self.rotator()]);
  self.backColor = ko.observable(cssBGArray[self.rotator()]);
  self.backColor = ko.computed(function() {
    return cssBGArray[self.rotator()];
  });
  self.toTheLeft = function() {
    if (self.rotator() > 0) {
      self.rotator(self.rotator() - 1);
    } else {
      self.rotator(2);
    }
    return self.result(someArray[self.rotator()]);
  };
  self.toTheRight = function() {
    if (self.rotator() < 2) {
      self.rotator(self.rotator() + 1);
    } else {
      self.rotator(0);
    }
    return self.result(someArray[self.rotator()]);
  };
};

$(function() {
  ko.applyBindings(new ViewModel);
});
