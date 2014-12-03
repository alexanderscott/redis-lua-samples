-- @desc:   Copy a key without knowing its type
-- @usage:  redis-cli EVAL "$(cat COPY.lua)" 2 <key> <destKey>

local function COPY(key, dest)
  local keyType = redis.call("TYPE", key)

  if keyType == "set" then return redis.call("SUNIONSTORE", dest, key)
  elseif keyType == "zset" then return redis.call("ZUNIONSTORE", dest, 1, key)
  elseif keyType == "list" then return redis.call("SORT", key, "BY", "NOSORT", "STORE", dest)
  elseif keyType == "string" then return redis.call("SET", dest, redis.call("GET", key))
  elseif keyType == "hash" then
    local hash = redis.call('HGETALL', key);
    return redis.call('HMSET', dest, unpack(hash));
  else return { err = "Key "..key.." does not exist or has unknown type"} 
  end
end

return COPY(KEYS[1], KEYS[2])
