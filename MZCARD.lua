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

return MZCARD(KEYS)
