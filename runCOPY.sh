# actually, does not work as type command does not return correctly
redis-cli EVAL "$(cat COPY.lua)" 2 zset1 zset1Dup
