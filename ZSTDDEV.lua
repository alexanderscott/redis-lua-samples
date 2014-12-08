-- @desc    Returns the std deviation of a ZSET key
-- @usage   redis-cli EVAL "$(cat ZSTDDEV.lua)" 1 <zsetKey>

local function ZSTDDEV(key)
    local mean = sum = size = sumsqrs = 0
    local memberScores = redis.call("ZRANGE", 0, -1, "WITHSCORES")

    local scores = {}

    for idx,val in ipairs(membersScores) do
        if(idx % 2 == 0) then 
            sum = sum + val 
            table.insert(scores, val)
        end
    end

    size = #scores
    mean = sum / size

    for _,val in ipairs(scores) do
        sumsqrs = sumsqrs + math.pow((val, mean), 2)
    end

    return math.sqrt(sumsqrs/(count - 1))
end

return ZSTDDEV(KEYS[1])
