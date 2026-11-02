-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:22
-- Luau version 6, Types version 3
-- Time taken: 0.004559 seconds

local module_upvr = {}
local var2_upvr = require(script.Internal)(module_upvr)
module_upvr.Disabled = true
module_upvr.Args = {}
module_upvr.Events = {}
function module_upvr.Init(arg1, arg2) -- Line 70
	--[[ Upvalues[2]:
		[1]: var2_upvr (readonly)
		[2]: module_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var12
	if var2_upvr._started ~= false then
		var12 = false
	else
		var12 = true
	end
	assert(var12, "Iris.Init can only be called once.")
	if var2_upvr._shutdown ~= false then
		var12 = false
	else
		var12 = true
	end
	assert(var12, "Iris.Init cannot be called once shutdown.")
	if arg1 == nil then
		var12 = game:GetService("Players")
	end
	if arg2 == nil then
	end
	var2_upvr.parentInstance = var12.LocalPlayer:WaitForChild("PlayerGui")
	var12 = true
	var2_upvr._started = var12
	var12 = var2_upvr
	var12._generateRootInstance()
	var12 = var2_upvr
	var12._generateSelectionImageObject()
	var12 = nil
	for _, v in var2_upvr._initFunctions, var12 do
		v()
	end
	local Heartbeat_upvw = game:GetService("RunService").Heartbeat
	function var12() -- Line 93
		--[[ Upvalues[2]:
			[1]: Heartbeat_upvw (read and write)
			[2]: var2_upvr (copied, readonly)
		]]
		if typeof(Heartbeat_upvw) == "function" then
			if var2_upvr._started then
				Heartbeat_upvw()
				var2_upvr._cycle()
				-- KONSTANTWARNING: GOTO [7] #6
			end
		elseif Heartbeat_upvw ~= nil then
			var2_upvr._eventConnection = Heartbeat_upvw:Connect(function() -- Line 100
				--[[ Upvalues[1]:
					[1]: var2_upvr (copied, readonly)
				]]
				var2_upvr._cycle()
			end)
		end
	end
	task.spawn(var12)
	return module_upvr
end
function module_upvr.Shutdown() -- Line 114
	--[[ Upvalues[1]:
		[1]: var2_upvr (readonly)
	]]
	var2_upvr._started = false
	var2_upvr._shutdown = true
	if var2_upvr._eventConnection then
		var2_upvr._eventConnection:Disconnect()
	end
	var2_upvr._eventConnection = nil
	if var2_upvr._rootWidget then
		if var2_upvr._rootWidget.Instance then
			var2_upvr._widgets.Root.Discard(var2_upvr._rootWidget)
		end
		var2_upvr._rootInstance = nil
	end
	if var2_upvr.SelectionImageObject then
		var2_upvr.SelectionImageObject:Destroy()
	end
	for _, v_2 in var2_upvr._connections do
		v_2:Disconnect()
	end
end
function module_upvr.Connect(arg1, arg2) -- Line 149
	--[[ Upvalues[1]:
		[1]: var2_upvr (readonly)
	]]
	if var2_upvr._started == false then
		warn("Iris:Connect() was called before calling Iris.Init(), the connected function will never run")
	end
	local var17_upvr = #var2_upvr._connectedFunctions + 1
	var2_upvr._connectedFunctions[var17_upvr] = arg2
	return function() -- Line 155
		--[[ Upvalues[2]:
			[1]: var2_upvr (copied, readonly)
			[2]: var17_upvr (readonly)
		]]
		var2_upvr._connectedFunctions[var17_upvr] = nil
	end
end
function module_upvr.Append(arg1) -- Line 169
	--[[ Upvalues[1]:
		[1]: var2_upvr (readonly)
	]]
	local any__GetParentWidget_result1 = var2_upvr._GetParentWidget()
	local var20
	if var2_upvr._config.Parent then
		var20 = var2_upvr._config.Parent
	else
		var20 = var2_upvr._widgets[any__GetParentWidget_result1.type].ChildAdded(any__GetParentWidget_result1, {
			type = "userInstance";
		})
	end
	arg1.Parent = var20
end
function module_upvr.End() -- Line 206
	--[[ Upvalues[1]:
		[1]: var2_upvr (readonly)
	]]
	if var2_upvr._stackIndex == 1 then
		error("Callback has too many calls to Iris.End()", 2)
	end
	var2_upvr._IDStack[var2_upvr._stackIndex] = nil
	local var22 = var2_upvr
	var22._stackIndex -= 1
end
function module_upvr.ForceRefresh() -- Line 230
	--[[ Upvalues[1]:
		[1]: var2_upvr (readonly)
	]]
	var2_upvr._globalRefreshRequested = true
end
function module_upvr.UpdateGlobalConfig(arg1) -- Line 251
	--[[ Upvalues[2]:
		[1]: var2_upvr (readonly)
		[2]: module_upvr (readonly)
	]]
	for i_3, v_3 in arg1 do
		var2_upvr._rootConfig[i_3] = v_3
	end
	module_upvr.ForceRefresh()
end
function module_upvr.PushConfig(arg1) -- Line 275
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: var2_upvr (readonly)
	]]
	local any_State_result1 = module_upvr.State(-1)
	if any_State_result1.value == -1 then
		any_State_result1:set(arg1)
	elseif var2_upvr._deepCompare(any_State_result1:get(), arg1) == false then
		var2_upvr._localRefreshActive = true
		any_State_result1:set(arg1)
	end
	var2_upvr._config = setmetatable(arg1, {
		__index = var2_upvr._config;
	})
