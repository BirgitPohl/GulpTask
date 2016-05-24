describe "a suite is a function", ->
  a = false
  it "and so it is aa spec", ->
    a = true
    ##test
    expect(a).toBe(true)