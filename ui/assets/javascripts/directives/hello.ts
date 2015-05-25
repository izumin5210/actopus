import angular = require("angular");
import {appName, prefix} from "../constants";

class HelloDirective implements ng.IDirective {
  restrict: string = "E";
  templateUrl: string = "hello.html";
}

let app = angular.module(appName);
app.directive(`${prefix}Hello`, [
  () => { return new HelloDirective(); }
]);
