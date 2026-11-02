-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:21:13
-- Luau version 6, Types version 3
-- Time taken: 0.007783 seconds

local RunService_upvr = game:GetService("RunService")
local function _() -- Line 25, Named "getPromiseReference"
	--[[ Upvalues[1]:
		[1]: RunService_upvr (readonly)
	]]
	if RunService_upvr:IsRunning() then
		return require(game:GetService("ReplicatedStorage").Framework).modules.Promise
	end
end
local newproxy_result1_2_upvr = newproxy(true)
getmetatable(newproxy_result1_2_upvr).__tostring = function() -- Line 33
	return "IndicesReference"
end
local newproxy_result1_3_upvr = newproxy(true)
getmetatable(newproxy_result1_3_upvr).__tostring = function() -- Line 38
	return "LinkToInstanceIndex"
end
local module_upvr = {
	IGNORE_MEMORY_DEBUG = true;
	ClassName = "Janitor";
	__index = {
		CurrentlyCleaning = true;
		[newproxy_result1_2_upvr] = nil;
	};
}
local tbl_3_upvr = {
	["function"] = true;
	Promise = "cancel";
	RBXScriptConnection = "Disconnect";
}
function module_upvr.new() -- Line 64
	--[[ Upvalues[2]:
		[1]: newproxy_result1_2_upvr (readonly)
		[2]: module_upvr (readonly)
	]]
	return setmetatable({
		CurrentlyCleaning = false;
		[newproxy_result1_2_upvr] = nil;
	}, module_upvr)
end
function module_upvr.Is(arg1) -- Line 76
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	local var14 = false
	if type(arg1) == "table" then
		if getmetatable(arg1) ~= module_upvr then
			var14 = false
		else
			var14 = true
		end
	end
	return var14
end
module_upvr.is = module_upvr.Is
module_upvr.__index.Add = function(arg1, arg2, arg3, arg4) -- Line 89, Named "Add"
	--[[ Upvalues[2]:
		[1]: newproxy_result1_2_upvr (readonly)
		[2]: tbl_3_upvr (readonly)
	]]
	if arg4 then
		arg1:Remove(arg4)
		local var20 = arg1[newproxy_result1_2_upvr]
		if not var20 then
			var20 = {}
			arg1[newproxy_result1_2_upvr] = var20
		end
		var20[arg4] = arg2
	end
	local var21
	if var21 == "table" and string.match(tostring(arg2), "Promise") then
		var21 = "Promise"
	end
	local var22 = arg3
	if not var22 then
		var22 = tbl_3_upvr[var21]
		if not var22 then
			var22 = "Destroy"
		end
	end
	local var23 = var22
	if type(arg2) ~= "function" then
		if not arg2[var23] then
			warn(string.format("Object %s doesn't have method %s, are you sure you want to add it? Traceback: %s", tostring(arg2), tostring(var23), debug.traceback(nil, 2)))
		end
	end
	arg1[arg2] = {var23, debug.traceback("")}
	return arg2
end
module_upvr.__index.Give = module_upvr.__index.Add
module_upvr.__index.AddPromise = function(arg1, arg2) -- Line 126, Named "AddPromise"
	--[[ Upvalues[1]:
		[1]: RunService_upvr (readonly)
	]]
	local var25
	if RunService_upvr:IsRunning() then
		var25 = require(game:GetService("ReplicatedStorage").Framework).modules.Promise
	else
		var25 = nil
	end
	if var25 then
		if not var25.is(arg2) then
			error(string.format("Invalid argument #1 to 'Janitor:AddPromise' (Promise expected, got %s (%s))", typeof(arg2), tostring(arg2)))
		end
		if arg2:getStatus() == var25.Status.Started then
			local newproxy_result1 = newproxy(false)
			local any_Add_result1 = arg1:Add(var25.new(function(arg1_2, arg2_2, arg3) -- Line 134
				--[[ Upvalues[1]:
					[1]: arg2 (readonly)
				]]
				if arg3(function() -- Line 135
					--[[ Upvalues[1]:
						[1]: arg2 (copied, readonly)
					]]
					arg2:cancel()
				end) then
				else
					arg1_2(arg2)
				end
			end), "cancel", newproxy_result1)
			any_Add_result1:finallyCall(arg1.Remove, arg1, newproxy_result1)
			return any_Add_result1
		end
		return arg2
	end
	return arg2
