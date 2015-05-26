describe("HelloDirective", () => {
  var $compile: ng.ICompileService;
  var $rootScope: ng.IRootScopeService;

  beforeEach(angular.mock.module("actopus"));

  beforeEach(inject((_$compile_, _$rootScope_) => {
    $compile = _$compile_;
    $rootScope = _$rootScope_;
  }));

  it("contains hello world!", () => {
    let element = $compile("<act-hello></act-hello>")($rootScope);
    $rootScope.$digest();
    expect(element.html()).toContain("hello world!");
  });
});