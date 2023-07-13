local packets = {}
packets.ping = {
	type = "ping"
}

packets.inspect = {
	type = "inspect"
}
packets.reload = {
	type = "reload"
}
packets.get = {
	type = "get",
	key = ""
}
packets.set = {
	type = "set",
	key = "",
	value = ""
}
packets.load_css = {
	type = "load_css",
	path = ""
}
--[[

Pending PR #236 <https://github.com/JakeStanger/ironbar/pull/236>

--]]
packets.set_visible = {
	type = "set_visible",
	bar_name = "",
	visible = true
}
packets.get_visible = {
	type = "get_visible",
	bar_name = ""
}


local argpackets = {}
argpackets.set = {
	type = "set",
	key = {arg=1},
	value = {arg=2}
}
argpackets.get = {
	type = "get",
	key = {arg=1}
}
argpackets.load_css = {
	type = "load_css",
	path = {arg=1}
}
--[[

Pending PR #236 <https://github.com/JakeStanger/ironbar/pull/236>

--]]
argpackets.set_visible = {
	type = "set_visible",
	bar_name = {arg=1},
	visible = {arg=2}
}
argpackets.get_visible = {
	type = "get_visible",
	bar_name = {arg=1}
}

return function()
	return packets, argpackets
end
