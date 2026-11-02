-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v_u_1 = game:GetService("RunService")
local v_u_2 = newproxy()
local v_u_3 = newproxy()
local v_u_4 = table.freeze({
	"Destroy",
	"Disconnect",
	"destroy",
	"disconnect"
})
local function v_u_10(p5, p6)
	-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_4
	local v7 = typeof(p5)
	if v7 == "function" then
		return v_u_2
	end
	if v7 == "thread" then
		return v_u_3
	end
	if p6 then
		return p6
	end
	if v7 == "Instance" then
		return "Destroy"
	end
	if v7 == "RBXScriptConnection" then
		return "Disconnect"
	end
	if v7 == "table" then
		for _, v8 in v_u_4 do
			local v9 = p5[v8]
			if typeof(v9) == "function" then
				return v8
			end
		end
	end
	error(("failed to get cleanup function for object %*: %*"):format(v7, p5), 3)
end
local v_u_11 = {}
v_u_11.__index = v_u_11
function v_u_11.new()
	-- upvalues: (copy) v_u_11
	local v12 = v_u_11
	local v13 = setmetatable({}, v12)
	v13._objects = {}
	v13._cleaning = false
	return v13
end
function v_u_11.Add(p14, p15, p16)
	-- upvalues: (copy) v_u_10
	if p14._cleaning then
		error("cannot call trove:Add() while cleaning", 2)
	end
	local v17 = v_u_10(p15, p16)
	local v18 = p14._objects
	table.insert(v18, { p15, v17 })
	return p15
end
function v_u_11.Clone(p19, p20)
	if p19._cleaning then
		error("cannot call trove:Clone() while cleaning", 2)
	end
	return p19:Add(p20:Clone())
end
function v_u_11.Construct(p21, p22, ...)
	if p21._cleaning then
		error("Cannot call trove:Construct() while cleaning", 2)
	end
	local v23 = nil
	local v24 = type(p22)
	if v24 == "table" then
		v23 = p22.new(...)
	elseif v24 == "function" then
		v23 = p22(...)
	end
	return p21:Add(v23)
end
function v_u_11.Connect(p25, p26, p27)
	if p25._cleaning then
		error("Cannot call trove:Connect() while cleaning", 2)
	end
	return p25:Add(p26:Connect(p27))
end
function v_u_11.BindToRenderStep(p28, p_u_29, p30, p31)
	-- upvalues: (copy) v_u_1
	if p28._cleaning then
		error("cannot call trove:BindToRenderStep() while cleaning", 2)
	end
	v_u_1:BindToRenderStep(p_u_29, p30, p31)
	p28:Add(function()
		-- upvalues: (ref) v_u_1, (copy) p_u_29
		v_u_1:UnbindFromRenderStep(p_u_29)
	end)
end
function v_u_11.AddPromise(p_u_32, p_u_33)
	if p_u_32._cleaning then
		error("cannot call trove:AddPromise() while cleaning", 2)
	end
	if typeof(p_u_33) == "table" then
		local v34 = p_u_33.getStatus
		if typeof(v34) == "function" then
			local v35 = p_u_33.finally
			if typeof(v35) == "function" then
				local v36 = p_u_33.cancel
				if typeof(v36) == "function" then
					if p_u_33:getStatus() == "Started" then
						p_u_33:finally(function()
							-- upvalues: (copy) p_u_32, (copy) p_u_33
							if not p_u_32._cleaning then
								p_u_32:_findAndRemoveFromObjects(p_u_33, false)
							end
						end)
						p_u_32:Add(p_u_33, "cancel")
					end
					return p_u_33
				end
			end
		end
	end
	error("did not receive a promise as an argument", 3)
end
function v_u_11.Remove(p37, p38)
	if p37._cleaning then
		error("cannot call trove:Remove() while cleaning", 2)
	end
	return p37:_findAndRemoveFromObjects(p38, true)
end
function v_u_11.Pop(p39, p40)
	if p39._cleaning then
		error("cannot call trove:Pop() while cleaning", 2)
	end
	return p39:_findAndRemoveFromObjects(p40, false)
end
function v_u_11.Extend(p41)
	-- upvalues: (copy) v_u_11
	if p41._cleaning then
		error("cannot call trove:Extend() while cleaning", 2)
	end
	return p41:Construct(v_u_11)
end
function v_u_11.Clean(p42)
	if not p42._cleaning then
		p42._cleaning = true
		for _, v43 in p42._objects do
			p42:_cleanupObject(v43[1], v43[2])
		end
		table.clear(p42._objects)
		p42._cleaning = false
	end
end
function v_u_11.WrapClean(p_u_44)
	return function()
		-- upvalues: (copy) p_u_44
		p_u_44:Clean()
	end
end
function v_u_11._findAndRemoveFromObjects(p45, p46, p47)
	local v48 = p45._objects
	for v49, v50 in v48 do
		if v50[1] == p46 then
			local v51 = #v48
			v48[v49] = v48[v51]
			v48[v51] = nil
			if p47 then
				p45:_cleanupObject(v50[1], v50[2])
			end
			return true
		end
	end
	return false
end
function v_u_11._cleanupObject(_, p52, p53)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	if p53 == v_u_2 then
		task.spawn(p52)
		return
	elseif p53 == v_u_3 then
		pcall(task.cancel, p52)
	else
		p52[p53](p52)
	end
end
function v_u_11.AttachToInstance(p_u_54, p55)
	if p_u_54._cleaning then
		error("cannot call trove:AttachToInstance() while cleaning", 2)
	elseif not p55:IsDescendantOf(game) then
		error("instance is not a descendant of the game hierarchy", 2)
	end
	return p_u_54:Connect(p55.Destroying, function()
		-- upvalues: (copy) p_u_54
		p_u_54:Destroy()
	end)
end
function v_u_11.Destroy(p56)
	p56:Clean()
end
return {
	["new"] = v_u_11.new
}