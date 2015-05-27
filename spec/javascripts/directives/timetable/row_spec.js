import timetableResponse from "../../fixtures/timetable.json";
import _ from "lodash";

describe("TimetableRowDirective", () => {
  let $compile, $rootScope;
  let element, controller, scope;

  beforeEach(angular.mock.module("actopus"));

  beforeEach(inject((_$compile_, _$rootScope_) => {
    $compile = _$compile_;
    $rootScope = _$rootScope_;

    element = angular.element("<act-timetable-row cells=\"cells\"></act-timetable-row>");

    scope = $rootScope;
    scope.cells = timetableResponse.cells;
    $compile(element)(scope);
    scope.$digest();

    controller = element.controller("actTimetableRow");
  }));

  it("binds scope.cells to controller", () => {
    expect(controller.cells()).toEqual(scope.cells);
  });

  it("has act-timetable-cell directives of the same number as cells", () => {
    expect(element.find("act-timetable-cell").length).toEqual(scope.cells.length);
  });
});
