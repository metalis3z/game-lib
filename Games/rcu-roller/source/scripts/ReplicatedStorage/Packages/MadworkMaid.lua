-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:15:11
-- Luau version 6, Types version 3
-- Time taken: 0.002179 seconds

local module = {}
local var2_upvw
local function AcquireRunnerThreadAndCallEventHandler_upvr(arg1, ...) -- Line 41, Named "AcquireRunnerThreadAndCallEventHandler"
	--[[ Upvalues[1]:
		[1]: var2_upvw (read and write)
	]]
	var2_upvw = nil
	arg1(...)
	var2_upvw = var2_upvw
end
local function RunEventHandlerInFreeThread_upvr(...) -- Line 49, Named "RunEventHandlerInFreeThread"
	--[[ Upvalues[1]:
		[1]: AcquireRunnerThreadAndCallEventHandler_upvr (readonly)
	]]
	AcquireRunnerThreadAndCallEventHandler_upvr(...)
	while true do
		AcquireRunnerThreadAndCallEventHandler_upvr(coroutine.yield())
	end
end
local function CleanupTask_upvr(arg1, ...) -- Line 56, Named "CleanupTask"
	if type(arg1) == "function" then
		arg1(...)
	else
		if typeof(arg1) == "RBXScriptConnection" then
			arg1:Disconnect()
			return
		end
		if typeof(arg1) == "Instance" then
			arg1:Destroy()
			return
		end
		if type(arg1) == "table" then
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
local function PerformCleanupTask_upvr(...) -- Line 72, Named "PerformCleanupTask"
	--[[ Upvalues[3]:
		[1]: var2_upvw (read and write)
		[2]: RunEventHandlerInFreeThread_upvr (readonly)
		[3]: CleanupTask_upvr (readonly)
	]]
	if not var2_upvw then
		var2_upvw = coroutine.create(RunEventHandlerInFreeThread_upvr)
	end
	task.spawn(var2_upvw, CleanupTask_upvr, ...)
end
local tbl_upvr = {}
tbl_upvr.__index = tbl_upvr
function tbl_upvr.AddCleanupTask(arg1, arg2) -- Line 89
	--[[ Upvalues[1]:
		[1]: PerformCleanupTask_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 36 start (CF ANALYSIS FAILED)
	if arg1._is_cleaned == true then
		PerformCleanupTask_upvr(arg2)
		return function() -- Line 92
		end
	end
	if type(arg2) == "function" then
		table.insert(arg1._cleanup_tasks, arg2)
		-- KONSTANTWARNING: GOTO [115] #82
	end
	-- KONSTANTERROR: [0] 1. Error Block 36 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [25] 19. Error Block 33 start (CF ANALYSIS FAILED)
	if typeof(arg2) == "RBXScriptConnection" then
		table.insert(arg1._cleanup_tasks, arg2)
	elseif typeof(arg2) == "Instance" then
		table.insert(arg1._cleanup_tasks, arg2)
	elseif type(arg2) == "table" then
		if type(arg2.Destroy) == "function" then
			table.insert(arg1._cleanup_tasks, arg2)
		elseif type(arg2.Disconnect) == "function" then
			table.insert(arg1._cleanup_tasks, arg2)
		else
			error("[MadworkMaid]: Received object table as cleanup task, but couldn't detect a :Destroy() method")
		end
	else
		error("[MadworkMaid]: Cleanup task of type \""..typeof(arg2).."\" not supported")
	end
	-- KONSTANTERROR: [25] 19. Error Block 33 end (CF ANALYSIS FAILED)
end
function tbl_upvr.RemoveCleanupTask(arg1, arg2) -- Line 116
	local _cleanup_tasks = arg1._cleanup_tasks
	local table_find_result1 = table.find(_cleanup_tasks, arg2)
	if table_find_result1 ~= nil then
		table.remove(_cleanup_tasks, table_find_result1)
	end
end
function tbl_upvr.CleanupOfOne(arg1, arg2, ...) -- Line 124
	--[[ Upvalues[1]:
		[1]: PerformCleanupTask_upvr (readonly)
	]]
	arg1:RemoveCleanupTask(arg2)
	PerformCleanupTask_upvr(arg2, ...)
end
function tbl_upvr.Cleanup(arg1, ...) -- Line 129
	--[[ Upvalues[1]:
		[1]: PerformCleanupTask_upvr (readonly)
	]]
	for _, v in ipairs(arg1._cleanup_tasks) do
		PerformCleanupTask_upvr(v, ...)
	end
	arg1._cleanup_tasks = {}
	arg1._is_cleaned = true
end
function module.NewMaid() -- Line 139
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	local module_2 = {
		_cleanup_tasks = {};
		_is_cleaned = false;
	}
	setmetatable(module_2, tbl_upvr)
	return module_2
end
module.Cleanup = PerformCleanupTask_upvr
return module