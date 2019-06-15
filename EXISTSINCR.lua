-- @desc:   Increment a key atomically if it exists
-- @usage:  redis-cli EVAL "$(cat EXISTSINCR.lua)" 1 <key>
-- @return: the incremented key value, or nil if it doesn't exist

local function EXISTSINCR(key)
  if redis.call("EXISTS", key) == 1 then
    return redis.call("INCR", key)
  else
    return nil
  end
end

--[[ @TEST
redis.call("SET", "test_key_1", "10")

local incremented = EXISTSINCR("test_key_1")
assert(tonumber(incremented) == 11)

local nilcase = EXISTSINCR("test_foo")
assert(nilcase == nil)

redis.call("DEL", "test_key_1")
--]]

return EXISTSINCR(KEYS[1])

