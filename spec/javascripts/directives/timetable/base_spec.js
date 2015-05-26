import timetableResponse from "../../fixtures/timetable.json";
import _ from "lodash";

describe("TimetableDirective", () => {
  let $compile, $rootScope, $httpBackend, $routeParams;
  let element, controller;

  beforeEach(angular.mock.module("actopus"));

  beforeEach(inject((_$compile_, _$rootScope_, _$httpBackend_, _$routeParams_) => {
    $compile = _$compile_;
    $rootScope = _$rootScope_;
    $httpBackend = _$httpBackend_;
    $routeParams = _$routeParams_;

    $routeParams.resourceClass = "classes";
    $routeParams.resourceId = "1m";
    $httpBackend.whenGET("/api/v1/classes/1m/timetable.json").respond(timetableResponse);
    element = angular.element("<act-timetable></act-timetable>");
    $compile(element)($rootScope);
    $httpBackend.flush();
    $rootScope.$digest();

    controller = element.controller("actTimetable");
  }));

  afterEach(() => {
    $httpBackend.verifyNoOutstandingExpectation();
    $httpBackend.verifyNoOutstandingRequest();
  });

  it("contains 1 timetable cell as cells", () => {
      expect(controller.cells.length).toEqual(1);
  });

  describe("#setDate()", () => {
    it("sets dates array that contains 2015-05-25 to 2015-05-29", () => {
      controller.setDates("2015-05-25", "2015-05-29");
      expect(controller.dates).toEqual(
        ["2015-05-25", "2015-05-26", "2015-05-27", "2015-05-28", "2015-05-29"]
      );
    });
  });

  describe("#getLastWeek", () => {
    it("returns dates of last week", () => {
      controller.setDates("2015-05-25", "2015-05-29");
      expect(controller.getLastWeek()).toEqual(
        ["2015-05-18", "2015-05-19", "2015-05-20", "2015-05-21", "2015-05-22"]
      );
    });
  });

  describe("#getNextWeek", () => {
    it("returns dates of next week", () => {
      controller.setDates("2015-05-25", "2015-05-29");
      expect(controller.getNextWeek()).toEqual(
        ["2015-06-01", "2015-06-02", "2015-06-03", "2015-06-04", "2015-06-05"]
      );
    });
  });

  describe("#getRows", () => {
    it("returns rows grouped by scheduled_on", () => {
      expect(
        _.every(controller.getRows(), (row) => {
          return _.every(row.cells, "scheduled_on", row.date)
        })
      ).toBe(true);
    });

    it("returns all cells included in timetable", () => {
      expect(_.map(controller.getRows(), (row) => row.date)).toEqual(controller.dates);
    });

    it("returns all cells included in timetable", () => {
      expect(
        _.reduce(controller.getRows(), (sum, row) => sum + row.cells.length, 0)
      ).toEqual(controller.cells.length);
    });
  });
});

