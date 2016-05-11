var ViewModel, contentTextArray, cssBGArray;

ko.bindingHandlers.debug = {
  init: function(element, valueAccessor) {
    console.log('KnockoutBinding:');
    console.log(element);
    return console.log(ko.toJS(valueAccessor()));
  }
};

contentTextArray = ['Box 1', 'Box 2', 'Box 3'];

cssBGArray = ['#00cc99', 'MediumOrchid', 'yellowgreen'];

ViewModel = (function() {
  function ViewModel(rotator, contentText, backgroundColor, displayMessage, redChecked, greenChecked, blueChecked) {
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
    this.displayMessage = ko.observable(displayMessage);
    this.redChecked = ko.observable(redChecked);
    this.greenChecked = ko.observable(greenChecked);
    this.blueChecked = ko.observable(blueChecked);
    this.red = ko.observable(0);
    this.green = ko.observable(255);
    this.blue = ko.observable(255);
    this.colorChecker = ko.computed((function(_this) {
      return function() {
        if (_this.redChecked() === true) {
          _this.red(255);
        } else {
          _this.red(0);
        }
        if (_this.greenChecked() === true) {
          _this.green(255);
        } else {
          _this.green(0);
        }
        if (_this.blueChecked() === true) {
          return _this.blue(255);
        } else {
          return _this.blue(0);
        }
      };
    })(this));
    this.calculatedBGColor = ko.computed((function(_this) {
      return function() {
        return "rgb(" + (_this.red()) + "," + (_this.green()) + "," + (_this.blue()) + ")";
      };
    })(this));
  }

  ViewModel.prototype.toTheLeft = function() {
    if (this.rotator() > 0) {
      return this.rotator(this.rotator() - 1);
    } else {
      return this.rotator(2);
    }
  };

  ViewModel.prototype.toTheRight = function() {
    if (this.rotator() < 2) {
      this.rotator(this.rotator() + 1);
    } else {
      this.rotator(0);
    }
  };

  return ViewModel;

})();

$(function() {
  var viewModel;
  viewModel = new ViewModel(0, contentTextArray[0], cssBGArray[0], 'blubb', true, false, false);
  ko.applyBindings(viewModel, document.getElementById('trigger'));
});
