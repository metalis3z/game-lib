-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = {}
v_u_2.__index = v_u_2
local v_u_3 = nil
local function v_u_6(p4, ...)
	-- upvalues: (ref) v_u_3
	local v5 = v_u_3
	v_u_3 = nil
	p4(...)
	v_u_3 = v5
end
local function v_u_7()
	-- upvalues: (ref) v_u_3, (copy) v_u_6
	v_u_3 = coroutine.running()
	while true do
		v_u_6(coroutine.yield())
	end
end
function v_u_1.new()
	-- upvalues: (copy) v_u_1
	local v8 = v_u_1
	return setmetatable({
		["_active"] = true,
		["_head"] = nil
	}, v8)
end
function v_u_1.Is(p9)
	-- upvalues: (copy) v_u_1
	local v10
	if typeof(p9) == "table" then
		v10 = getmetatable(p9) == v_u_1
	else
		v10 = false
	end
	return v10
end
function v_u_1.IsActive(p11)
	return p11._active == true
end
function v_u_1.Connect(p12, p13)
	-- upvalues: (copy) v_u_2
	local v14 = typeof(p13) == "function"
	assert(v14, "Must be function")
	if p12._active ~= true then
		local v15 = v_u_2
		return setmetatable({
			["Connected"] = false,
			["_node"] = nil
		}, v15)
	end
	local v16 = p12._head
	local v17 = {
		["_signal"] = p12,
		["_connection"] = nil,
		["_handler"] = p13,
		["_next"] = v16,
		["_prev"] = nil
	}
	if v16 ~= nil then
		v16._prev = v17
	end
	p12._head = v17
	local v18 = v_u_2
	local v19 = setmetatable({
		["Connected"] = true,
		["_node"] = v17
	}, v18)
	v17._connection = v19
	return v19
end
function v_u_1.Once(p20, p_u_21)
	local v22 = typeof(p_u_21) == "function"
	assert(v22, "Must be function")
	local v_u_23 = nil
	v_u_23 = p20:Connect(function(...)
		-- upvalues: (ref) v_u_23, (copy) p_u_21
		v_u_23:Disconnect()
		p_u_21(...)
	end)
	return v_u_23
end
v_u_1.ConnectOnce = v_u_1.Once
function v_u_1.Wait(p24)
	local v_u_25 = coroutine.running()
	local v_u_26 = nil
	v_u_26 = p24:Connect(function(...)
		-- upvalues: (ref) v_u_26, (ref) v_u_25
		v_u_26:Disconnect()
		task.spawn(v_u_25, ...)
	end)
	return coroutine.yield()
end
function v_u_1.Fire(p27, ...)
	-- upvalues: (ref) v_u_3, (copy) v_u_7
	local v28 = p27._head
	while v28 ~= nil do
		if v28._connection ~= nil then
			if v_u_3 == nil then
				task.spawn(v_u_7)
			end
			task.spawn(v_u_3, v28._handler, ...)
		end
		v28 = v28._next
	end
end
function v_u_1.DisconnectAll(p29)
	local v30 = p29._head
	while v30 ~= nil do
		local v31 = v30._connection
		if v31 ~= nil then
			v31.Connected = false
			v31._node = nil
			v30._connection = nil
		end
		v30 = v30._next
	end
	p29._head = nil
end
function v_u_1.Destroy(p32)
	if p32._active == true then
		p32:DisconnectAll()
		p32._active = false
	end
end
function v_u_2.Disconnect(p33)
	if p33.Connected == true then
		p33.Connected = false
		local v34 = p33._node
		local v35 = v34._prev
		local v36 = v34._next
		if v36 ~= nil then
			v36._prev = v35
		end
		if v35 == nil then
			v34._signal._head = v36
		else
			v35._next = v36
		end
		v34._connection = nil
		p33._node = nil
	end
end
v_u_2.Destroy = v_u_2.Disconnect
return v_u_1
