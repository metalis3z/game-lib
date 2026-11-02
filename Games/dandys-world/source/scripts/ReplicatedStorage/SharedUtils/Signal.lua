--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- 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

-- https://lua.expert/
local t = {}

t.__index = t
function t.new(p1, p2) --[[ new | Line: 23 | Upvalues: t (copy) ]]
	return setmetatable({
		Connected = true,
		_signal = p1,
		_conn = p2
	}, t)
end
function t.Disconnect(p1) --[[ Disconnect | Line: 33 ]]
	if p1._conn then
		p1._conn:Disconnect()
		p1._conn = nil
	end

	if not p1._signal then
		return
	end

	p1.Connected = false

	local _connections = p1._signal._connections
	local v1 = table.find(_connections, p1)

	if v1 then
		local v2 = #_connections

		_connections[v1] = _connections[v2]
		_connections[v2] = nil
	end

	p1._signal = nil
end
function t.IsConnected(p1) --[[ IsConnected | Line: 56 ]]
	if p1._conn then
		return p1._conn.Connected
	end

	return false
end
t.Destroy = t.Disconnect

local t2 = {}

t2.__index = t2
function t2.new(p1) --[[ new | Line: 69 | Upvalues: t2 (copy) ]]
	local v2 = setmetatable({
		_threads = 0,
		_id = 0,
		_bindable = Instance.new("BindableEvent"),
		_connections = {},
		_args = {}
	}, t2)

	if p1 then
		p1:GiveTask(v2)
	end

	return v2
end
function t2.Proxy(p1, p2) --[[ Proxy | Line: 85 | Upvalues: t2 (copy) ]]
	assert(if typeof(p1) == "RBXScriptSignal" then true else false, "Argument #1 must be of type RBXScriptSignal")

	local v2 = t2.new(p2)

	v2:_setProxy(p1)

	return v2
end
function t2.Is(p1) --[[ Is | Line: 93 | Upvalues: t2 (copy) ]]
	return if type(p1) == "table" then getmetatable(p1) == t2 else false
end
function t2._setProxy(p1, p2) --[[ _setProxy | Line: 97 ]]
	assert(if typeof(p2) == "RBXScriptSignal" then true else false, "Argument #1 must be of type RBXScriptSignal")
	p1:_clearProxy()
	p1._proxyHandle = p2:Connect(function(...) --[[ Line: 101 | Upvalues: p1 (copy) ]]
		p1:Fire(...)
	end)
end
function t2._clearProxy(p1) --[[ _clearProxy | Line: 106 ]]
	if not p1._proxyHandle then
		return
	end

	p1._proxyHandle:Disconnect()
	p1._proxyHandle = nil
end
function t2.Fire(p1, ...) --[[ Fire | Line: 113 ]]
	local v1 = #p1._connections + p1._threads

	if v1 ~= 0 then
		local _id = p1._id

		p1._id = p1._id + 1
		p1._args[_id] = {
			v1,
			{
				n = select("#", ...),
				...
			}
		}
		p1._threads = 0
		p1._bindable:Fire(_id)
	end
end
function t2.Wait(p1) --[[ Wait | Line: 133 ]]
	p1._threads = p1._threads + 1

	local v1 = p1._bindable.Event:Wait()
	local v2 = p1._args[v1]

	v2[1] = v2[1] - 1

	local v3, v4

	if not (v2[1] <= 0) then
		v3 = v2[2]
		v4 = v2[2].n

		return table.unpack(v3, 1, v4)
	end

	p1._args[v1] = nil
	v3 = v2[2]
	v4 = v2[2].n

	return table.unpack(v3, 1, v4)
end
function t2.Connect(p1, p2) --[[ Connect | Line: 146 | Upvalues: t (copy) ]]
	local v1 = t.new(p1, p1._bindable.Event:Connect(function(p12) --[[ Line: 147 | Upvalues: p1 (copy), p2 (copy) ]]
		local v1 = p1._args[p12]

		v1[1] = v1[1] - 1

		local v3, v4

		if v1[1] <= 0 then
			p1._args[p12] = nil
		end

		v3 = v1[2]
		v4 = v1[2].n
		p2(table.unpack(v3, 1, v4))
	end))

	table.insert(p1._connections, v1)

	return v1
end
function t2.DisconnectAll(p1) --[[ DisconnectAll | Line: 161 ]]
	for i, v in ipairs(p1._connections) do
		if v._conn then
			v._conn:Disconnect()
		end
	end

	p1._connections = {}
	p1._args = {}
end
function t2.Destroy(p1) --[[ Destroy | Line: 172 ]]
	p1:DisconnectAll()
	p1:_clearProxy()
	p1._bindable:Destroy()
end

return t2