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
packets.set_visible = {
	type = "set_visible",
	bar_name = "",
	visible = true
}
packets.get_visible = {
	type = "get_visible",
	bar_name = ""
}
packets.toggle_popup = {
	type = "toggle_popup",
	bar_name = "",
	name = "",
}
packets.open_popup = {
	type = "open_popup",
	bar_name = "",
	name = "",
}
packets.close_popup = {
	type = "close_popup",
	bar_name = "",
	name = "",
}
local argpackets = {}
argpackets.set = {
	type = "set",
	key = {arg=1, type="string"},
	value = {arg=2,type="string"}
}
argpackets.get = {
	type = "get",
	key = {arg=1,type="string"}
}
argpackets.load_css = {
	type = "load_css",
	path = {arg=1,type="string"}
}
argpackets.set_visible = {
	type = "set_visible",
	bar_name = {arg=1,type="string"},
	visible = {arg=2,type="boolean"}
}
argpackets.get_visible = {
	type = "get_visible",
	bar_name = {arg=1,type="string"}
}
argpackets.toggle_popup = {
	type = "toggle_popup",
	bar_name = {arg=1,type="string"},
	name = {arg=2,type="string"},
}
argpackets.open_popup = {
	type = "open_popup",
	bar_name = {arg=1,type="string"},
	name = {arg=2,type="string"},
}
argpackets.close_popup = {
	type = "close_popup",
	bar_name = {arg=1,type="string"},
	name = {arg=2,type="string"},
}

return function()
	return packets, argpackets
end