end
function module_upvr.PopConfig() -- Line 300
	--[[ Upvalues[1]:
		[1]: var2_upvr (readonly)
	]]
	var2_upvr._localRefreshActive = false
	var2_upvr._config = getmetatable(var2_upvr._config).__index
end
module_upvr.TemplateConfig = require(script.config)
module_upvr.UpdateGlobalConfig(module_upvr.TemplateConfig.colorDark)
module_upvr.UpdateGlobalConfig(module_upvr.TemplateConfig.sizeDefault)
module_upvr.UpdateGlobalConfig(module_upvr.TemplateConfig.utilityDefault)
var2_upvr._globalRefreshRequested = false
function module_upvr.PushId(arg1) -- Line 329
	--[[ Upvalues[1]:
		[1]: var2_upvr (readonly)
	]]
	local var27
	if typeof(arg1) ~= "string" then
		var27 = false
	else
		var27 = true
	end
	assert(var27, "Iris expected Iris.PushId id to PushId to be a string.")
	var27 = tostring(arg1)
	var2_upvr._pushedId = var27
end
function module_upvr.PopId() -- Line 340
	--[[ Upvalues[1]:
		[1]: var2_upvr (readonly)
	]]
	var2_upvr._pushedId = nil
end
function module_upvr.SetNextWidgetID(arg1) -- Line 365
	--[[ Upvalues[1]:
		[1]: var2_upvr (readonly)
	]]
	var2_upvr._nextWidgetId = arg1
end
function module_upvr.State(arg1) -- Line 404
	--[[ Upvalues[1]:
		[1]: var2_upvr (readonly)
	]]
	local any__getID_result1 = var2_upvr._getID(2)
	if var2_upvr._states[any__getID_result1] then
		return var2_upvr._states[any__getID_result1]
	end
	local tbl = {}
	tbl.value = arg1
	tbl.ConnectedWidgets = {}
	tbl.ConnectedFunctions = {}
	var2_upvr._states[any__getID_result1] = tbl
	setmetatable(var2_upvr._states[any__getID_result1], var2_upvr.StateClass)
	return var2_upvr._states[any__getID_result1]
end
function module_upvr.WeakState(arg1) -- Line 425
	--[[ Upvalues[1]:
		[1]: var2_upvr (readonly)
	]]
	local any__getID_result1_2 = var2_upvr._getID(2)
	if var2_upvr._states[any__getID_result1_2] then
		if next(var2_upvr._states[any__getID_result1_2].ConnectedWidgets) == nil then
			var2_upvr._states[any__getID_result1_2] = nil
		else
			return var2_upvr._states[any__getID_result1_2]
		end
	end
	local tbl_2 = {}
	tbl_2.value = arg1
	tbl_2.ConnectedWidgets = {}
	tbl_2.ConnectedFunctions = {}
	var2_upvr._states[any__getID_result1_2] = tbl_2
	setmetatable(var2_upvr._states[any__getID_result1_2], var2_upvr.StateClass)
	return var2_upvr._states[any__getID_result1_2]
end
function module_upvr.ComputedState(arg1, arg2) -- Line 459
	--[[ Upvalues[1]:
		[1]: var2_upvr (readonly)
	]]
	local any__getID_result1_3_upvr = var2_upvr._getID(2)
	if var2_upvr._states[any__getID_result1_3_upvr] then
		return var2_upvr._states[any__getID_result1_3_upvr]
	end
	var2_upvr._states[any__getID_result1_3_upvr] = {
		value = arg2(arg1.value);
		ConnectedWidgets = {};
		ConnectedFunctions = {};
	}
	arg1:onChange(function(arg1_2) -- Line 470
		--[[ Upvalues[3]:
			[1]: var2_upvr (copied, readonly)
			[2]: any__getID_result1_3_upvr (readonly)
			[3]: arg2 (readonly)
		]]
		var2_upvr._states[any__getID_result1_3_upvr]:set(arg2(arg1_2))
	end)
	setmetatable(var2_upvr._states[any__getID_result1_3_upvr], var2_upvr.StateClass)
	return var2_upvr._states[any__getID_result1_3_upvr]
end
module_upvr.ShowDemoWindow = require(script.demoWindow)(module_upvr)
require(script.widgets)(var2_upvr)
require(script.API)(module_upvr)
return module_upvr