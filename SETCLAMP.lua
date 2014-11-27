-- @desc:   Clamp a value between a min & max
-- @usage:  redis-cli EVAL "$(cat SETCLAMP.lua)" 1 <key> <min> <max>
-- @return: clamped value 

local function SETCLAMP(key, min, max)
  local val = tonumber(redis.call("GET", key))

  if val > max then
    redis.call("SET", key, max)
    val = max
  elseif val < min then
    redis.call("SET", key, min)
    val = min
  end

  return val
end

return SETCLAMP(KEYS[1], ARGV[1], ARGV[2])
