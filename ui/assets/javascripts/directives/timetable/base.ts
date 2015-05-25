/// <reference path="../../../typings/vendor/angularjs/angular-route.d.ts" />
/// <reference path="../../../typings/vendor/angularjs/angular-resource.d.ts" />

import angular = require("angular");
import {appName, prefix} from "../../constants";
import {TimetableResource, TimetableResourceClass} from "../../resources/timetable";

class TimetableController {

  cells: ng.resource.IResourceArray<TimetableResource>;
  days: Array<string>;

  constructor(
      private Timetable: TimetableResourceClass,
      private $scope: ng.IScope,
      private $routeParams: ng.route.IRouteService
      ) {

    Timetable
      .query($routeParams)
      .$promise
      .then(this.timetableCallback);
  }

  timetableCallback = (res: any) => {
    this.cells = res;
    this.days = res.days;
    console.log(this.cells);
  }
}

class TimetableDirective implements ng.IDirective {
  restrict = "E";
  controller = ['Timetable', '$scope', '$routeParams', TimetableController];
  controllerAs = 'timetable';
  scope = {};
  bindToController = true;
  templateUrl = "timetable/base.html";
}

let app = angular.module(appName);
app.directive(`${prefix}Timetable`, [
  () => { return new TimetableDirective(); }
]);