end
module_upvr.__index.GivePromise = module_upvr.__index.AddPromise
module_upvr.__index.AddObject = function(arg1, arg2) -- Line 156, Named "AddObject"
	--[[ Upvalues[1]:
		[1]: RunService_upvr (readonly)
	]]
	local newproxy_result1_4 = newproxy(false)
	local var31
	if RunService_upvr:IsRunning() then
		var31 = require(game:GetService("ReplicatedStorage").Framework).modules.Promise
	else
		var31 = nil
	end
	if var31 and var31.is(arg2) then
		if arg2:getStatus() == var31.Status.Started then
			local any_Add_result1_2 = arg1:Add(var31.resolve(arg2), "cancel", newproxy_result1_4)
			any_Add_result1_2:finallyCall(arg1.Remove, arg1, newproxy_result1_4)
			return any_Add_result1_2, newproxy_result1_4
		end
		return arg2
	end
	return arg1:Add(arg2, false, newproxy_result1_4), newproxy_result1_4
end
module_upvr.__index.GiveObject = module_upvr.__index.AddObject
module_upvr.__index.Remove = function(arg1, arg2) -- Line 179, Named "Remove"
	--[[ Upvalues[1]:
		[1]: newproxy_result1_2_upvr (readonly)
	]]
	local var38 = arg1[newproxy_result1_2_upvr]
	if var38 then
		local var39 = var38[arg2]
		local var40
		if var39 then
			local var41 = arg1[var39]
			var40 = var41
			if var40 then
				var40 = var41[1]
			end
			if var40 then
				if var40 == true then
					var39()
				else
					local var42 = var39[var40]
					if var42 then
						var42(var39)
					end
				end
				arg1[var39] = nil
			end
			var38[arg2] = nil
		end
	end
	return arg1
end
module_upvr.__index.Get = function(arg1, arg2) -- Line 213, Named "Get"
	--[[ Upvalues[1]:
		[1]: newproxy_result1_2_upvr (readonly)
	]]
	local var43 = arg1[newproxy_result1_2_upvr]
	if var43 then
		return var43[arg2]
	end
