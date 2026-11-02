-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = require(ReplicatedStorage.Library.Modules.Packages.Log).new()
local t = {}

t.__index = t

local function isQueued(p1, p2) --[[ isQueued | Line: 52 ]]
	return p1._pendingKinds[p2] ~= nil
end

local function queueInstance(p1, p2, p3) --[[ queueInstance | Line: 56 ]]
	if p1._destroyed then
		return
	end

	local _filter = p1._filter

	if _filter and not _filter(p2) then
		return
	end

	if not (if p1._pendingKinds[p2] == nil then false else true) then
		p1._pendingInstances[#p1._pendingInstances + 1] = p2
	end

	p1._pendingKinds[p2] = p3
end

local function compactPending(p1) --[[ compactPending | Line: 73 ]]
	if not (p1._nextPendingIndex <= #p1._pendingInstances) then
		table.clear(p1._pendingInstances)
		p1._nextPendingIndex = 1
	end
end

local function hasPendingWork(p1) --[[ hasPendingWork | Line: 82 ]]
	return if p1._nextPendingIndex <= #p1._pendingInstances then true else #p1._pendingTraversals > 0
end

local function queueTraversal(p1, p2, p3) --[[ queueTraversal | Line: 86 ]]
	p1._pendingTraversals[#p1._pendingTraversals + 1] = {
		kind = p3,
		stack = p2:GetChildren()
	}
end

local function processTraversals(p1, p2) --[[ processTraversals | Line: 93 ]]
	local count = 0

	while #p1._pendingTraversals > 0 and (count < p1._maxInstancesPerStep and not (os.clock() - p2 >= p1._maxStepTime)) do
		local v1 = p1._pendingTraversals[#p1._pendingTraversals]
		local stack = v1.stack
		local v2 = stack[#stack]

		stack[#stack] = nil

		if v2 then
			local kind = v1.kind

			if not p1._destroyed then
				local _filter = p1._filter

				if not _filter or _filter(v2) then
					if not (if p1._pendingKinds[v2] == nil then false else true) then
						p1._pendingInstances[#p1._pendingInstances + 1] = v2
					end

					p1._pendingKinds[v2] = kind
				end
			end

			local v4 = v2:GetChildren()

			for i = 1, #v4 do
				stack[#stack + 1] = v4[i]
			end

			count = count + 1
		else
			p1._pendingTraversals[#p1._pendingTraversals] = nil
		end
	end

	return count
end

local function processPending(p1) --[[ processPending | Line: 124 | Upvalues: processTraversals (copy), v1 (copy) ]]
	local v12 = os.clock()
	local count = processTraversals(p1, v12)

	while p1._nextPendingIndex <= #p1._pendingInstances and (count < p1._maxInstancesPerStep and not (os.clock() - v12 >= p1._maxStepTime)) do
		local v2 = p1._pendingInstances[p1._nextPendingIndex]

		p1._pendingInstances[p1._nextPendingIndex] = nil
		p1._nextPendingIndex = p1._nextPendingIndex + 1

		if v2 then
			local v3 = p1._pendingKinds[v2]

			p1._pendingKinds[v2] = nil

			if v3 == "Added" then
				local _onAdded = p1._onAdded

				if _onAdded then
					local t = { pcall(_onAdded, v2) }

					if not t[1] then
						local v4 = v1:AtError()
						local t2 = {}

						t2.Error = tostring(t[2])
						t2.Instance = v2:GetFullName()
						v4:Log("InstanceChangeQueue OnAdded failed", t2)
					end
				end
			elseif v3 == "Removed" then
				local _onRemoved = p1._onRemoved

				if _onRemoved then
					local t = { pcall(_onRemoved, v2) }

					if not t[1] then
						local v6 = v1:AtError()
						local t2 = {}

						t2.Error = tostring(t[2])
						t2.Instance = v2:GetFullName()
						v6:Log("InstanceChangeQueue OnRemoved failed", t2)
					end
				end
			end
		end

		count = count + 1
	end

	if not (p1._nextPendingIndex <= #p1._pendingInstances) then
		table.clear(p1._pendingInstances)
		p1._nextPendingIndex = 1
	end
end

local function v2(p1) --[[ ensureWorker | Line: 174 | Upvalues: processPending (copy), v1 (copy), v2 (copy) ]]
	if not (p1._workerRunning or p1._destroyed) then
		p1._workerRunning = true
		task.spawn(function() --[[ Line: 181 | Upvalues: p1 (copy), processPending (ref), v1 (ref), v2 (ref) ]]
			local v12 = 0

			while not p1._destroyed do
				local v22 = p1

				if not (if v22._nextPendingIndex <= #v22._pendingInstances then true else #v22._pendingTraversals > 0) then
					break
				end

				local v4 = v12 - os.clock()

				if v4 > 0 then
					task.wait(v4)
				end

				local t2 = { pcall(processPending, p1) }

				if not t2[1] then
					local v5 = v1:AtError()
					local t22 = {}

					t22.Error = tostring(t2[2])
					v5:Log("InstanceChangeQueue worker failed", t22)
				end

				v12 = os.clock() + p1._stepInterval
			end

			p1._workerRunning = false

			if p1._destroyed then
				return
			end

			local v7 = p1

			if not (if v7._nextPendingIndex <= #v7._pendingInstances then true else #v7._pendingTraversals > 0) then
				return
			end

			v2(p1)
		end)
	end
end

function t.new(p1) --[[ new | Line: 209 | Upvalues: t (copy) ]]
	local v1 = if p1 and p1.MaxInstancesPerStep then p1.MaxInstancesPerStep else 70
	local v2 = if p1 and p1.MaxStepTime then p1.MaxStepTime else 0.004166666666666667
	local v3 = if p1 and p1.StepInterval then p1.StepInterval else 0.016666666666666666

	assert(if typeof(v1) == "number" then if v1 >= 1 then true else false else false, "MaxInstancesPerStep must be >= 1")
	assert(if typeof(v2) == "number" then if v2 > 0 then true else false else false, "MaxStepTime must be > 0")
	assert(if typeof(v3) == "number" then if v3 > 0 then true else false else false, "StepInterval must be > 0")

	local t2 = {
		_nextPendingIndex = 1,
		_workerRunning = false,
		_destroyed = false
	}

	t2._filter = if p1 then p1.Filter else nil
	t2._onAdded = if p1 then p1.OnAdded else nil
	t2._onRemoved = if p1 then p1.OnRemoved else nil
	t2._maxInstancesPerStep = math.floor(v1)
	t2._maxStepTime = v2
	t2._stepInterval = v3
	t2._pendingInstances = {}
	t2._pendingKinds = {}
	t2._pendingTraversals = {}

	return setmetatable(t2, t)
end
function t.QueueAdded(p1, p2) --[[ QueueAdded | Line: 238 | Upvalues: processPending (copy), v1 (copy), v2 (copy) ]]
	if not p1._destroyed then
		local _filter = p1._filter

		if not _filter or _filter(p2) then
			if not (p1._pendingKinds[p2] ~= nil) then
				p1._pendingInstances[#p1._pendingInstances + 1] = p2
			end

			p1._pendingKinds[p2] = "Added"
		end
	end

	if p1._workerRunning then
		return
	end

	if p1._destroyed then
		return
	end

	p1._workerRunning = true
	task.spawn(function() --[[ Line: 181 | Upvalues: p1 (copy), processPending (ref), v1 (ref), v2 (ref) ]]
		local v12 = 0

		while not p1._destroyed do
			local v22 = p1

			if not (if v22._nextPendingIndex <= #v22._pendingInstances then true else #v22._pendingTraversals > 0) then
				break
			end

			local v4 = v12 - os.clock()

			if v4 > 0 then
				task.wait(v4)
			end

			local t2 = { pcall(processPending, p1) }

			if not t2[1] then
				local v5 = v1:AtError()
				local t22 = {}

				t22.Error = tostring(t2[2])
				v5:Log("InstanceChangeQueue worker failed", t22)
			end

			v12 = os.clock() + p1._stepInterval
		end

		p1._workerRunning = false

		if p1._destroyed then
			return
		end

		local v7 = p1

		if not (if v7._nextPendingIndex <= #v7._pendingInstances then true else #v7._pendingTraversals > 0) then
			return
		end

		v2(p1)
	end)
end
function t.QueueRemoved(p1, p2) --[[ QueueRemoved | Line: 243 | Upvalues: processPending (copy), v1 (copy), v2 (copy) ]]
	if not p1._destroyed then
		local _filter = p1._filter

		if not _filter or _filter(p2) then
			if not (p1._pendingKinds[p2] ~= nil) then
				p1._pendingInstances[#p1._pendingInstances + 1] = p2
			end

			p1._pendingKinds[p2] = "Removed"
		end
	end

	if p1._workerRunning then
		return
	end

	if p1._destroyed then
		return
	end

	p1._workerRunning = true
	task.spawn(function() --[[ Line: 181 | Upvalues: p1 (copy), processPending (ref), v1 (ref), v2 (ref) ]]
		local v12 = 0

		while not p1._destroyed do
			local v22 = p1

			if not (if v22._nextPendingIndex <= #v22._pendingInstances then true else #v22._pendingTraversals > 0) then
				break
			end

			local v4 = v12 - os.clock()

			if v4 > 0 then
				task.wait(v4)
			end

			local t2 = { pcall(processPending, p1) }

			if not t2[1] then
				local v5 = v1:AtError()
				local t22 = {}

				t22.Error = tostring(t2[2])
				v5:Log("InstanceChangeQueue worker failed", t22)
			end

			v12 = os.clock() + p1._stepInterval
		end

		p1._workerRunning = false

		if p1._destroyed then
			return
		end

		local v7 = p1

		if not (if v7._nextPendingIndex <= #v7._pendingInstances then true else #v7._pendingTraversals > 0) then
			return
		end

		v2(p1)
	end)
end
function t.QueueDescendantsAdded(p1, p2, p3) --[[ QueueDescendantsAdded | Line: 248 | Upvalues: processPending (copy), v1 (copy), v2 (copy) ]]
	if p3 ~= false and not p1._destroyed then
		local _filter = p1._filter

		if not _filter or _filter(p2) then
			if not (p1._pendingKinds[p2] ~= nil) then
				p1._pendingInstances[#p1._pendingInstances + 1] = p2
			end

			p1._pendingKinds[p2] = "Added"
		end
	end

	p1._pendingTraversals[#p1._pendingTraversals + 1] = {
		kind = "Added",
		stack = p2:GetChildren()
	}

	if p1._workerRunning then
		return
	end

	if p1._destroyed then
		return
	end

	p1._workerRunning = true
	task.spawn(function() --[[ Line: 181 | Upvalues: p1 (copy), processPending (ref), v1 (ref), v2 (ref) ]]
		local v12 = 0

		while not p1._destroyed do
			local v22 = p1

			if not (if v22._nextPendingIndex <= #v22._pendingInstances then true else #v22._pendingTraversals > 0) then
				break
			end

			local v4 = v12 - os.clock()

			if v4 > 0 then
				task.wait(v4)
			end

			local t2 = { pcall(processPending, p1) }

			if not t2[1] then
				local v5 = v1:AtError()
				local t22 = {}

				t22.Error = tostring(t2[2])
				v5:Log("InstanceChangeQueue worker failed", t22)
			end

			v12 = os.clock() + p1._stepInterval
		end

		p1._workerRunning = false

		if p1._destroyed then
			return
		end

		local v7 = p1

		if not (if v7._nextPendingIndex <= #v7._pendingInstances then true else #v7._pendingTraversals > 0) then
			return
		end

		v2(p1)
	end)
end
function t.QueueDescendantsRemoved(p1, p2, p3) --[[ QueueDescendantsRemoved | Line: 258 | Upvalues: processPending (copy), v1 (copy), v2 (copy) ]]
	if p3 ~= false and not p1._destroyed then
		local _filter = p1._filter

		if not _filter or _filter(p2) then
			if not (p1._pendingKinds[p2] ~= nil) then
				p1._pendingInstances[#p1._pendingInstances + 1] = p2
			end

			p1._pendingKinds[p2] = "Removed"
		end
	end

	p1._pendingTraversals[#p1._pendingTraversals + 1] = {
		kind = "Removed",
		stack = p2:GetChildren()
	}

	if p1._workerRunning then
		return
	end

	if p1._destroyed then
		return
	end

	p1._workerRunning = true
	task.spawn(function() --[[ Line: 181 | Upvalues: p1 (copy), processPending (ref), v1 (ref), v2 (ref) ]]
		local v12 = 0

		while not p1._destroyed do
			local v22 = p1

			if not (if v22._nextPendingIndex <= #v22._pendingInstances then true else #v22._pendingTraversals > 0) then
				break
			end

			local v4 = v12 - os.clock()

			if v4 > 0 then
				task.wait(v4)
			end

			local t2 = { pcall(processPending, p1) }

			if not t2[1] then
				local v5 = v1:AtError()
				local t22 = {}

				t22.Error = tostring(t2[2])
				v5:Log("InstanceChangeQueue worker failed", t22)
			end

			v12 = os.clock() + p1._stepInterval
		end

		p1._workerRunning = false

		if p1._destroyed then
			return
		end

		local v7 = p1

		if not (if v7._nextPendingIndex <= #v7._pendingInstances then true else #v7._pendingTraversals > 0) then
			return
		end

		v2(p1)
	end)
end
function t.Flush(p1) --[[ Flush | Line: 268 | Upvalues: processPending (copy) ]]
	while true do
		if not (if p1._nextPendingIndex <= #p1._pendingInstances then true elseif #p1._pendingTraversals > 0 then true else false) then
			break
		end

		processPending(p1)
	end
end
function t.IsIdle(p1) --[[ IsIdle | Line: 274 ]]
	local v1 = not p1._workerRunning

	if v1 then
		v1 = not (if p1._nextPendingIndex <= #p1._pendingInstances then true else #p1._pendingTraversals > 0)
	end

	return v1
end
function t.Destroy(p1) --[[ Destroy | Line: 278 ]]
	if not p1._destroyed then
		p1._destroyed = true
		p1._workerRunning = false
		table.clear(p1._pendingInstances)
		table.clear(p1._pendingKinds)
		table.clear(p1._pendingTraversals)
		p1._nextPendingIndex = 1
	end
end

return t