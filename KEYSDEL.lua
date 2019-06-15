-- @desc:   Find and delete all keys matching a provided pattern
-- @usage:  redis-cli EVAL "$(cat KEYSDEL.lua)" 1 <key-pattern>
-- @return: integer value for number of keys removed

local function KEYSDEL(pattern)
  local keys = redis.call("KEYS", pattern) 

  if next(keys) == nil then return 0 end

  return redis.call("DEL", unpack(keys))
end

--[[ @TEST
redis.call("SET", "test_key_1", "Hello")
redis.call("ZADD", "test_key_2", 5, "five", 6, "six")
redis.call("HSET", "test_other_key_3", "field1", "Hello")

local deleted = KEYSDEL("test_key_?")
assert(deleted == 2)

local nonedeleted = KEYSDEL("foo")
assert(nonedeleted == 0)

redis.call("DEL", "test_other_key_3")
--]]

return KEYSDEL(KEYS[1])
