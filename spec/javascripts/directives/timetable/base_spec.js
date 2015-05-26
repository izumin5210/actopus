import timetableResponse from "../../fixtures/timetable.json";

describe("TimetableDirective", () => {
  let $compile, $rootScope, $httpBackend, $routeParams;
  let element;

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
  }));

  afterEach(() => {
    $httpBackend.verifyNoOutstandingExpectation();
    $httpBackend.verifyNoOutstandingRequest();
  });

  it("should request GET /api/v1/classes/1m/timetable.json", () => {
    $httpBackend.expectGET("/api/v1/classes/1m/timetable.json");
    $httpBackend.flush();
  });

  it("contains 1 timetable cell as cells", () => {
      $httpBackend.flush();
      $rootScope.$digest();
      expect(element.controller("actTimetable").cells.length).toEqual(1);
  });

  describe("#setDate()", () => {
    it("sets dates array that contains 2015-05-25 to 2015-05-29", () => {
      $httpBackend.flush();
      $rootScope.$digest();
      let controller = element.controller("actTimetable");
      controller.setDates("2015-05-25", "2015-05-29");
      expect(controller.dates).toEqual(
        ["2015-05-25", "2015-05-26", "2015-05-27", "2015-05-28", "2015-05-29"]
      );
    });
  });
});

