-- @desc:   Return the sum of all scores in a sorted set
-- @usage:  redis-cli eval "$(cat ZSUM.lua)" N <zset1> <zset2> ... <zsetN>
-- @return: integer sum


local function ZSUM(keys)

  local sum = 0

  local function sumKeyScores(key)
    local keySum = 0
    local membersWithScores = redis.call("ZREVRANGE", key, 0, -1, "WITHSCORES")
    for idx,val in ipairs(membersWithScores) do
      if idx % 2 == 0 then keySum = keySum + tonumber(val) end
    end
    return keySum
  end

  for _,key in ipairs(keys) do
    sum = sum + sumKeyScores(key)
  end

  return sum
end

return ZSUM(KEYS)
