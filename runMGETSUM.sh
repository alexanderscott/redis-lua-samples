redis-cli EVAL "$(cat MGETSUM.lua)" 3 key1 key2 key3
