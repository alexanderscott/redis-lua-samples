-- @desc:   Copy a key without knowing its type
-- @usage:  redis-cli EVAL "$(cat COPY.lua)" 2 <key> <destKey>

local function COPY(key, dest)
  local keyType = redis.call("TYPE", key)

  if keyType == "set" then redis.call("SUNIONSTORE", dest, key)
  elseif keyType == "zset" then redis.call("ZUNIONSTORE", dest, 1, key)
  elseif keyType == "list" then redis.call("SORT", key, "BY", "NOSORT", "STORE", dest)
  elseif keyType == "string" then redis.call("SET", dest, redis.call("GET", key))
  elseif keyType == "hash" then
    local hash = redis.call('HGETALL', key);
    redis.call('HMSET', dest, unpack(hash));
  --else return { err = "Key "..key.." does not exist or has unknown type"} 
  end
  return
end


--[[ @TEST
redis.call("ZADD", "test_zset1", 5, "five", 6, "six")
COPY("test_zset1", "test_zset2")
assert(redis.call("ZCARD", "test_zset2") == 2)
assert(redis.call("ZSCORE", "test_zset2", "five") == 5)
redis.call("DEL", "test_zset1", "test_zset2")


redis.call("SADD", "test_set1", "five", "six")
COPY("test_set1", "test_set2")
assert(redis.call("SCARD", "test_set2") == 2)
redis.call("DEL", "test_set1", "test_set2")

redis.call("SET", "test_str1", "five")
COPY("test_str1", "test_str2")
assert(redis.call("GET", "test_str2") == "five")
redis.call("DEL", "test_str1", "test_str2")
--]]

return COPY(KEYS[1], KEYS[2])

