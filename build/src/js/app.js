var ViewModel,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

ko.bindingHandlers.debug = {
  init: function(element, valueAccessor) {
    console.log('KnockoutBinding:');
    console.log(element);
    return console.log(ko.toJS(valueAccessor()));
  }
};

ViewModel = (function() {
  function ViewModel(rotator, inputHasFocus) {
    this.spy_on_left = bind(this.spy_on_left, this);
    this.nextButtonTextArray = ['Next', 'Continue', 'Yes!'];
    this.rotator = ko.observable(rotator);
    this.nextButtonText = ko.computed((function(_this) {
      return function() {
        return _this.nextButtonTextArray[_this.rotator()];
      };
    })(this));
    this.userName = ko.observable();
    this.emailAddress = ko.observable();
    this.inputHasFocus = ko.observable(inputHasFocus);
  }

  ViewModel.prototype.toTheLeft = function() {
    if (this.rotator() > 0) {
      this.rotator(this.rotator() - 1);
      return true;
    } else {
      this.rotator(2);
      return true;
    }
  };

  ViewModel.prototype.toTheRight = function() {
    if (this.rotator() < 2) {
      this.rotator(this.rotator() + 1);
      return true;
    } else {
      this.rotator(0);
      return true;
    }
  };

  ViewModel.prototype.spy_on_left = function() {
    return this.toTheLeft();
  };

  return ViewModel;

})();

$(function() {
  var viewModel;
  viewModel = new ViewModel(0, true);
  ko.applyBindings(viewModel, document.getElementById('trigger'));
});
