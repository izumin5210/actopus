/// <reference path="../typings/bundle.d.ts" />

var angular: ng.IAngularStatic = require("angular");

import HelloDirective = require("./directives/hello");

module actopus {
  angular.module("actopus", [])
    .directive("actHello", () => new HelloDirective());
}
