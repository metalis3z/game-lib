-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:23
-- Luau version 6, Types version 3
-- Time taken: 0.006281 seconds

local newproxy_result1_3_upvr = newproxy(true)
getmetatable(newproxy_result1_3_upvr).__tostring = function() -- Line 11
	return "IndicesReference"
end
local newproxy_result1_5_upvr = newproxy(true)
getmetatable(newproxy_result1_5_upvr).__tostring = function() -- Line 16
	return "LinkToInstanceIndex"
end
local module_upvr = {
	ClassName = "Janitor";
	__index = {
		CurrentlyCleaning = true;
		[newproxy_result1_3_upvr] = nil;
	};
}
local tbl_upvr = {
	["function"] = true;
	RBXScriptConnection = "Disconnect";
}
function module_upvr.new() -- Line 40
	--[[ Upvalues[2]:
		[1]: newproxy_result1_3_upvr (readonly)
		[2]: module_upvr (readonly)
	]]
	return setmetatable({
		CurrentlyCleaning = false;
		[newproxy_result1_3_upvr] = nil;
	}, module_upvr)
end
function module_upvr.Is(arg1) -- Line 52
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	local var13 = false
	if type(arg1) == "table" then
		if getmetatable(arg1) ~= module_upvr then
			var13 = false
		else
			var13 = true
		end
	end
	return var13
end
module_upvr.is = module_upvr.Is
module_upvr.__index.Add = function(arg1, arg2, arg3, arg4) -- Line 65, Named "Add"
	--[[ Upvalues[2]:
		[1]: newproxy_result1_3_upvr (readonly)
		[2]: tbl_upvr (readonly)
	]]
	if arg4 == nil then
		local newproxy_result1 = newproxy(false)
	end
	if newproxy_result1 then
		arg1:Remove(newproxy_result1)
		local var19 = arg1[newproxy_result1_3_upvr]
		if not var19 then
			var19 = {}
			arg1[newproxy_result1_3_upvr] = var19
		end
		var19[newproxy_result1] = arg2
	end
	var19 = arg3
	local var20 = var19
	if not var20 then
		var20 = tbl_upvr[typeof(arg2)]
		if not var20 then
			var20 = "Destroy"
		end
	end
	local var21 = var20
	if type(arg2) ~= "function" then
		if not arg2[var21] then
			warn(string.format("Object %s doesn't have method %s, are you sure you want to add it? Traceback: %s", tostring(arg2), tostring(var21), debug.traceback(nil, 2)))
		end
	end
	arg1[arg2] = var21
	return arg2, newproxy_result1
end
module_upvr.__index.Give = module_upvr.__index.Add
module_upvr.__index.AddObject = function(arg1, arg2) -- Line 131, Named "AddObject"
	local newproxy_result1_2 = newproxy(false)
	return arg1:Add(arg2, false, newproxy_result1_2), newproxy_result1_2
end
module_upvr.__index.GiveObject = module_upvr.__index.AddObject
module_upvr.__index.Remove = function(arg1, arg2) -- Line 155, Named "Remove"
	--[[ Upvalues[1]:
		[1]: newproxy_result1_3_upvr (readonly)
	]]
	local var27 = arg1[newproxy_result1_3_upvr]
	if var27 then
		local var28 = var27[arg2]
		if var28 then
			local var29 = arg1[var28]
			if var29 then
				if var29 == true then
					var28()
				else
					local var30 = var28[var29]
					if var30 then
						var30(var28)
					end
				end
				arg1[var28] = nil
			end
			var27[arg2] = nil
		end
	end
	return arg1
end
module_upvr.__index.Get = function(arg1, arg2) -- Line 189, Named "Get"
	--[[ Upvalues[1]:
		[1]: newproxy_result1_3_upvr (readonly)
	]]
	local var31 = arg1[newproxy_result1_3_upvr]
	if var31 then
		return var31[arg2]
	end
end
module_upvr.__index.Cleanup = function(arg1) -- Line 200, Named "Cleanup"
	--[[ Upvalues[1]:
		[1]: newproxy_result1_3_upvr (readonly)
	]]
	if not arg1.CurrentlyCleaning then
		arg1.CurrentlyCleaning = nil
		for i, v in next, arg1 do
			if i ~= newproxy_result1_3_upvr then
				local type_result1 = type(i)
				if type_result1 == "string" or type_result1 == "number" then
					arg1[i] = nil
				else
					if v == true then
						i()
					else
						local var39 = i[v]
						if var39 then
							var39(i)
						end
					end
					arg1[i] = nil
				end
			end
		end
		local var40 = arg1[newproxy_result1_3_upvr]
		if var40 then
			i = nil
			for i_2 in next, var40, i do
				var40[i_2] = nil
				local _
			end
			arg1[newproxy_result1_3_upvr] = {}
		end
		arg1.CurrentlyCleaning = false
	end
