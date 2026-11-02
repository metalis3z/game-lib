

local u1 = game:GetService("RunService").Heartbeat
local u2 = newproxy(true)
getmetatable(u2).__tostring = function()
	return "IndicesReference"
end
local u3 = newproxy(true)
getmetatable(u3).__tostring = function()
	return "LinkToInstanceIndex"
end
local u4 = {
	["IGNORE_MEMORY_DEBUG"] = true,
	["ClassName"] = "Janitor",
	["__index"] = {
		["CurrentlyCleaning"] = true,
		[u2] = nil
	}
}
local u5 = {
	["function"] = true,
	["Promise"] = "cancel",
	["RBXScriptConnection"] = "Disconnect"
}
function u4.new() 

	local v6 = {
		["CurrentlyCleaning"] = false,
		[u2] = nil
	}
	local v7 = u4
	return setmetatable(v6, v7)
end
function u4.Is(p8) 

	local v9
	if type(p8) == "table" then
		v9 = getmetatable(p8) == u4
	else
		v9 = false
	end
	return v9
end
u4.is = u4.Is
function u4.__index.Add(p10, p11, p12, p13) 

	if p13 then
		p10:Remove(p13)
		local v14 = p10[u2]
		if not v14 then
			v14 = {}
			p10[u2] = v14
		end
		v14[p13] = p11
	end
	local v15 = typeof(p11)
	local v16 = p12 or (u5[v15 == "table" and string.match(tostring(p11), "Promise") and "Promise" or v15] or "Destroy")
	if type(p11) ~= "function" and not p11[v16] then
		warn(string.format("Object %s doesn\'t have method %s, are you sure you want to add it? Traceback: %s", tostring(p11), tostring(v16), debug.traceback(nil, 2)))
	end
	p10[p11] = { v16, (debug.traceback("")) }
	return p11
end
u4.__index.Give = u4.__index.Add
function u4.__index.AddPromise(p17, u18) 
	local v19 = false
	if not v19 then
		return u18
	end
	if not v19.is(u18) then
		error(string.format("Invalid argument #1 to \'Janitor:AddPromise\' (Promise expected, got %s (%s))", typeof(u18), (tostring(u18))))
	end
	if u18:getStatus() ~= v19.Status.Started then
		return u18
	end
	local v20 = newproxy(false)
	local v23 = p17:Add(v19.new(function(p21, _, p22)

		if not p22(function()

			u18:cancel()
		end) then
			p21(u18)
		end
	end), "cancel", v20)
	v23:finallyCall(p17.Remove, p17, v20)
	return v23
end
u4.__index.GivePromise = u4.__index.AddPromise
function u4.__index.AddObject(p24, p25) 
	local v26 = newproxy(false)
	local v27 = false
	if not (v27 and v27.is(p25)) then
		return p24:Add(p25, false, v26), v26
	end
	if p25:getStatus() ~= v27.Status.Started then
		return p25
	end
	local v28 = p24:Add(v27.resolve(p25), "cancel", v26)
	v28:finallyCall(p24.Remove, p24, v26)
	return v28, v26
end
u4.__index.GiveObject = u4.__index.AddObject
function u4.__index.Remove(p29, p30) 

	local v31 = p29[u2]
	local v32 = v31 and v31[p30]
	if v32 then
		local v33 = p29[v32]
		if v33 then
			v33 = v33[1]
		end
		if v33 then
			if v33 == true then
				v32()
			else
				local v34 = v32[v33]
				if v34 then
					v34(v32)
				end
			end
			p29[v32] = nil
		end
		v31[p30] = nil
	end
	return p29
end
function u4.__index.Get(p35, p36) 

	local v37 = p35[u2]
	if v37 then
		return v37[p36]
	else
		return nil
	end
end
function u4.__index.Cleanup(p38) 

	if not p38.CurrentlyCleaning then
		p38.CurrentlyCleaning = nil
		for v39, v40 in next, p38 do
			if v39 ~= u2 then
				local v41 = type(v39)
				if v41 == "string" or v41 == "number" then
					p38[v39] = nil
				else
					local v42 = v40[1]
					local v43 = v40[2]
					if v42 == true then
						local v44, v45 = pcall(v39)
						if not v44 then
							local v46 = debug.traceback("", 3)
							warn("-------- Janitor Error 
						end
					else
						local v47 = v39[v42]
						if v47 then
							local v48, v49 = pcall(v47, v39)
							local v50
							if typeof(v39) == "Instance" then
								v50 = v47 == "Destroy"
							else
								v50 = false
							end
							if not (v48 or v50) then
								local v51 = debug.traceback("", 3)
								warn("-------- Janitor Error 
							end
						end
					end
					p38[v39] = nil
				end
			end
		end
		local v52 = p38[u2]
		if v52 then
			for v53 in next, v52 do
				v52[v53] = nil
			end
			p38[u2] = {}
		end
		p38.CurrentlyCleaning = false
	end
end
u4.__index.Clean = u4.__index.Cleanup
function u4.__index.Destroy(p54) 
	p54:Cleanup()
end
u4.__call = u4.__index.Cleanup
local u55 = {
	["Connected"] = true
}
u55.__index = u55
function u55.Disconnect(p56) 
	if p56.Connected then
		p56.Connected = false
		p56.Connection:Disconnect()
	end
end
function u55.__tostring(p57) 
	local v58 = p57.Connected
	return "Disconnect<" .. tostring(v58) .. ">"
end
function u4.__index.LinkToInstance(u59, p60, p61) 

	local u62 = nil
	local v63 = p61 and newproxy(false) or u3
	local u64 = p60.Parent == nil
	local v65 = u55
	local u66 = setmetatable({}, v65)
	local function v68(_, p67) 

		u64 = u66.Connected and p67 == nil
		if u64 then
			coroutine.wrap(function()

				u1:Wait()
				if u66.Connected then
					if u62.Connected then
						while u64 and (u62.Connected and u66.Connected) do
							u1:Wait()
						end
						if u66.Connected and u64 then
							u59:Cleanup()
						end
					else
						u59:Cleanup()
					end
				else
					return
				end
			end)()
		end
	end
	local u69 = p60.AncestryChanged:Connect(v68)
	u66.Connection = u69
	if u64 then
		local v70 = p60.Parent
		if u66.Connected then
			if v70 == nil then
				u64 = true
			else
				u64 = false
			end
			if u64 then
				coroutine.wrap(function()

					u1:Wait()
					if u66.Connected then
						if u69.Connected then
							while u64 and (u69.Connected and u66.Connected) do
								u1:Wait()
							end
							if u66.Connected and u64 then
								u59:Cleanup()
							end
						else
							u59:Cleanup()
						end
					else
						return
					end
				end)()
			end
		end
	end
	return u59:Add(u66, "Disconnect", v63)
end
function u4.__index.LinkToInstances(p71, ...) 

	local v72 = u4.new()
	for _, v73 in ipairs({ ... }) do
		v72:Add(p71:LinkToInstance(v73, true), "Disconnect")
	end
	return v72
end
for v74, v75 in next, u4.__index do
	local v76 = string.lower(v74)
	local v77 = string.sub(v76, 1, 1) .. string.sub(v74, 2)
	u4.__index[v77] = v75
end
return u4