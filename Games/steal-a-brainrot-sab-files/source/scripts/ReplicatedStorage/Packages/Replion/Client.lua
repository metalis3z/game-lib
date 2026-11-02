

local RunService = game:GetService("RunService")
local Utils = require(script.Parent.Internal.Utils)
local Signal = require(script.Parent.Parent.Signal)
local Network = require(script.Parent.Internal.Network)
local ClientReplion = require(script.ClientReplion)

require(script.Parent.Internal.Types)

local t1 = {}
local t2 = {}
local t3 = {}
local v9 = Signal.new()
local v10 = Signal.new()

local function getWaitList(s1: string)
	local v23 = t2[s1]

	if not v23 then
		v23 = {}
		t2[s1] = v23
	end

	return assert(v23, "Invalid wait list")
end
local function cancelWait(t4: {[any]: any}, p1: thread)
	for v26, v27 in t4 do
		if p1 == v27.thread then
			table.remove(t4, v26)

			if v27.async then
				Utils.safeCancelThread(p1)
			else
				pcall(task.spawn, p1)
			end

			t3[p1] = nil

			return
		end
	end
end
local function createTimeout(t5: {[any]: any}, n1: number, p2: thread)
	return task.delay(n1, cancelWait, t5, p2)
end
local function createReplion(p3)
	local v32 = p3[2]

	if t1[v32] then
		return
	end

	local v33 = ClientReplion.new(p3)

	t1[v32] = v33
	t1[p3[1]] = v33
	v9:Fire(v33)

	local v34 = t2[v32]

	if v34 then
		for _, v36 in v34 do
			if coroutine.status(v36.thread) == "suspended" then
				task.spawn(v36.thread, v33)
			end
		end

		t2[v32] = nil
	end
end

local t6 = {
	OnReplionAdded = function(_, p5)
		return v9:Connect(p5)
	end,
	OnReplionRemoved = function(_, p7)
		return v10:Connect(p7)
	end,
	OnReplionAddedWithTag = function(p8, p9, p10)
		return p8:OnReplionAdded(function(p11)
			local Tags = p11.Tags

			if Tags and table.find(Tags, p9) ~= nil then
				p10(p11)
			end
		end)
	end,
	OnReplionRemovedWithTag = function(p12, p13, p14)
		return p12:OnReplionRemoved(function(p15)
			local Tags = p15.Tags

			if Tags and table.find(Tags, p13) ~= nil then
				p14(p15)
			end
		end)
	end,
	GetReplion = function(_, p17)
		return t1[p17]
	end,
	WaitReplion = function(_, p19, p20)
		local v52 = t1[p19]

		if v52 then
			return v52
		end

		local thread = coroutine.running()
		local v54 = t2[p19]

		if not v54 then
			v54 = {}
			t2[p19] = v54
		end

		local v55 = assert(v54, "Invalid wait list")

		if p20 then
			t3[thread] = task.delay(p20, cancelWait, v55, thread)
		end

		table.insert(v55, {
			thread = thread
		})

		return coroutine.yield()
	end,
	AwaitReplion = function(_, p22, p23, p24)
		local v60 = t1[p22]

		if v60 then
			return p23(v60)
		end

		local v61 = t2[p22]

		if not v61 then
			v61 = {}
			t2[p22] = v61
		end

		local v62 = assert(v61, "Invalid wait list")
		local co = coroutine.create(p23)

		if p24 then
			t3[co] = task.delay(p24, cancelWait, v62, co)
		end

		table.insert(v62, {
			async = true,
			thread = co
		})

		return function()
			cancelWait(v62, co)
		end
	end
}

if not Utils.ShouldMock and RunService:IsClient() then
	local v16 = Network.get("Added")
	local v17 = Network.get("Removed")
	local v18 = Network.get("Update")
	local v19 = Network.get("Set")
	local v20 = Network.get("UpdateReplicateTo")
	local v21 = Network.get("ArrayUpdate")

	v16.OnClientEvent:Connect(function(p25)
		if type(p25[1]) == "table" then
			for _, v66 in p25 do
				createReplion(v66)
			end

			return
		end

		createReplion(p25)
	end)
	v17.OnClientEvent:Connect(function(s2: string)
		local v68 = t1[s2]

		if v68 then
			t1[s2] = nil
			t1[v68._channel] = nil
			v10:Fire(v68)
			v68:Destroy()
		end
	end)
	v18.OnClientEvent:Connect(function(s3: string, p26, p27, b1: boolean?)
		local v73 = t1[s3]

		if v73 then
			v73:_update(p26, p27, b1)
		end
	end)
	v20.OnClientEvent:Connect(function(s4: string, p28)
		local v76 = t1[s4]

		if v76 then
			v76.ReplicateTo = p28
		end
	end)
	v19.OnClientEvent:Connect(function(s5: string, p29, p30)
		local v80 = t1[s5]

		if v80 then
			v80:_set(p29, p30)
		end
	end)
	v21.OnClientEvent:Connect(function(s6: string, s7: string, ...)
		local v83 = t1[s6]

		if v83 then
			if s7 == "i" then
				v83:_insert(...)

				return
			end

			if s7 == "r" then
				v83:_remove(...)

				return
			end

			if s7 == "c" then
				v83:_clear(...)
			end
		end
	end)
end

return table.freeze(t6)
