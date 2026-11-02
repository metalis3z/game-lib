-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:14
-- Luau version 6, Types version 3
-- Time taken: 0.002334 seconds

local var1_upvw
local function AcquireRunnerThreadAndCallEventHandler_upvr(arg1, ...) -- Line 43, Named "AcquireRunnerThreadAndCallEventHandler"
	--[[ Upvalues[1]:
		[1]: var1_upvw (read and write)
	]]
	var1_upvw = nil
	arg1(...)
	var1_upvw = var1_upvw
end
local function RunEventHandlerInFreeThread_upvr(...) -- Line 51, Named "RunEventHandlerInFreeThread"
	--[[ Upvalues[1]:
		[1]: AcquireRunnerThreadAndCallEventHandler_upvr (readonly)
	]]
	AcquireRunnerThreadAndCallEventHandler_upvr(...)
	while true do
		AcquireRunnerThreadAndCallEventHandler_upvr(coroutine.yield())
	end
end
local function Cleanup(arg1, ...) -- Line 58
	local typeof_result1 = typeof(arg1)
	if typeof_result1 == "function" then
		arg1(...)
	else
		if typeof_result1 == "RBXScriptConnection" then
			arg1:Disconnect()
			return
		end
		if typeof_result1 == "Instance" then
			arg1:Destroy()
			return
		end
		if typeof_result1 == "table" then
			if type(arg1.Destroy) == "function" then
				arg1:Destroy()
				return
			end
			if type(arg1.Disconnect) == "function" then
				arg1:Disconnect()
			end
		end
	end
end
local function CleanupInThread_upvr(...) -- Line 78, Named "CleanupInThread"
	--[[ Upvalues[3]:
		[1]: var1_upvw (read and write)
		[2]: RunEventHandlerInFreeThread_upvr (readonly)
		[3]: Cleanup (readonly)
	]]
	if not var1_upvw then
		var1_upvw = coroutine.create(RunEventHandlerInFreeThread_upvr)
	end
	task.spawn(assert(var1_upvw), Cleanup, ...)
end
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
local function New(arg1, arg2) -- Line 103
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	local module = {}
	module.maid = arg1
	module.object = arg2
	setmetatable(module, tbl_upvr)
	return module
end
tbl_upvr.New = New
function tbl_upvr.Destroy(arg1) -- Line 116
	arg1.maid.tokens[arg1] = nil
end
local function Cleanup(arg1, ...) -- Line 120
	--[[ Upvalues[1]:
		[1]: CleanupInThread_upvr (readonly)
	]]
	if arg1.object == nil then
	else
		arg1.maid.tokens[arg1] = nil
		CleanupInThread_upvr(arg1.object, ...)
		arg1.object = nil
	end
end
tbl_upvr.Cleanup = Cleanup
local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
function module_2_upvr.New(arg1) -- Line 135
	--[[ Upvalues[1]:
		[1]: module_2_upvr (readonly)
	]]
	local module_3 = {
		tokens = {};
		is_cleaned = false;
	}
	module_3.key = arg1
	setmetatable(module_3, module_2_upvr)
	return module_3
end
function module_2_upvr.IsActive(arg1) -- Line 149
	return not arg1.is_cleaned
end
function module_2_upvr.Add(arg1, arg2) -- Line 153
	--[[ Upvalues[2]:
		[1]: CleanupInThread_upvr (readonly)
		[2]: tbl_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 16 start (CF ANALYSIS FAILED)
	if arg1.is_cleaned == true then
		CleanupInThread_upvr(arg2)
	end
	local typeof_result1_2 = typeof(arg2)
	if typeof_result1_2 == "table" then
		if type(arg2.Destroy) ~= "function" and type(arg2.Disconnect) ~= "function" then
			error(`[{script.Name}]: Received table as cleanup object, but couldn't detect a :Destroy() or :Disconnect() method`)
			-- KONSTANTWARNING: GOTO [62] #42
		end
	elseif typeof_result1_2 ~= "function" and typeof_result1_2 ~= "RBXScriptConnection" and typeof_result1_2 ~= "Instance" then
		error(`[{script.Name}]: Cleanup of type "{typeof_result1_2}" not supported`)
	end
	-- KONSTANTERROR: [0] 1. Error Block 16 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [62] 42. Error Block 11 start (CF ANALYSIS FAILED)
	local any_New_result1 = tbl_upvr.New(arg1, arg2)
	arg1.tokens[any_New_result1] = true
	do
		return any_New_result1
	end
	-- KONSTANTERROR: [62] 42. Error Block 11 end (CF ANALYSIS FAILED)
end
function module_2_upvr.Cleanup(arg1, ...) -- Line 176
	if arg1.key ~= nil then
		error(`[{script.Name}]: "Cleanup()" is locked for this Maid`)
	end
	arg1.is_cleaned = true
	for i in pairs(arg1.tokens) do
		i:Cleanup(...)
	end
end
function module_2_upvr.Unlock(arg1, arg2) -- Line 190
	if arg1.key ~= nil and arg1.key ~= arg2 then
		error(`[{script.Name}]: Invalid lock key`)
	end
	arg1.key = nil
end
return module_2_upvr