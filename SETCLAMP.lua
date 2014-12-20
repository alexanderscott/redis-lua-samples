-- @desc:   Clamp a value between a min & max
-- @usage:  redis-cli EVAL "$(cat SETCLAMP.lua)" 1 <key> <min> <max>
-- @return: clamped value 

local function SETCLAMP(key, min, max)
  local valStr = redis.call("GET", key)
  if not valStr then return end
  local val = tonumber(valStr)

  if val > max then
    redis.call("SET", key, max)
    val = max
  elseif val < min then
    redis.call("SET", key, min)
    val = min
  end

  return val
end

--[[ @TEST
redis.call("SET", "test_max", 9)
local clampMax = SETCLAMP("test_max", 5, 7)
assert(clampMax == 7)
assert(redis.call("GET", "test_max") == "7")

redis.call("SET", "test_min", 4)
local clampMin = SETCLAMP("test_min", 5, 7)
assert(clampMin == 5)
assert(redis.call("GET", "test_min") == "5")

local clampEmpty = SETCLAMP("test_empty", 0, 10)
assert(clampEmpty == nil)
redis.call("DEL", "test_min", "test_max")
--]]

return SETCLAMP(KEYS[1], ARGV[1], ARGV[2])
