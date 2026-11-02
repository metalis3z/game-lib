-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = {}
v_u_2.__index = v_u_2
function v_u_1.new()
	-- upvalues: (copy) v_u_1
	local v3 = v_u_1
	return setmetatable({
		["_active"] = true,
		["_head"] = nil
	}, v3)
end
function v_u_1.Is(p4)
	-- upvalues: (copy) v_u_1
	local v5
	if typeof(p4) == "table" then
		v5 = getmetatable(p4) == v_u_1
	else
		v5 = false
	end
	return v5
end
function v_u_1.IsActive(p6)
	return p6._active == true
end
function v_u_1.Connect(p7, p8)
	-- upvalues: (copy) v_u_2
	local v9 = typeof(p8) == "function"
	assert(v9, "Must be function")
	if p7._active ~= true then
		local v10 = v_u_2
		return setmetatable({
			["Connected"] = false,
			["_node"] = nil
		}, v10)
	end
	local v11 = p7._head
	local v12 = {
		["_signal"] = p7,
		["_connection"] = nil,
		["_handler"] = p8,
		["_next"] = v11,
		["_prev"] = nil
	}
	if v11 ~= nil then
		v11._prev = v12
	end
	p7._head = v12
	local v13 = v_u_2
	local v14 = setmetatable({
		["Connected"] = true,
		["_node"] = v12
	}, v13)
	v12._connection = v14
	return v14
end
function v_u_1.Once(p15, p_u_16)
	local v17 = typeof(p_u_16) == "function"
	assert(v17, "Must be function")
	local v_u_18 = nil
	v_u_18 = p15:Connect(function(...)
		-- upvalues: (ref) v_u_18, (copy) p_u_16
		if v_u_18 ~= nil then
			v_u_18:Disconnect()
			v_u_18 = nil
			p_u_16(...)
		end
	end)
	return v_u_18
end
v_u_1.ConnectOnce = v_u_1.Once
function v_u_1.Wait(p19)
	local v_u_20 = coroutine.running()
	local v_u_21 = nil
	v_u_21 = p19:Connect(function(...)
		-- upvalues: (ref) v_u_21, (ref) v_u_20
		if v_u_21 ~= nil then
			v_u_21:Disconnect()
			v_u_21 = nil
			task.spawn(v_u_20, ...)
		end
	end)
	return coroutine.yield()
end
function v_u_1.Fire(p22, ...)
	local v23 = p22._head
	while v23 ~= nil do
		task.defer(v23._handler, ...)
		v23 = v23._next
	end
end
function v_u_1.DisconnectAll(p24)
	local v25 = p24._head
	while v25 ~= nil do
		local v26 = v25._connection
		if v26 ~= nil then
			v26.Connected = false
			v26._node = nil
			v25._connection = nil
		end
		v25 = v25._next
	end
	p24._head = nil
end
function v_u_1.Destroy(p27)
	if p27._active == true then
		p27:DisconnectAll()
		p27._active = false
	end
end
function v_u_2.Disconnect(p28)
	if p28.Connected == true then
		p28.Connected = false
		local v29 = p28._node
		local v30 = v29._prev
		local v31 = v29._next
		if v31 ~= nil then
			v31._prev = v30
		end
		if v30 == nil then
			v29._signal._head = v31
		else
			v30._next = v31
		end
		v29._connection = nil
		p28._node = nil
	end
end
v_u_2.Destroy = v_u_2.Disconnect
return v_u_1
