-- @desc:   Split a ZSET in two via round-robin
-- @usage:  redis-cli eval "$(cat ZSPLIT)" 2 <originalZset> <newZset>
-- @return: list of moved members

local function ZSPLIT(zset1, zset2)
  local zset1size = redis.call("ZCARD", zset1)
  if zset1size == 0 then return {} end
  
  local members = redis.call("ZREVRANGEBYSCORE", zset1, "+INF", "-INF", "WITHSCORES")

  local tmpMembers = {}
  local tmpScores = {}

  for idx,val in ipairs(members) do
    if idx % 2 == 0 then table.insert(tmpScores, val)
    else table.insert(tmpMembers, val) end

    if idx % 4 == 0 then
      redis.call("ZREM", zset1, tmpMembers[#tmpMembers])
      redis.call("ZADD", zset2, tonumber(tmpScores[#tmpScores]), tmpMembers[#tmpMembers])  
    end
  end

  return tmpMembers
end

return ZSPLIT(KEYS[1], KEYS[2])
