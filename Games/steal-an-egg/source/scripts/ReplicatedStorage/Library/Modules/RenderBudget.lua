-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)

require(script.Types.Interface)

local t = {}

t.__index = t
t.__class = "RenderBudget"

local v1 = Log.new()

function t.new(p1) --[[ new | Line: 47 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.optional.table(p1)

	local v1 = if p1 and p1.MaxJobsPerStep then p1.MaxJobsPerStep else 4
	local v2 = if p1 and p1.MaxStepTime then p1.MaxStepTime else 0.004166666666666667
	local v3 = if p1 and p1.StepInterval then p1.StepInterval else 0.016666666666666666
	local v4 = if p1 then p1.TargetSpreadSeconds else nil
	local v5 = if p1 and p1.SpreadMinJobs then p1.SpreadMinJobs else 2
	local v6 = if p1 and p1.Name then p1.Name else "RenderBudget"

	Asserts.string(v6)
	Asserts.positiveInteger(v1)
	Asserts.number(v2)
	Asserts.number(v3)
	Asserts.positiveInteger(v5)
	Asserts.optional.number(v4)
	assert(v2 > 0, "RenderBudget MaxStepTime must be greater than 0")
	assert(if v3 > 0 then true else false, "RenderBudget StepInterval must be greater than 0")
	assert(if v4 == nil then true elseif v4 > 0 then true else false, "RenderBudget TargetSpreadSeconds must be greater than 0")

	local v11 = setmetatable({}, t)

	v11._name = v6
	v11._maxJobsPerStep = v1
	v11._maxStepTime = v2
	v11._stepInterval = v3
	v11._targetSpreadSeconds = v4
	v11._spreadMinJobs = v5
	v11._activeSpreadInterval = nil
	v11._pendingJobs = {}
	v11._pendingByKey = {}
	v11._nextPendingIndex = 1
	v11._workerRunning = false
	v11._destroyed = false

	return v11
end
function t._hasPendingWork(p1) --[[ _hasPendingWork | Line: 93 ]]
	return p1._nextPendingIndex <= #p1._pendingJobs
end
function t._getPendingCount(p1) --[[ _getPendingCount | Line: 97 ]]
	return math.max(0, #p1._pendingJobs - p1._nextPendingIndex + 1)
end
function t._refreshSpreadInterval(p1) --[[ _refreshSpreadInterval | Line: 101 ]]
	if p1._targetSpreadSeconds == nil then
		return
	end

	local v1 = p1:_getPendingCount()

	if v1 < p1._spreadMinJobs then
		return
	end

	local v5 = p1._targetSpreadSeconds / math.max(1, (math.ceil(v1 / p1._maxJobsPerStep)))

	if p1._activeSpreadInterval ~= nil and not (v5 < p1._activeSpreadInterval) then
		return
	end

	p1._activeSpreadInterval = v5
end
function t._compactPending(p1) --[[ _compactPending | Line: 118 ]]
	if not (p1._nextPendingIndex <= #p1._pendingJobs) then
		table.clear(p1._pendingJobs)
		p1._nextPendingIndex = 1
	end
end
function t._runJob(p1, p2) --[[ _runJob | Line: 127 | Upvalues: v1 (copy) ]]
	if p2.Cancelled or p1._pendingByKey[p2.Key] ~= p2 then
		return
	end

	p1._pendingByKey[p2.Key] = nil

	local t = { pcall(p2.Callback) }

	if t[1] then
		return
	end

	v1:AtError():Log((("%* job failed for %*: %*"):format(p1._name, p2.Key, t[2])))
end
function t._processPending(p1) --[[ _processPending | Line: 141 ]]
	local v1 = os.clock()
	local count = 0

	while p1._nextPendingIndex <= #p1._pendingJobs and (count < p1._maxJobsPerStep and not (os.clock() - v1 >= p1._maxStepTime)) do
		local v2 = p1._pendingJobs[p1._nextPendingIndex]

		p1._pendingJobs[p1._nextPendingIndex] = nil
		p1._nextPendingIndex = p1._nextPendingIndex + 1
		p1:_runJob(v2)
		count = count + 1
	end

	p1:_compactPending()
end
function t._ensureWorker(p1) --[[ _ensureWorker | Line: 161 ]]
	if not (p1._workerRunning or p1._destroyed) then
		p1._workerRunning = true
		task.defer(function() --[[ Line: 167 | Upvalues: p1 (copy) ]]
			local v1 = 0

			while not p1._destroyed and p1:_hasPendingWork() do
				p1:_refreshSpreadInterval()

				local v2 = v1 - os.clock()

				if v2 > 0 then
					task.wait(v2)
				end

				p1:_processPending()

				local v3 = os.clock()

				v1 = v3 + (p1._activeSpreadInterval or p1._stepInterval)
			end

			p1._activeSpreadInterval = nil
			p1._workerRunning = false

			if p1._destroyed or not p1:_hasPendingWork() then
				return
			end

			p1:_ensureWorker()
		end)
	end
end
function t.Queue(p1, p2, p3) --[[ Queue | Line: 194 | Upvalues: Asserts (copy) ]]
	Asserts.string(p2)
	Asserts.func(p3)
	assert(if p2 == "" then false else true, "RenderBudget key must be non-empty")
	assert(not p1._destroyed, "Cannot queue into destroyed RenderBudget")

	local v3 = p1._pendingByKey[p2]
	local v4, v5

	if v3 == nil then
		v4 = {
			Cancelled = false,
			Key = p2,
			Callback = p3
		}
		p1._pendingByKey[p2] = v4
		v5 = p1._pendingJobs
		table.insert(v5, v4)
		p1:_ensureWorker()

		return
	end

	v3.Cancelled = true
	v4 = {
		Cancelled = false,
		Key = p2,
		Callback = p3
	}
	p1._pendingByKey[p2] = v4
	v5 = p1._pendingJobs
	table.insert(v5, v4)
	p1:_ensureWorker()
end
function t.Cancel(p1, p2) --[[ Cancel | Line: 215 | Upvalues: Asserts (copy) ]]
	Asserts.string(p2)

	local v1 = p1._pendingByKey[p2]

	if v1 ~= nil then
		v1.Cancelled = true
		p1._pendingByKey[p2] = nil
	end
end
function t.CancelAll(p1) --[[ CancelAll | Line: 227 ]]
	for k, v in pairs(p1._pendingByKey) do
		v.Cancelled = true
		p1._pendingByKey[k] = nil
	end
end
function t.Flush(p1) --[[ Flush | Line: 234 ]]
	while p1:_hasPendingWork() do
		p1:_processPending()
	end
end
function t.Destroy(p1) --[[ Destroy | Line: 240 ]]
	if not p1._destroyed then
		p1:CancelAll()
		p1._destroyed = true
		p1._workerRunning = false
		table.clear(p1._pendingJobs)
		p1._nextPendingIndex = 1
	end
end

return t