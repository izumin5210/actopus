/// <reference path="../../../typings/vendor/angularjs/angular-resource.d.ts" />

import angular = require("angular");
import {appName, prefix} from "../../constants";
import {TimetableResource} from "../../resources/timetable";

class TimetableRowController {
  cells: Array<TimetableResource>;
}

// class TimetableRowDirective implements ng.IDirective {
class TimetableRowDirective {
  restrict = "E";
  controller = ["$scope", TimetableRowController];
  controllerAs = "timetableRow";
  scope = {};
  bindToController = {
    cells: "&"
  };
  templateUrl = "timetable/row.html";
}

let app = angular.module(appName);
app.directive(`${prefix}TimetableRow`, [
  () => new TimetableRowDirective()
]);