end
module_upvr.__index.Clean = module_upvr.__index.Cleanup
module_upvr.__index.Destroy = function(arg1) -- Line 246, Named "Destroy"
	arg1:Cleanup()
end
module_upvr.__call = module_upvr.__index.Cleanup
local tbl_upvr_2 = {
	Connected = true;
}
tbl_upvr_2.__index = tbl_upvr_2
function tbl_upvr_2.Disconnect(arg1) -- Line 260
	if arg1.Connected then
		arg1.Connected = false
		arg1.Connection:Disconnect()
	end
end
function tbl_upvr_2.__tostring(arg1) -- Line 267
	return "Disconnect<"..tostring(arg1.Connected)..'>'
end
local Heartbeat_upvr = game:GetService("RunService").Heartbeat
module_upvr.__index.LinkToInstance = function(arg1, arg2, arg3) -- Line 277, Named "LinkToInstance"
	--[[ Upvalues[3]:
		[1]: newproxy_result1_5_upvr (readonly)
		[2]: tbl_upvr_2 (readonly)
		[3]: Heartbeat_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var44_upvw
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var44_upvw = false
		return newproxy(var44_upvw)
	end
	if not arg3 or not INLINED() then
	end
	if arg2.Parent ~= nil then
		var44_upvw = false
	else
		var44_upvw = true
	end
	local setmetatable_result1_upvr = setmetatable({}, tbl_upvr_2)
	local var46_upvw
	var46_upvw = arg2.AncestryChanged:Connect(function(arg1_2, arg2_2) -- Line 283, Named "ChangedFunction"
		--[[ Upvalues[5]:
			[1]: setmetatable_result1_upvr (readonly)
			[2]: var44_upvw (read and write)
			[3]: Heartbeat_upvr (copied, readonly)
			[4]: var46_upvw (read and write)
			[5]: arg1 (readonly)
		]]
		local Connected = setmetatable_result1_upvr.Connected
		if Connected then
			if arg2_2 ~= nil then
				Connected = false
			else
				Connected = true
			end
			var44_upvw = Connected
			Connected = var44_upvw
			if Connected then
				Connected = coroutine.wrap
				Connected = Connected(function() -- Line 289
					--[[ Upvalues[5]:
						[1]: Heartbeat_upvr (copied, readonly)
						[2]: setmetatable_result1_upvr (copied, readonly)
						[3]: var46_upvw (copied, read and write)
						[4]: arg1 (copied, readonly)
						[5]: var44_upvw (copied, read and write)
					]]
					Heartbeat_upvr:Wait()
					if not setmetatable_result1_upvr.Connected then
					else
						if not var46_upvw.Connected then
							arg1:Cleanup()
							return
						end
						while var44_upvw and var46_upvw.Connected and setmetatable_result1_upvr.Connected do
							Heartbeat_upvr:Wait()
						end
						if setmetatable_result1_upvr.Connected and var44_upvw then
							arg1:Cleanup()
						end
					end
				end)
				Connected()
			end
		end
	end)
	local var49_upvw = var46_upvw
	setmetatable_result1_upvr.Connection = var49_upvw
	if var44_upvw and setmetatable_result1_upvr.Connected then
		if arg2.Parent ~= nil then
			var44_upvw = false
		else
			var44_upvw = true
		end
		if var44_upvw then
			coroutine.wrap(function() -- Line 289
				--[[ Upvalues[5]:
					[1]: Heartbeat_upvr (copied, readonly)
					[2]: setmetatable_result1_upvr (readonly)
					[3]: var49_upvw (read and write)
					[4]: arg1 (readonly)
					[5]: var44_upvw (read and write)
				]]
				Heartbeat_upvr:Wait()
				if not setmetatable_result1_upvr.Connected then
				else
					if not var49_upvw.Connected then
						arg1:Cleanup()
						return
					end
					while var44_upvw and var49_upvw.Connected and setmetatable_result1_upvr.Connected do
						Heartbeat_upvr:Wait()
					end
					if setmetatable_result1_upvr.Connected and var44_upvw then
						arg1:Cleanup()
					end
				end
			end)()
		end
	end
	return arg1:Add(setmetatable_result1_upvr, "Disconnect", newproxy_result1_5_upvr)
end
module_upvr.__index.LinkToInstances = function(arg1, ...) -- Line 325, Named "LinkToInstances"
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	local any_new_result1 = module_upvr.new()
	for _, v_2 in ipairs({...}) do
		any_new_result1:Add(arg1:LinkToInstance(v_2, true), "Disconnect")
	end
	return any_new_result1
end
for i_4, v_3 in next, module_upvr.__index do
	module_upvr.__index[string.sub(string.lower(i_4), 1, 1)..string.sub(i_4, 2)] = v_3
end
return module_upvr