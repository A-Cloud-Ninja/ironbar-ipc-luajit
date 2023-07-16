# ironbar-ipc-luajit
[Ironbar](https://github.com/JakeStanger/ironbar) IPC implementation for Luajit

## Dependencies
- Single-file json implementation: https://github.com/rxi/json.lua
- [Luajit](https://luajit.org/) or another compatible interpreter with a luajit-compatible FFI syntax (maybe [luaffi](https://github.com/jmckaskill/luaffi))


## Basic usage:
- `require("ironbar")` Returns a function to obtain both the ironbar library, and the json library passed through.
```lua
local ironbar,json = require("ironbar")()
ironbar.ping()
ironbar.get("key")
ironbar.set("key","value")
ironbar.load_css("/path/to/stylesheet.css")
--I also built some goofy syntax for using it this way
ironbar("ping")
ironbar("get","key")
ironbar("set","key","value")
ironbar("load_css","/path/to/stylesheet.css")
```
All of these will return the decoded json as a table for use.

This implementation currently has support for features in PR #237 https://github.com/JakeStanger/ironbar/pull/237

## Files within
- cdefs.lua: Luajit FFI Cdefs for unix socket handling
- packets.lua: Table format for automated parsing of arguments -> json structures
- ironbar.lua: Main library, returns a function used to get both the ironbar module and json module used within.

ironbar.lua does not directly "expose" any given IPC message. It uses lua metatables to automatically use indexing on the `ironbar` module to pass through to the corresponding IPC packet (i.e `ironbar.ping()` -> turns into an internal `dispatch(ping)` call)
This may change as ironbars IPC changes.
