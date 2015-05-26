/// <reference path="../../../typings/vendor/angularjs/angular-route.d.ts" />
/// <reference path="../../../typings/vendor/angularjs/angular-resource.d.ts" />
/// <reference path="../../../typings/vendor/moment/moment.d.ts" />

import angular = require("angular");
import {appName, prefix} from "../../constants";
import {TimetableResourceClass, TimetableResourceArray} from "../../resources/timetable";

import moment = require("moment");

class TimetableController {

  cells: TimetableResourceArray;
  dates: Array<string>;

  constructor(
      private Timetable: TimetableResourceClass,
      private $routeParams: ng.route.IRouteService
      ) {
    this.getTimetable();
  }

  getTimetable = (opts: Object = this.$routeParams) => {
    this.Timetable
      .query(opts)
      .$promise
      .then(this.timetableCallback);
  }

  timetableCallback = (res: any) => {
    this.cells = res;
    this.setDates(res.beginning_of_week, res.end_of_week);
  };

  setDates = (beginning_of_week: string, end_of_week: string) => {
    this.dates = [beginning_of_week];
    while (true) {
      let nextDate = moment(this.dates[this.dates.length - 1]).add(1, "days");
      this.dates.push(nextDate.format("YYYY-MM-DD"));
      if (nextDate.isSame(end_of_week)) { break; }
    }
  };
}

class TimetableDirective implements ng.IDirective {
  restrict = "E";
  controller = ['Timetable', '$routeParams', TimetableController];
  controllerAs = 'timetable';
  scope = {};
  bindToController = true;
  templateUrl = "timetable/base.html";
}

let app = angular.module(appName);
app.directive(`${prefix}Timetable`, [
  () => { return new TimetableDirective(); }
]);
