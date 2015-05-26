/// <reference path="../../typings/vendor/angularjs/angular-resource.d.ts" />

import angular = require("angular");
import {appName, apiBaseUrl} from "../constants";
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

export interface TimetableResourceArray extends ng.resource.IResourceArray<TimetableResource> {
  beginning_of_week: string;
  end_of_week: string;
}

export function timetableFactory($resource: ng.resource.IResourceService) : TimetableResourceClass {
  const url = `${apiBaseUrl}/:resourceClass/:resourceId/timetable.json`;
  const params = { resourceClass: "@resourceClass", resourceId: "@resourceId" };
  let queryAction: ng.resource.IActionDescriptor = {
    method: "GET",
    isArray: true,
    transformResponse: (data: string, headersGetter: ng.IHttpHeadersGetter) => {
      let json = angular.fromJson(data);
      json.cells.beginning_of_week = json.beginning_of_week;
      json.cells.end_of_week = json.end_of_week;
      return json.cells;
    },
    interceptor: {
      response: (response: any) => {
        response.resource.beginning_of_week = response.data.beginning_of_week;
        response.resource.end_of_week = response.data.end_of_week;
        return response.resource;
      }
    }
  };
  return <TimetableResourceClass> $resource(url, params, { query: queryAction });
};

let app = angular.module(appName);
app.factory("Timetable", ["$resource", timetableFactory]);
