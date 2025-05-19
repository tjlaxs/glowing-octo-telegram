local Test = require("test")

local function sum(a, b)
  return a + b
end

Test.it('is adding 1 + 2 to equal 3', function()
  return Test.expect(sum(1, 2), 3)
end)

Test.it('is adding 1 + 2 to equal 4', function()
  return Test.expect(sum(1, 2), 4)
end)

Test.run()
