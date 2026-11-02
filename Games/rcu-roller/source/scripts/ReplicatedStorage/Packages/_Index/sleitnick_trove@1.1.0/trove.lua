-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:23
-- Luau version 6, Types version 3
-- Time taken: 0.004097 seconds

local newproxy_result1_upvr = newproxy()
local newproxy_result1_upvr_2 = newproxy()
local tbl_upvr = {"Destroy", "Disconnect", "destroy", "disconnect"}
local function GetObjectCleanupFunction_upvr(arg1, arg2) -- Line 11, Named "GetObjectCleanupFunction"
	--[[ Upvalues[3]:
		[1]: newproxy_result1_upvr (readonly)
		[2]: newproxy_result1_upvr_2 (readonly)
		[3]: tbl_upvr (readonly)
	]]
	local typeof_result1 = typeof(arg1)
	if typeof_result1 == "function" then
		return newproxy_result1_upvr
	end
	if typeof_result1 == "thread" then
		return newproxy_result1_upvr_2
	end
	if arg2 then
		return arg2
	end
	if typeof_result1 == "Instance" then
		return "Destroy"
	end
	if typeof_result1 == "RBXScriptConnection" then
		return "Disconnect"
	end
	if typeof_result1 == "table" then
		for _, v in tbl_upvr do
			if typeof(arg1[v]) == "function" then
				return v
			end
		end
	end
	error("Failed to get cleanup function for object "..typeof_result1..": "..tostring(arg1), 3)
end
local function _(arg1) -- Line 35, Named "AssertPromiseLike"
	if typeof(arg1) ~= "table" or typeof(arg1.getStatus) ~= "function" or typeof(arg1.finally) ~= "function" or typeof(arg1.cancel) ~= "function" then
		error("Did not receive a Promise as an argument", 3)
	end
end
local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new() -- Line 58
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	local setmetatable_result1 = setmetatable({}, module_upvr)
	setmetatable_result1._objects = {}
	setmetatable_result1._cleaning = false
	return setmetatable_result1
end
function module_upvr.Extend(arg1) -- Line 84
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	if arg1._cleaning then
		error("Cannot call trove:Extend() while cleaning", 2)
	end
	return arg1:Construct(module_upvr)
end
function module_upvr.Clone(arg1, arg2) -- Line 95
	if arg1._cleaning then
		error("Cannot call trove:Clone() while cleaning", 2)
	end
	return arg1:Add(arg2:Clone())
end
function module_upvr.Construct(arg1, arg2, ...) -- Line 135
	if arg1._cleaning then
		error("Cannot call trove:Construct() while cleaning", 2)
	end
	local var9
	local type_result1 = type(arg2)
	if type_result1 == "table" then
		var9 = arg2.new(...)
	elseif type_result1 == "function" then
		var9 = arg2(...)
	end
	return arg1:Add(var9)
end
function module_upvr.Connect(arg1, arg2, arg3) -- Line 164
	if arg1._cleaning then
		error("Cannot call trove:Connect() while cleaning", 2)
	end
	return arg1:Add(arg2:Connect(arg3))
end
local RunService_upvr = game:GetService("RunService")
function module_upvr.BindToRenderStep(arg1, arg2, arg3, arg4) -- Line 184
	--[[ Upvalues[1]:
		[1]: RunService_upvr (readonly)
	]]
	if arg1._cleaning then
		error("Cannot call trove:BindToRenderStep() while cleaning", 2)
	end
	RunService_upvr:BindToRenderStep(arg2, arg3, arg4)
	arg1:Add(function() -- Line 189
		--[[ Upvalues[2]:
			[1]: RunService_upvr (copied, readonly)
			[2]: arg2 (readonly)
		]]
		RunService_upvr:UnbindFromRenderStep(arg2)
	end)
end
function module_upvr.AddPromise(arg1, arg2) -- Line 217
	if arg1._cleaning then
		error("Cannot call trove:AddPromise() while cleaning", 2)
	end
	if typeof(arg2) ~= "table" or typeof(arg2.getStatus) ~= "function" or typeof(arg2.finally) ~= "function" or typeof(arg2.cancel) ~= "function" then
		error("Did not receive a Promise as an argument", 3)
	end
	if arg2:getStatus() == "Started" then
		arg2:finally(function() -- Line 223
			--[[ Upvalues[2]:
				[1]: arg1 (readonly)
				[2]: arg2 (readonly)
			]]
			if arg1._cleaning then
			else
				arg1:_findAndRemoveFromObjects(arg2, false)
			end
		end)
		arg1:Add(arg2, "cancel")
	end
	return arg2
end
function module_upvr.Add(arg1, arg2, arg3) -- Line 282
	--[[ Upvalues[1]:
		[1]: GetObjectCleanupFunction_upvr (readonly)
	]]
	if arg1._cleaning then
		error("Cannot call trove:Add() while cleaning", 2)
	end
	local tbl = {}
	tbl[1] = arg2
	tbl[2] = GetObjectCleanupFunction_upvr(arg2, arg3)
	table.insert(arg1._objects, tbl)
	return arg2
end
function module_upvr.Remove(arg1, arg2) -- Line 301
	if arg1._cleaning then
		error("Cannot call trove:Remove() while cleaning", 2)
	end
	return arg1:_findAndRemoveFromObjects(arg2, true)
end
function module_upvr.Clean(arg1) -- Line 314
	if arg1._cleaning then
	else
		arg1._cleaning = true
		for _, v_3 in arg1._objects do
			arg1:_cleanupObject(v_3[1], v_3[2])
		end
		table.clear(arg1._objects)
		arg1._cleaning = false
	end
end
function module_upvr._findAndRemoveFromObjects(arg1, arg2, arg3) -- Line 326
	local _objects = arg1._objects
	for i_2, v_2 in ipairs(_objects) do
		if v_2[1] == arg2 then
			local len = #_objects
			_objects[i_2] = _objects[len]
			_objects[len] = nil
			if arg3 then
				arg1:_cleanupObject(v_2[1], v_2[2])
			end
			return true
		end
	end
	return false
end
function module_upvr._cleanupObject(arg1, arg2, arg3) -- Line 342
	--[[ Upvalues[2]:
		[1]: newproxy_result1_upvr (readonly)
		[2]: newproxy_result1_upvr_2 (readonly)
	]]
	if arg3 == newproxy_result1_upvr then
		arg2()
	else
		if arg3 == newproxy_result1_upvr_2 then
			pcall(task.cancel, arg2)
			return
		end
		arg2[arg3](arg2)
	end
end
function module_upvr.AttachToInstance(arg1, arg2) -- Line 365
	if arg1._cleaning then
		error("Cannot call trove:AttachToInstance() while cleaning", 2)
	elseif not arg2:IsDescendantOf(game) then
		error("Instance is not a descendant of the game hierarchy", 2)
	end
	return arg1:Connect(arg2.Destroying, function() -- Line 371
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:Destroy()
	end)
end
function module_upvr.Destroy(arg1) -- Line 379
	arg1:Clean()
end
return module_upvr