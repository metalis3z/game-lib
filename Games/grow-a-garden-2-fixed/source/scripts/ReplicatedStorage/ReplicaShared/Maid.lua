--credit to prince games studio
local v1 = nil

local function AcquireRunnerThreadAndCallEventHandler(p1, ...) --[[ AcquireRunnerThreadAndCallEventHandler | Line: 43 | Upvalues: v1 (ref) ]]
	local v12 = v1

	v1 = nil
	p1(...)
	v1 = v12
end

local function RunEventHandlerInFreeThread(...) --[[ RunEventHandlerInFreeThread | Line: 51 | Upvalues: AcquireRunnerThreadAndCallEventHandler (copy) ]]
	AcquireRunnerThreadAndCallEventHandler(...)

	while true do
		AcquireRunnerThreadAndCallEventHandler(coroutine.yield())
	end
end

local function Cleanup(p1, ...) --[[ Cleanup | Line: 58 ]]
	local v1 = typeof(p1)

	if v1 == "function" then
		p1(...)

		return
	end

	if v1 ~= "RBXScriptConnection" then
		if v1 == "Instance" then
			p1:Destroy()

			return
		end

		if v1 ~= "table" then
			return
		end

		if type(p1.Destroy) == "function" then
			p1:Destroy()

			return
		end

		if type(p1.Disconnect) ~= "function" then
			return
		end
	end

	p1:Disconnect()
end

local function CleanupInThread(...) --[[ CleanupInThread | Line: 78 | Upvalues: v1 (ref), RunEventHandlerInFreeThread (copy), Cleanup (copy) ]]
	if v1 then
		local v12

		v12 = v1
		task.spawn(assert(v1), Cleanup, ...)

		return
	end

	v1 = coroutine.create(RunEventHandlerInFreeThread)
	task.spawn(assert(v1), Cleanup, ...)
end

local t = {}

t.__index = t
function t.New(p1, p2) --[[ New | Line: 103 | Upvalues: t (copy) ]]
	local t2 = {
		maid = p1,
		object = p2
	}

	setmetatable(t2, t)

	return t2
end
function t.Destroy(p1) --[[ Destroy | Line: 116 ]]
	p1.maid.tokens[p1] = nil
end
function t.Cleanup(p1, ...) --[[ Cleanup | Line: 120 | Upvalues: CleanupInThread (copy) ]]
	if p1.object ~= nil then
		p1.maid.tokens[p1] = nil
		CleanupInThread(p1.object, ...)
		p1.object = nil
	end
end

local t2 = {}

t2.__index = t2
function t2.New(p1) --[[ New | Line: 135 | Upvalues: t2 (copy) ]]
	local t = {
		is_cleaned = false,
		tokens = {},
		key = p1
	}

	setmetatable(t, t2)

	return t
end
function t2.IsActive(p1) --[[ IsActive | Line: 149 ]]
	return not p1.is_cleaned
end
function t2.Add(p1, p2) --[[ Add | Line: 153 | Upvalues: CleanupInThread (copy), t (copy) ]]
	if p1.is_cleaned == true then
		CleanupInThread(p2)
	end

	local v1 = typeof(p2)

	if v1 == "table" then
		if type(p2.Destroy) ~= "function" and type(p2.Disconnect) ~= "function" then
			error((("[%*]: Received table as cleanup object, but couldn\'t detect a :Destroy() or :Disconnect() method"):format(script.Name)))
		end
	elseif v1 ~= "function" and (v1 ~= "RBXScriptConnection" and v1 ~= "Instance") then
		error((("[%*]: Cleanup of type \"%*\" not supported"):format(script.Name, v1)))
	end

	local v2 = t.New(p1, p2)

	p1.tokens[v2] = true

	return v2
end
function t2.Cleanup(p1, ...) --[[ Cleanup | Line: 176 ]]
	if p1.key ~= nil then
		error((("[%*]: \"Cleanup()\" is locked for this Maid"):format(script.Name)))
	end

	p1.is_cleaned = true

	for k in pairs(p1.tokens) do
		k:Cleanup(...)
	end
end
function t2.Unlock(p1, p2) --[[ Unlock | Line: 190 ]]
	if p1.key ~= nil and p1.key ~= p2 then
		error((("[%*]: Invalid lock key"):format(script.Name)))
	end

	p1.key = nil
end

return t2