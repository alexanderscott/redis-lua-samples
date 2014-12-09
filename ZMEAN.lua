-- @desc:   Return the mean of a ZSET
-- @usage:  redis-cli eval "$(cat ZMEAN.lua)" 1 <zsetKey>
-- @return: string representation of float


local function ZMEAN(keys)
  local keySum = 0
  local membersWithScores = redis.call("ZREVRANGE", key, 0, -1, "WITHSCORES")
  for idx,val in ipairs(membersWithScores) do
      if idx % 2 == 0 then keySum = keySum + tonumber(val) end
  end
  return (keySum / (#membersWithScores / 2))
end

return ZMEAN(KEYS[1])
