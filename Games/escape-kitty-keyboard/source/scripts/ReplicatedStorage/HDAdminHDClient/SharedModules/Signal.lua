

local u1 = nil
local function u3(p2, _, ...) 
	p2(...)
end
local function u7(p4, p5, ...) 

	local v6 = u1
	u1 = nil
	u3(p4, p5, ...)
	u1 = v6
end
local function u8(...) 

	u7(...)
	while true do
		u7(coroutine.yield())
	end
end
local u9 = {}
u9.__index = u9
function u9.new(p10, p11) 

	local v12 = u9
	return setmetatable({
		["_connected"] = true,
		["_next"] = false,
		["_signal"] = p10,
		["_fn"] = p11
	}, v12)
end
function u9.Disconnect(p13) 
	if p13._connected then
		p13._connected = false
		if p13._signal._handlerListHead == p13 then
			p13._signal._handlerListHead = p13._next
		else
			local v14 = p13._signal._handlerListHead
			while v14 and v14._next ~= p13 do
				v14 = v14._next
			end
			if v14 then
				v14._next = p13._next
			end
		end
	else
		return
	end
end
u9.Destroy = u9.Disconnect
setmetatable(u9, {
	["__index"] = function(_, p15) 
		error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p15))), 2)
	end,
	["__newindex"] = function(_, p16, _) 
		error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p16))), 2)
	end
})
local u17 = {}
u17.__index = u17
function u17.new() 

	local v18 = u17
	return setmetatable({
		["_handlerListHead"] = false
	}, v18)
end
function u17.Connect(p19, p20) 

	local v21 = u9.new(p19, p20)
	if not p19._handlerListHead then
		p19._handlerListHead = v21
		return v21
	end
	v21._next = p19._handlerListHead
	p19._handlerListHead = v21
	return v21
end
function u17.ConnectOnce(p22, u23) 
	local u24 = nil
	u24 = p22:Connect(function(...)

		u24:Disconnect()
		u23(...)
	end)
	return u24
end
u17.Once = u17.ConnectOnce
function u17.DisconnectAll(p25) 
	p25._handlerListHead = false
end
u17.Destroy = u17.DisconnectAll
u17.destroy = u17.DisconnectAll
function u17._FireBehaviour(p26, u27, ...) 

	local u28 = table.concat({ debug.info(3, "sl") }, " ")
	local u29 = p26._handlerListHead
	u27 = u27
	if u27 then
		local u30 = u17.new()
	end
	local u31 = 0
	local u32 = 0
	if u27 then
		local v33 = u29
		while u29 do
			if u29._connected then
				u31 = u31 + 1
			end
			u29 = u29._next
		end
		u29 = v33
	end
	while u29 do
		if u29._connected then
			if not u1 then
				u1 = coroutine.create(u8)
			end
			local function v34(...)

				u3(u29._fn, u28, ...)
				if u27 then
					u32 = u32 + 1
					if u32 == u31 then
						u30:Fire()
						u30:Destroy()
						u30 = false
					end
				end
			end
			task.spawn(u1, v34, u28, ...)
		end
		local v35 = u29._next
		u29 = v35
	end
	if u27 then
		return u30
	end
end
function u17.Fire(p36, ...) 
	p36:_FireBehaviour(false, ...)
end
function u17.SpecialFire(p37, ...) 
	return p37:_FireBehaviour(true, ...)
end
function u17.Wait(p38) 
	local u39 = coroutine.running()
	local u40 = nil
	u40 = p38:Connect(function(...)

		u40:Disconnect()
		task.spawn(u39, ...)
	end)
	return coroutine.yield()
end
return u17