end
module_upvr.__index.Cleanup = function(arg1) -- Line 224, Named "Cleanup"
	--[[ Upvalues[1]:
		[1]: newproxy_result1_2_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [105] 86. Error Block 37 start (CF ANALYSIS FAILED)
	local var46 = arg1[newproxy_result1_2_upvr]
	if var46 then
		for i in next, var46 do
			var46[i] = nil
			local _
		end
		arg1[newproxy_result1_2_upvr] = {}
	end
	arg1.CurrentlyCleaning = false
	-- KONSTANTERROR: [105] 86. Error Block 37 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [124] 101. Error Block 28 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [124] 101. Error Block 28 end (CF ANALYSIS FAILED)
end
module_upvr.__index.Clean = module_upvr.__index.Cleanup
module_upvr.__index.Destroy = function(arg1) -- Line 284, Named "Destroy"
	arg1:Cleanup()
end
module_upvr.__call = module_upvr.__index.Cleanup
local tbl_2_upvr = {
	Connected = true;
}
tbl_2_upvr.__index = tbl_2_upvr
function tbl_2_upvr.Disconnect(arg1) -- Line 298
	if arg1.Connected then
		arg1.Connected = false
		arg1.Connection:Disconnect()
	end
end
function tbl_2_upvr.__tostring(arg1) -- Line 305
	return "Disconnect<"..tostring(arg1.Connected)..'>'
end
local Heartbeat_upvr = RunService_upvr.Heartbeat
module_upvr.__index.LinkToInstance = function(arg1, arg2, arg3) -- Line 315, Named "LinkToInstance"
	--[[ Upvalues[3]:
		[1]: newproxy_result1_3_upvr (readonly)
		[2]: tbl_2_upvr (readonly)
		[3]: Heartbeat_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var50_upvw
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var50_upvw = false
		return newproxy(var50_upvw)
	end
	if not arg3 or not INLINED() then
	end
	if arg2.Parent ~= nil then
		var50_upvw = false
	else
		var50_upvw = true
	end
	local setmetatable_result1_upvr = setmetatable({}, tbl_2_upvr)
	local var52_upvw
	var52_upvw = arg2.AncestryChanged:Connect(function(arg1_3, arg2_3) -- Line 321, Named "ChangedFunction"
		--[[ Upvalues[5]:
			[1]: setmetatable_result1_upvr (readonly)
			[2]: var50_upvw (read and write)
			[3]: Heartbeat_upvr (copied, readonly)
			[4]: var52_upvw (read and write)
			[5]: arg1 (readonly)
		]]
		local Connected = setmetatable_result1_upvr.Connected
		if Connected then
			if arg2_3 ~= nil then
				Connected = false
			else
				Connected = true
			end
			var50_upvw = Connected
			Connected = var50_upvw
			if Connected then
				Connected = coroutine.wrap
				Connected = Connected(function() -- Line 327
					--[[ Upvalues[5]:
						[1]: Heartbeat_upvr (copied, readonly)
						[2]: setmetatable_result1_upvr (copied, readonly)
						[3]: var52_upvw (copied, read and write)
						[4]: arg1 (copied, readonly)
						[5]: var50_upvw (copied, read and write)
					]]
					Heartbeat_upvr:Wait()
					if not setmetatable_result1_upvr.Connected then
					else
						if not var52_upvw.Connected then
							arg1:Cleanup()
							return
						end
						while var50_upvw and var52_upvw.Connected and setmetatable_result1_upvr.Connected do
							Heartbeat_upvr:Wait()
						end
						if setmetatable_result1_upvr.Connected and var50_upvw then
							arg1:Cleanup()
						end
					end
				end)
				Connected()
			end
		end
	end)
	local var55_upvw = var52_upvw
	setmetatable_result1_upvr.Connection = var55_upvw
	if var50_upvw and setmetatable_result1_upvr.Connected then
		if arg2.Parent ~= nil then
			var50_upvw = false
		else
			var50_upvw = true
		end
		if var50_upvw then
			coroutine.wrap(function() -- Line 327
				--[[ Upvalues[5]:
					[1]: Heartbeat_upvr (copied, readonly)
					[2]: setmetatable_result1_upvr (readonly)
					[3]: var55_upvw (read and write)
					[4]: arg1 (readonly)
					[5]: var50_upvw (read and write)
				]]
				Heartbeat_upvr:Wait()
				if not setmetatable_result1_upvr.Connected then
				else
					if not var55_upvw.Connected then
						arg1:Cleanup()
						return
					end
					while var50_upvw and var55_upvw.Connected and setmetatable_result1_upvr.Connected do
						Heartbeat_upvr:Wait()
					end
					if setmetatable_result1_upvr.Connected and var50_upvw then
						arg1:Cleanup()
					end
				end
			end)()
		end
	end
	return arg1:Add(setmetatable_result1_upvr, "Disconnect", newproxy_result1_3_upvr)
end
module_upvr.__index.LinkToInstances = function(arg1, ...) -- Line 363, Named "LinkToInstances"
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	local any_new_result1 = module_upvr.new()
	for _, v in ipairs({...}) do
		any_new_result1:Add(arg1:LinkToInstance(v, true), "Disconnect")
	end
	return any_new_result1
end
for i_3, v_2 in next, module_upvr.__index do
	module_upvr.__index[string.sub(string.lower(i_3), 1, 1)..string.sub(i_3, 2)] = v_2
end
return module_upvr