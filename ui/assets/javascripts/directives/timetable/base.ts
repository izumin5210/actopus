/// <reference path="../../../typings/vendor/angularjs/angular-route.d.ts" />
/// <reference path="../../../typings/vendor/angularjs/angular-resource.d.ts" />
/// <reference path="../../../typings/vendor/moment/moment.d.ts" />
/// <reference path="../../../typings/vendor/lodash/lodash.d.ts" />

import angular = require("angular");
import {appName, prefix, FORMAT_DATE} from "../../constants";
import {
  TimetableResource, TimetableResourceClass,
  TimetableResourceArray, TimetableRow
} from "../../resources/timetable";

import moment = require("moment");
import _ = require("lodash");

class TimetableController {

  rows: Array<TimetableRow>;
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
    this.setRows();
  };

  getLastWeek(): Array<string> {
    return _.map(this.dates, (date) => moment(date).subtract(7, "days").format(FORMAT_DATE));
  }

  getNextWeek(): Array<string> {
    return _.map(this.dates, (date) => moment(date).add(7, "days").format(FORMAT_DATE));
  }

  private setDates(beginning_of_week: string, end_of_week: string) {
    this.dates = [beginning_of_week];
    while (true) {
      let nextDate = moment(this.dates[this.dates.length - 1]).add(1, "days");
      this.dates.push(nextDate.format(FORMAT_DATE));
      if (nextDate.isSame(end_of_week)) { break; }
    }
  };

  private setRows() {
    this.rows = _.map(this.dates, (date: string) => {
      let filteredCells = _.filter(this.cells, (cell: TimetableResource) => {
        return cell.scheduled_on === date;
      });
      return { date: date, cells: filteredCells };
    });
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
