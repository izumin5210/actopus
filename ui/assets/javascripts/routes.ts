/// <reference path="../typings/vendor/angularjs/angular-route.d.ts" />

import angular = require("angular");
import {appName} from "./constants";

let app = angular.module(appName);

app.config(($routeProvider: ng.route.IRouteProvider, $locationProvider: ng.ILocationProvider) => {
  $locationProvider.html5Mode(true);
  $routeProvider
    .when("/staffs/:resourceClass/:resourceId/timetable", {
      template: "<act-timetable></act-timetable>"
    });
});
