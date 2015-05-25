/// <reference path="../../typings/vendor/angularjs/angular-resource.d.ts" />

import angular = require("angular");
import {appName} from "../constants";
import {PeriodTime} from "./period_time";
import {Lecture} from "./lecture";

export interface TimetableResource extends ng.resource.IResource<TimetableResource> {
  category: string;
  scheduled_on: string;
  period: PeriodTime;
  lecture: Lecture;
}

export interface TimetableResourceClass extends ng.resource.IResourceClass<TimetableResource> {
}

export function timetableFactory($resource: ng.resource.IResourceService) : TimetableResourceClass {
  const url = "/api/v1/:resourceClass/:resourceId/timetable.json";
  const params = { resourceClass: "@resourceClass", classId: "@resourceId" };
  let queryAction: ng.resource.IActionDescriptor = {
    method: "GET",
    isArray: true,
    transformResponse: (data: string, headersGetter: ng.IHttpHeadersGetter) => {
      let result = angular.fromJson(data);
      result.cells.days = result.days;
      return result.cells;
    },
    interceptor: {
      response: (response: any) => {
        response.resource.days = response.data.days;
        return response.resource;
      }
    }
  };
  return <TimetableResourceClass> $resource(url, params, { query: queryAction });
};

let app = angular.module(appName);
app.factory("Timetable", ["$resource", timetableFactory]);
