-- @desc:   Spread members between two ZSETs so they are even size
-- @usage:  redis-cli eval "$(cat ZSPREAD.lua)" 2 <zset1> <zset2>
-- @return: list of spread members

local function round(num) 
  if num >= 0 then return math.floor(num+.5) 
  else return math.ceil(num-.5) end
end

local function randomFromTo(from, to)
  local diff = to - from
  return round((math.random() * diff) + from)
end

local function ZSPREAD(zset1, zset2)
  local zset1size = redis.call("ZCARD", zset1)
  if zset1size == 0 then return {} end

  local zset2size = redis.call("ZCARD", zset2)
  if zset2size == 0 then return {} end

  local fromZset, fromZsetSize = zset1, zset1size
  local toZsetSize, toZsetSize = zset2, zset2size

  if zset1size > zset2size then 
    fromZset, fromZsetSize = toZset, toZsetSize
  elseif zset1size == zset2size then
    return {}
  end

  
  local spreadCount = round(((fromZsetSize - toZsetSize) / 2))
  if spreadCount == 0 then return {} end

  local members = redis.call("ZREVRANGEBYSCORE", zset1, "+INF", "-INF", "WITHSCORES")

  local tmpMembers = {}

  for i=1,spreadCount do
    local randIdx = randomFromTo(0, (fromZsetSize - 1))
    local tmpMember = redis.call("ZREVRANGE", fromZset, randIdx, randIdx, "WITHSCORES")

    for idx,val in ipairs(tmpMember) do
      if idx % 2 == 0 then 
        redis.call("ZADD", toZset, tonumber(val), tmpMembers[#tmpMembers])
      else 
        table.insert(tmpMembers, val)
        redis.call("ZREM", fromZset, val)
      end
    end
  end

  return tmpMembers
end

return ZSPREAD(KEYS[1], KEYS[2])
