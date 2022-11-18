# redis-cli eval "$(cat ZSPREAD.lua)" 2 zset1 zset2
# another way to run this using --eval
redis-cli --eval ZSPREAD.lua zset1 zset2
