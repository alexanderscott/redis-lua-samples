-- @desc:   Determine which keys exist from a list 
-- @usage:  redis-cli EVAL "$(cat MEXISTS.lua)" N <key1> <key2> ... <keyN>  
-- @return: list of existence in binary representation (ex/ {0, 1, 1, 0})

local function MEXISTS(keys)
  local exists = {}
  for _,key in ipairs(keys) do
    table.insert(exists, redis.call("EXISTS", key))
  end
  return exists
end

--[[ @TEST
redis.call("SET", "test_key1", 1)
redis.call("ZADD", "test_key2", 2, "two")
redis.call("SADD", "test_key3", "three")
local mexists = MEXISTS({"test_key1", "test_keynull", "test_key2", "test_key3"})
assert(mexists[1] == 1)
assert(mexists[2] == 0)
assert(mexists[3] == 1)
assert(mexists[4] == 1)
redis.call("DEL", "test_key1", "test_key2", "test_key3")
--]]

return MEXISTS(KEYS)
