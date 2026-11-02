

local u1 = nil
local function u4(p2, ...) 

	local v3 = u1
	u1 = nil
	p2(...)
	u1 = v3
end
local function u5() 

	while true do
		u4(coroutine.yield())
	end
end
local u6 = {}
u6.__index = u6
function u6.new(p7, p8) 

	local v9 = u6
	return setmetatable({
		["_connected"] = true,
		["_next"] = false,
		["_signal"] = p7,
		["_fn"] = p8
	}, v9)
end
function u6.Disconnect(p10) 
	p10._connected = false
	if p10._signal._handlerListHead == p10 then
		p10._signal._handlerListHead = p10._next
	else
		local v11 = p10._signal._handlerListHead
		while v11 and v11._next ~= p10 do
			v11 = v11._next
		end
		if v11 then
			v11._next = p10._next
		end
	end
end
u6.Destroy = u6.Disconnect
setmetatable(u6, {
	["__index"] = function(_, p12) 
		error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p12))), 2)
	end,
	["__newindex"] = function(_, p13, _) 
		error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p13))), 2)
	end
})
local u14 = {}
u14.__index = u14
function u14.new() 

	local v15 = u14
	return setmetatable({
		["_handlerListHead"] = false
	}, v15)
end
function u14.Connect(p16, p17) 

	local v18 = u6.new(p16, p17)
	if not p16._handlerListHead then
		p16._handlerListHead = v18
		return v18
	end
	v18._next = p16._handlerListHead
	p16._handlerListHead = v18
	return v18
end
function u14.DisconnectAll(p19) 
	p19._handlerListHead = false
end
u14.Destroy = u14.DisconnectAll
function u14.Fire(p20, ...) 

	local v21 = p20._handlerListHead
	while v21 do
		if v21._connected then
			if not u1 then
				u1 = coroutine.create(u5)
				coroutine.resume(u1)
			end
			task.spawn(u1, v21._fn, ...)
		end
		v21 = v21._next
	end
end
function u14.Wait(p22) 
	local u23 = coroutine.running()
	local u24 = nil
	u24 = p22:Connect(function(...)

		u24:Disconnect()
		task.spawn(u23, ...)
	end)
	return coroutine.yield()
end
function u14.Once(p25, u26) 
	local u27 = nil
	u27 = p25:Connect(function(...)

		if u27._connected then
			u27:Disconnect()
		end
		u26(...)
	end)
	return u27
end
setmetatable(u14, {
	["__index"] = function(_, p28) 
		error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p28))), 2)
	end,
	["__newindex"] = function(_, p29, _) 
		error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p29))), 2)
	end
})
return u14