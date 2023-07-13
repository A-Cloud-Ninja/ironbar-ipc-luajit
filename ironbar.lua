local packets, argpackets = require("packets")()
local json = require("json")
local ffi = require("cdefs")
local runtimedir = os.getenv("XDG_RUNTIME_DIR") or "/tmp"
local sockpath = runtimedir.."/ironbar-ipc.sock"
--Generic function for connecting to the socket
local function connect()
	local fd = ffi.C.socket(1, 1, 0)
	if fd == -1 then
		return nil, "socket"
	end
	local addr = ffi.new("struct sockaddr_un")
	addr.sun_family = 1
	ffi.copy(addr.sun_path, sockpath)
	if ffi.C.connect(fd, ffi.cast("struct sockaddr *", addr), ffi.sizeof(addr)) == -1 then
		ffi.C.close(fd)
		return nil, "connect"
	end
	return fd
end
local function format_packet(_type,...)
	if argpackets[_type] then
		local packet = packets[_type]
		for k,v in pairs(argpackets[_type]) do
			if v.arg then
				packet[k] = select(v.arg,...)
			else
				packet[k] = v
			end
		end
		return packet
	end
	return packets[_type]
end
--Sending and receiving packets
local function send_packet(fd,enc_packet)
	local len = #enc_packet
	local sent = ffi.C.write(fd,enc_packet,len)
	if sent == -1 then
		return nil, "write"
	end
	if sent ~= len then
		return nil, "short write"
	end
	return true
end
local function read_response(fd)
	local buf = ffi.new("char[?]", 4096)
	local len = ffi.C.read(fd, buf, 4096)
	if len == -1 then
		return nil, "read"
	end
	return ffi.string(buf,len)
end

--Helper to do both
local function send_receive(fd,packet)
	local ok,err = send_packet(fd,json.encode(packet))
	local send_err = false
	if not ok then
		send_err = err
	end
	local response,err = read_response(fd)
	if not response then
		return nil, err, send_err
	end
	local packet = json.decode(response)
	if not packet then
		return nil, "decode"
	end
	return packet
end

local ironbar = {}
local sock = nil
local function init()
	sock = connect()
	if not sock then
		return nil, "connect"
	end
	return true
end

local function dispatch(socket,_type,...)
	if not packets[_type] then
		return nil, "invalid packet type"
	end
	local packet = format_packet(_type,...)
	local packet_or_nil, err, send_err = send_receive(socket,packet)
	if type(packet_or_nil) == "table" then
		return true, packet_or_nil
	else
		return false, err, send_err
	end
end

local mt = {
	__index = function(t,k)
		if packets[k] then
			init()
			return function(...)
				return dispatch(sock,k,...)
			end
		else
			error("invalid packet type")
		end
	end,
	__call = function(t,k,...)
		if packets[k] then
			init()
			return function(...)
				return dispatch(sock,k,...)
			end
		else
			error("invalid packet type")
		end
	end
}
setmetatable(ironbar,mt)
return function()
	return ironbar,json
end
