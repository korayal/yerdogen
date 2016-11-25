## Random string generator for yerdo

- Install [stack](http://www.haskellstack.org)
- Build with `stack build`
- Run `stack exec yerdogen -- 10 '***$$$'`

for template string:
`#`: Numerical characters

`*`: Alphanumerical characters

Example usage:

``` bash
# stack exec yerdogen  -- 10 'HELLO$$$_***WORLD'
HELLO135_V71WORLD
HELLO467_EYNWORLD
HELLO373_XKMWORLD
HELLO913_D1HWORLD
HELLO383_LPDWORLD
HELLO437_V2KWORLD
HELLO243_7NVWORLD
HELLO353_8GGWORLD
HELLO131_P82WORLD
HELLO462_CXWWORLD
```
