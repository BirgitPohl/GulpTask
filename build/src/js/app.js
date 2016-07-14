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
  function ViewModel(rotator) {
    this.spy_on_left = bind(this.spy_on_left, this);
    this.processRequest = bind(this.processRequest, this);
    this.nextButtonTextArray = ['Next', 'Continue', 'Yes!'];
    this.rotator = ko.observable(rotator);
    this.nextButtonText = ko.computed((function(_this) {
      return function() {
        return _this.nextButtonTextArray[_this.rotator()];
      };
    })(this));
    this.show_next_button = ko.computed((function(_this) {
      return function() {
        return _this.rotator() < 2;
      };
    })(this));
    this.userName = ko.observable();
    this.emailAddress = ko.observable();
    this.password = ko.observable();
    this.xmlHttp = new XMLHttpRequest();
    this.showInformation = ko.observable("Some information");
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
    if ((this.userName() != null) && (this.emailAddress() != null)) {
      if (this.rotator() < 2) {
        this.rotator(this.rotator() + 1);
        return true;
      } else {
        this.rotator(0);
        return true;
      }
    } else {
      return this.showInformation("Please, set User name and email address.");
    }
  };

  ViewModel.prototype.submitData = function(formElements) {
    return this.httpRequest();
  };

  ViewModel.prototype.httpRequest = function() {
    var url;
    url = 'http://localhost:3000/build/';
    this.xmlHttp.open("POST", url, true);
    this.xmlHttp.setRequestHeader("Content-type", "application/json");
    this.xmlHttp.onreadystatechange = this.processRequest;
    return this.xmlHttp.send(ko.toJSON(this));
  };

  ViewModel.prototype.processRequest = function(event) {
    var response;
    if (this.xmlHttp.readyState === 4 && this.xmlHttp.status === 200) {
      response = JSON.parse(this.xmlHttp.responseText());
      this.showJSON(response);
      console.log("We are here");
    }
    if (this.xmlHttp.status === 404) {
      return this.showJSON("404 bad request. Page not found. We are sorry.");
    } else {
      return this.showJSON("Something else happened. We are sorry.");
    }
  };

  ViewModel.prototype.showJSON = function(data) {
    return this.showInformation(data);
  };

  ViewModel.prototype.spy_on_left = function() {
    return this.toTheLeft();
  };

  return ViewModel;

})();

$(function() {
  window.viewModel = new ViewModel(0);
  ko.applyBindings(viewModel, document.getElementById('trigger'));
});
