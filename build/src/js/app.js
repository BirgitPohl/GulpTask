var ViewModel, contentTextArray, cssBGArray;

ko.bindingHandlers.debug = {
  init: function(element, valueAccessor) {
    console.log('KnockoutBinding:');
    console.log(element);
    return console.log(ko.toJS(valueAccessor()));
  }
};

contentTextArray = ['Next', 'Continue', 'Have fun!'];

cssBGArray = ['#00cc99', 'MediumOrchid', 'yellowgreen'];

ViewModel = (function() {
  function ViewModel(rotator, contentText, backgroundColor, displayMessage, redChecked, greenChecked, blueChecked, inputHasFocus) {
    this.rotator = ko.observable(rotator);
    this.contentText = ko.computed((function(_this) {
      return function() {
        return contentTextArray[_this.rotator()];
      };
    })(this));
    this.backgroundColor = ko.computed((function(_this) {
      return function() {
        return cssBGArray[_this.rotator()];
      };
    })(this));
    this.checkCheckbox = ko.observableArray([]);
    this.inputHasFocus = ko.observable(inputHasFocus);
    this.displayMessage = ko.observable(displayMessage);
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
  viewModel = new ViewModel(0, contentTextArray[0], cssBGArray[0], 'blubb', true, false, false, false);
  ko.applyBindings(viewModel, document.getElementById('trigger'));
});
