class HelloDirective implements ng.IDirective {
  restrict: string = "E";
  template: string = "<h1>hello world!</h1>"
}

export = HelloDirective;
