-- @desc:   Sum the provided key values
-- @usage:  redis-cli EVAL "$(cat MGETSUM.lua)" N <key1> <key2> ... <keyN>
-- @return: sum

local function MGETSUM(keys)
  local sum = 0

  for _,key in ipairs(keys) do
    local val = redis.call('GET', key) or 0
    sum = sum + tonumber(val)
  end

  return sum
end

--[[ @TEST
redis.call("SET", "test_str1", 1)
redis.call("SET", "test_str2", 2)
redis.call("SET", "test_str3", 3)
local mgetsum = MGETSUM({"test_str1", "test_str2", "test_str3"})
assert(mgetsum == 6)
redis.call("DEL", "test_str1", "test_str2", "test_str3")

local sumOfZero = MGETSUM({"test_empty1", "test_empty2"})
assert(sumOfZero == 0)
--]]

return MGETSUM(KEYS)
