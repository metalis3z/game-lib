-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:16:21
-- Luau version 6, Types version 3
-- Time taken: 0.003412 seconds

local newproxy_result1_upvr_2 = newproxy()
local newproxy_result1_upvr = newproxy()
local function GetObjectCleanupFunction_upvr(arg1, arg2) -- Line 10, Named "GetObjectCleanupFunction"
	--[[ Upvalues[2]:
		[1]: newproxy_result1_upvr_2 (readonly)
		[2]: newproxy_result1_upvr (readonly)
	]]
	local typeof_result1 = typeof(arg1)
	if typeof_result1 == "function" then
		return newproxy_result1_upvr_2
	end
	if typeof_result1 == "thread" then
		return newproxy_result1_upvr
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
		if typeof(arg1.Destroy) == "function" then
			return "Destroy"
		end
		if typeof(arg1.Disconnect) == "function" then
			return "Disconnect"
		end
	end
	error("Failed to get cleanup function for object "..typeof_result1..": "..tostring(arg1), 3)
end
local function _(arg1) -- Line 34, Named "AssertPromiseLike"
	if type(arg1) ~= "table" or type(arg1.getStatus) ~= "function" or type(arg1.finally) ~= "function" or type(arg1.cancel) ~= "function" then
		error("Did not receive a Promise as an argument", 3)
	end
end
local module_upvr = {}
module_upvr.__index = module_upvr
function module_upvr.new() -- Line 57
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	local setmetatable_result1 = setmetatable({}, module_upvr)
	setmetatable_result1._objects = {}
	return setmetatable_result1
end
function module_upvr.Extend(arg1) -- Line 82
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	return arg1:Construct(module_upvr)
end
function module_upvr.Clone(arg1, arg2) -- Line 90
	return arg1:Add(arg2:Clone())
end
function module_upvr.Construct(arg1, arg2, ...) -- Line 127
	local var6
	local type_result1 = type(arg2)
	if type_result1 == "table" then
		var6 = arg2.new(...)
	elseif type_result1 == "function" then
		var6 = arg2(...)
	end
	return arg1:Add(var6)
end
function module_upvr.Connect(arg1, arg2, arg3) -- Line 153
	return arg1:Add(arg2:Connect(arg3))
end
local RunService_upvr = game:GetService("RunService")
function module_upvr.BindToRenderStep(arg1, arg2, arg3, arg4) -- Line 170
	--[[ Upvalues[1]:
		[1]: RunService_upvr (readonly)
	]]
	RunService_upvr:BindToRenderStep(arg2, arg3, arg4)
	arg1:Add(function() -- Line 172
		--[[ Upvalues[2]:
			[1]: RunService_upvr (copied, readonly)
			[2]: arg2 (readonly)
		]]
		RunService_upvr:UnbindFromRenderStep(arg2)
	end)
end
function module_upvr.AddPromise(arg1, arg2) -- Line 200
	if type(arg2) ~= "table" or type(arg2.getStatus) ~= "function" or type(arg2.finally) ~= "function" or type(arg2.cancel) ~= "function" then
		error("Did not receive a Promise as an argument", 3)
	end
	if arg2:getStatus() == "Started" then
		arg2:finally(function() -- Line 203
			--[[ Upvalues[2]:
				[1]: arg1 (readonly)
				[2]: arg2 (readonly)
			]]
			return arg1:_findAndRemoveFromObjects(arg2, false)
		end)
		arg1:Add(arg2, "cancel")
	end
	return arg2
end
function module_upvr.Add(arg1, arg2, arg3) -- Line 259
	--[[ Upvalues[1]:
		[1]: GetObjectCleanupFunction_upvr (readonly)
	]]
	local tbl = {}
	tbl[1] = arg2
	tbl[2] = GetObjectCleanupFunction_upvr(arg2, arg3)
	table.insert(arg1._objects, tbl)
	return arg2
end
function module_upvr.Remove(arg1, arg2) -- Line 275
	return arg1:_findAndRemoveFromObjects(arg2, true)
end
function module_upvr.Clean(arg1) -- Line 284
	for _, v in ipairs(arg1._objects) do
		arg1:_cleanupObject(v[1], v[2])
	end
	table.clear(arg1._objects)
end
function module_upvr._findAndRemoveFromObjects(arg1, arg2, arg3) -- Line 291
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
function module_upvr._cleanupObject(arg1, arg2, arg3) -- Line 307
	--[[ Upvalues[2]:
		[1]: newproxy_result1_upvr_2 (readonly)
		[2]: newproxy_result1_upvr (readonly)
	]]
	if arg3 == newproxy_result1_upvr_2 then
		arg2()
	else
		if arg3 == newproxy_result1_upvr then
			coroutine.close(arg2)
			return
		end
		arg2[arg3](arg2)
	end
end
function module_upvr.AttachToInstance(arg1, arg2) -- Line 330
	assert(arg2:IsDescendantOf(game), "Instance is not a descendant of the game hierarchy")
	return arg1:Connect(arg2.Destroying, function() -- Line 332
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:Destroy()
	end)
end
function module_upvr.Destroy(arg1) -- Line 340
	arg1:Clean()
end
return module_upvr