-- @desc:   Get size of multiple ZSETs
-- @usage:  redis-cli EVAL "$(cat MZCARD.lua)" N <zset1> <zset2> ... <zsetN>
-- @return: list of sizes

local function MZCARD(keys)
  local sizes = {}
  for _,key in ipairs(keys) do
    table.insert(sizes, redis.call("ZCARD", key))
  end
  return sizes
end

--[[ @TEST
redis.call("ZADD", "test_zset1", 5, "five", 6, "six")
redis.call("ZADD", "test_zset2", 7, "seven", 8, "eight", 9, "nine")
local mzcard = MZCARD({"test_zset1", "test_empty", "test_zset2"})
assert(mzcard[1] == 2)
assert(mzcard[2] == 0)
assert(mzcard[3] == 3)
redis.call("DEL", "test_zset1", "test_zset2")
--]]

return MZCARD(KEYS)
