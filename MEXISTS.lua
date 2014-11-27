-- @desc:   Determine which keys exist from a list 
-- @usage:  redis-cli EVAL "$(cat MEXISTS.lua)" N <key1> <key2> ... <keyN>  
-- @return: list of existence in binary representation (ex/ [0, 1, 1, 0])

local function MEXISTS(keys)
  local exists = {}
  for _,key in ipairs(keys) do
    table.insert(exists, redis.call("EXISTS", key))
  end
  return exists
end

return MEXISTS(KEYS)
