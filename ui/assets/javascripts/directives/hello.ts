class HelloDirective implements ng.IDirective {
  restrict: string = "E";
  templateUrl: string = "hello.html";
}

export = HelloDirective;
