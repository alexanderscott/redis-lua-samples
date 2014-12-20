-- @desc:   Publish a message to all SET member channels
-- @usage:  redis-cli EVAL "$(cat SPUBLISH.lua)" 1 <setKey> <message>
-- @return: number of SET member channels 

local function SPUBLISH(key, msg)
  local members = redis.call("SMEMBERS", key)

  for _,member in ipairs(members) do
    redis.call("PUBLISH", member, msg)
  end

  return #members
end

return SPUBLISH(KEYS[1], ARGV[1])
