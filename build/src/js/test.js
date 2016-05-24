describe("a suite is a function", function() {
  var a;
  a = false;
  return it("and so it is aa spec", function() {
    a = true;
    return expect(a).toBe(true);
  });
});
