/// <reference path="../../typings/bundle.d.ts" />

describe("HelloDirective", () => {
  var $compile: ng.ICompileService;
  var $rootScope: ng.IRootScopeService;

  beforeEach(angular.mock.module("actopus"));

  beforeEach(inject((_$compile_: ng.ICompileService, _$rootScope_: ng.IRootScopeService) => {
    $compile = _$compile_;
    $rootScope = _$rootScope_;
  }));

  it("contains hello world!", () => {
    var element = $compile("<act-hello></act-hello>")($rootScope);
    $rootScope.$digest();
    expect(element.html()).toContain("hello world!");
  });
});
