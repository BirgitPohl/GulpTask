var ViewModel, nextButtonTextArray;

ko.bindingHandlers.debug = {
  init: function(element, valueAccessor) {
    console.log('KnockoutBinding:');
    console.log(element);
    return console.log(ko.toJS(valueAccessor()));
  }
};

nextButtonTextArray = ['Next', 'Continue', 'Yes!'];

ViewModel = (function() {
  function ViewModel(rotator, nextButtonText, inputHasFocus) {
    this.rotator = ko.observable(rotator);
    this.nextButtonText = ko.computed((function(_this) {
      return function() {
        return nextButtonTextArray[_this.rotator()];
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

  return ViewModel;

})();

$(function() {
  var viewModel;
  viewModel = new ViewModel(0, nextButtonTextArray[0], true);
  ko.applyBindings(viewModel, document.getElementById('trigger'));
});
