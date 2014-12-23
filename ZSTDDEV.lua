-- @desc    Returns the std deviation of a ZSET key
-- @usage   redis-cli EVAL "$(cat ZSTDDEV.lua)" 1 <zsetKey>
-- @return  string representation of float value

local function ZSTDDEV(key)
    local mean, sum, size, sumsqrs = 0, 0, 0, 0
    local memberScores = redis.call("ZRANGE", key, 0, -1, "WITHSCORES")

    local scores = {}

    for idx,val in ipairs(memberScores) do
        if(idx % 2 == 0) then 
            sum = sum + val 
            table.insert(scores, val)
        end
    end

    size = #scores
    mean = sum / size

    for _,val in ipairs(scores) do
        sumsqrs = sumsqrs + math.pow((val - mean), 2)
    end

    return math.sqrt(sumsqrs/(size))
end

--[[ @TEST
redis.call("DEL", "test_zstddev")
redis.call("ZADD", "test_zstddev", 2, "one", 4, "two", 4, "three", 4,
            "four", 5, "five", 5, "six", 7, "seven", 9, "eight")
local zstddev = ZSTDDEV("test_zstddev")
assert(zstddev == 2)
--]]

return tostring(ZSTDDEV(KEYS[1]))
