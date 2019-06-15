-- @desc:   Atomically increment a key and add/update key expiration (in seconds)
--          First sets the key if it doesn't yet exist
-- @usage:  redis-cli EVAL "$(cat INCREXPIRE.lua)" 2 <key> <expiration>
-- @return: the incremented key value

local function INCREXPIRE(key, expiration)
  if redis.call("EXISTS", key) < 1 then
    redis.call("SET", key, 0)
  end

  local i = redis.call("INCR", key)
  redis.call("EXPIRE", key, expiration)
  return i
end

--[[ @TEST
redis.call("SET", "test_key_1", "10")

local incremented = INCREXPIRE("test_key_1", 10)
assert(tonumber(incremented) == 11)

local nilcase = INCREXPIRE("test_key_2", 10)
assert(tonumber(nilcase) == 1)

local ttl1 = redis.call("TTL", "test_key_1")
local ttl2 = redis.call("TTL", "test_key_2")

assert(incremented > 0)
assert(nilcase > 0)

redis.call("DEL", "test_key_1")
redis.call("DEL", "test_key_2")

--]]

return INCREXPIRE(KEYS[1], KEYS[2]) 

