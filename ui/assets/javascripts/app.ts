/// <reference path="../typings/bundle.d.ts" />

import angular = require("angular");

import HelloDirective = require("./directives/hello");

module actopus {
  "use strict";
  angular.module("actopus", [])
    .directive("actHello", () => new HelloDirective());
}
