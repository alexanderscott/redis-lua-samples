# redis-lua-samples
Some useful Lua scripts for common Redis operations.

Includes:
* COPY      - copy a key without knowing its type
* MGETSUM   - sum multiple string values
* MEXISTS   - get multiple key existence
* MZCARD    - get multiple ZSET sizes
* SETCLAMP  - clamp a value between a min and max
* SPUBLISH  - publish a message to all members of a set
* ZMEAN     - mean of scores in a ZSET
* ZSPLIT    - split a ZSET in two via round-robin
* ZSPREAD   - spread members between two ZSETS (random selection) 
* ZSTDDEV   - standard deviation of ZSET scores


### License

The MIT License (MIT)

Copyright (c) 2014 Alex Ehrnschwender

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
