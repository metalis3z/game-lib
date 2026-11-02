-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw


-- Decompiler will be improved VERY SOON!

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)

-- Decompiled on 2025-03-27 06:21:23

-- Luau version 6, Types version 3

-- Time taken: 0.002208 seconds


local module_upvr = {

	ClassName = "Maid";

}

function module_upvr.new() -- Line 18

	--[[ Upvalues[1]:

		[1]: module_upvr (readonly)

	]]

	return setmetatable({

		_tasks = {};

	}, module_upvr)

end

function module_upvr.isMaid(arg1) -- Line 24

	local var3 = false

	if type(arg1) == "table" then

		if arg1.ClassName ~= "Maid" then

			var3 = false

		else

			var3 = true

		end

	end

	return var3

end

function module_upvr.__index(arg1, arg2) -- Line 30

	--[[ Upvalues[1]:

		[1]: module_upvr (readonly)

	]]

	if module_upvr[arg2] then

		return module_upvr[arg2]

	end

	return arg1._tasks[arg2]

end

function module_upvr.__newindex(arg1, arg2, arg3) -- Line 47

	--[[ Upvalues[1]:

		[1]: module_upvr (readonly)

	]]

	if module_upvr[arg2] ~= nil then

		error(string.format("'%s' is reserved", tostring(arg2)), 2)

	end

	local _tasks_2 = arg1._tasks

	local var5 = _tasks_2[arg2]

	if var5 == arg3 then

	else

		_tasks_2[arg2] = arg3

		if var5 then

			if type(var5) == "function" then

				var5()

				return

			end

			if typeof(var5) == "RBXScriptConnection" then

				var5:Disconnect()

				return

			end

			if var5.Destroy then

				var5:Destroy()

				return

			end

			if var5.destroy then

				var5:destroy()

			end

		end

	end

end

function module_upvr.giveTask(arg1, arg2) -- Line 77

	if not arg2 then

		error("Task cannot be false or nil", 2)

	end

	local var6 = #arg1._tasks + 1

	arg1[var6] = arg2

	if type(arg2) == "table" and not arg2.Destroy and not arg2.destroy then

		warn("[Maid.GiveTask] - Gave table task without .Destroy\n\n"..debug.traceback())

	end

	return var6

end

function module_upvr.give(arg1, arg2) -- Line 109

	if type(arg2) == "table" and arg2.isAPromise then

		local any_givePromise_result1, any_givePromise_result2 = arg1:givePromise(arg2)

		_ = any_givePromise_result1 -- Setting global

		return arg2, any_givePromise_result2

	end

	return arg2, arg1:giveTask(arg2)

end

function module_upvr.doCleaning(arg1) -- Line 121

	local _tasks = arg1._tasks

	for i, v in pairs(_tasks) do

		if typeof(v) == "RBXScriptConnection" then

			_tasks[i] = nil

			v:Disconnect()

		end

	end

	local next_result1, next_result2 = next(_tasks)

	while next_result2 ~= nil do

		_tasks[next_result1] = nil

		i = next_result2

		if type(i) == "function" then

			next_result2()

		else

			i = next_result2

			if typeof(i) == "RBXScriptConnection" then

				next_result2:Disconnect()

			elseif next_result2.Destroy then

				next_result2:Destroy()

			elseif next_result2.destroy then

				next_result2:destroy()

			end

		end

		i = _tasks

		local _, _ = next(i)

	end

end

module_upvr.destroy = module_upvr.doCleaning

module_upvr.clean = module_upvr.doCleaning

return module_upvr
