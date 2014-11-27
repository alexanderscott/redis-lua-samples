-- @desc:   Sum the provided key values
-- @usage:  redis-cli EVAL "$(cat MGETSUM.lua)" N <key1> <key2> ... <keyN>
-- @return: sum

local function MGETSUM(keys)
  local sum = 0

  for _,key in ipairs(keys) do
    local val = redis.call('GET', key)
    sum = sum + tonumber(val)
  end

  return sum
end

return MGETSUM(KEYS)
