-- @desc:   Return the mean of a ZSET
-- @usage:  redis-cli eval "$(cat ZMEAN.lua)" 1 <zsetKey>
-- @return: string representation of float


local function ZMEAN(key)

  local keySum = 0
  local membersWithScores = redis.call("ZREVRANGE", key, 0, -1, "WITHSCORES")

  if next(membersWithScores) == nil then return tostring(0) end

  for idx,val in ipairs(membersWithScores) do
      if idx % 2 == 0 then keySum = keySum + tonumber(val) end
  end
  return tostring(keySum / (#membersWithScores / 2))
end

--[[ @TEST
redis.call("ZADD", "test_zset1", 5, "five", 6, "six")
local mean = ZMEAN("test_zset1")
assert(mean == "5.5")
redis.call("DEL", "test_zset1")

local meanError = ZMEAN("test_zset3")
assert(type(meanError["err"]) == "string")
--]]

return ZMEAN(KEYS[1])
