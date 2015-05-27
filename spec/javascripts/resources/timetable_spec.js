import timetableResponse from "../fixtures/timetable.json";

describe("Timetable", () => {
  let $httpBackend, Timetable;
  let params;

  beforeEach(angular.mock.module("actopus"));

  beforeEach(inject((_$httpBackend_, _Timetable_) => {
    $httpBackend = _$httpBackend_;
    Timetable = _Timetable_;
    $httpBackend.whenGET("/api/v1/classes/1m/timetable.json").respond(timetableResponse);
    params = { resourceClass: "classes", resourceId: "1m" };
  }));

  afterEach(() => {
    $httpBackend.verifyNoOutstandingExpectation();
    $httpBackend.verifyNoOutstandingRequest();
  });

  describe(".query", () => {
    it("should request GET /api/v1/classes/1m/timetable.json", () => {
      $httpBackend.expectGET("/api/v1/classes/1m/timetable.json");
      Timetable.query(params);
      $httpBackend.flush();
    });

    it("returns 1 timetable cell", () => {
      let cells = Timetable.query(params);
      $httpBackend.flush();
      expect(cells.length).toEqual(1);
    });

    it("returns the response that contains beginning_of_week", () => {
      let res = Timetable.query(params);
      $httpBackend.flush();
      expect(Object.keys(res)).toContain("beginning_of_week");
    });

    it("returns the response that contains end_of_week", () => {
      let res = Timetable.query(params);
      $httpBackend.flush();
      expect(Object.keys(res)).toContain("end_of_week");
    });
  });
});
