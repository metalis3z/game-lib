

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Freeze = require(script.Parent.Parent.Freeze)
local Utils = require(script.Parent.Internal.Utils)
local Network = require(script.Parent.Internal.Network)
local ServerReplion = require(script.ServerReplion)
local Signal = require(script.Parent.Parent.Signal)

require(script.Parent.Internal.Types)

local v8 = Signal.new()
local v9 = Signal.new()
local t1 = {}
local t2 = {}
local t3 = {}
local t4 = {}

local function getCache(t5: {[any]: any}, p1)
	local v23 = t5[p1]

	if not v23 then
		v23 = {}
		t5[p1] = v23
	end

	return v23
end
local function cancelWait(t6: {[any]: any}, p2: thread)
	for v26, v27 in t6 do
		if p2 == v27.thread then
			table.remove(t6, v26)

			if v27.async then
				Utils.safeCancelThread(p2)
			else
				pcall(task.spawn, p2)
			end

			t4[p2] = nil

			return
		end
	end
end
local function createTimeout(t7: {[any]: any}, n1: number, p3: thread)
	return task.delay(n1, cancelWait, t7, p3)
end

local t11 = {
	new = function(p4)
		local v32 = assert(p4.Channel, "Channel is required!")
		local v33 = t1
		local v34 = v33[v32]

		if not v34 then
			v34 = {}
			v33[v32] = v34
		end

		local v35 = v34
		local ReplicateTo = p4.ReplicateTo

		for _, v38 in v35 do
			local ReplicateTo2 = v38.ReplicateTo
			local v40 = ReplicateTo2 == ReplicateTo

			if not v40 and type(ReplicateTo2) == "table" and type(ReplicateTo) == "table" then
				for _, v42 in ReplicateTo2 do
					v40 = table.find(ReplicateTo, v42) ~= nil

					if v40 then
						break
					end
				end
			end

			if v40 then
				local str = nil

				if typeof(ReplicateTo2) == "Instance" or typeof(ReplicateTo2) == "userdata" then
					str = tostring(ReplicateTo2)
				elseif type(ReplicateTo2) == "string" then
					str = ReplicateTo2
				elseif type(ReplicateTo2) == "table" then
					for _, v45 in ReplicateTo2 do
						str = (not str and "" or str .. ", ") .. tostring(v45)
					end
				end

				error(`Channel "{ v32 }" already exists! for "{ str }"`)
			end
		end

		local u46 = ServerReplion.new(p4)

		u46:BeforeDestroy(function()
			v35[u46._id] = nil

			if not next(v35) then
				t1[v32] = nil
			end

			v9:Fire(v32, u46)
			u46 = nil
		end)
		u46._replicateToChanged:Connect(function(p5, p6)
			if typeof(p6) == "Instance" and p6:IsA("Player") then
				local v138 = t3[p6]

				if v138 then
					v138[v32] = nil
				end
			elseif typeof(p6) == "table" then
				for _, v140 in p6 do
					local v141 = t3[v140]

					if v141 then
						v141[v32] = nil
					end
				end
			end

			if typeof(p5) == "Instance" and p5:IsA("Player") then
				local v142 = t3
				local v143 = v142[p5]

				if not v143 then
					v143 = {}
					v142[p5] = v143
				end

				v143[v32] = u46._id

				return
			end

			if typeof(p5) == "table" then
				for _, v145 in p5 do
					local v146 = t3
					local v147 = v146[v145]

					if not v147 then
						v147 = {}
						v146[v145] = v147
					end

					v147[v32] = u46._id
				end
			end
		end)
		v35[u46._id] = u46
		v8:Fire(v32, u46)

		if typeof(ReplicateTo) == "Instance" or Utils.ShouldMock and typeof(ReplicateTo) == "userdata" then
			local v47 = t3
			local v48 = v47[ReplicateTo]

			if not v48 then
				v48 = {}
				v47[ReplicateTo] = v48
			end

			v48[v32] = u46._id
		elseif type(ReplicateTo) == "table" then
			for _, v50 in ReplicateTo do
				local v51 = t3
				local v52 = v51[v50]

				if not v52 then
					v52 = {}
					v51[v50] = v52
				end

				v52[v32] = u46._id
			end
		end

		local v53 = t2[v32]

		if v53 then
			for i = #v53, 1, -1 do
				local v55 = v53[i]
				local thread = v55.thread
				local player = v55.player

				if player then
					local v58 = false

					if typeof(ReplicateTo) == "Instance" or typeof(ReplicateTo) == "userdata" then
						v58 = ReplicateTo == player
					elseif type(ReplicateTo) == "table" then
						v58 = table.find(ReplicateTo, player) ~= nil
					end

					if not v58 then
						continue
					end
				end

				local v59 = t4[thread]

				if v59 then
					Utils.safeCancelThread(v59)
					t4[thread] = nil
				end

				if coroutine.status(thread) == "suspended" then
					task.spawn(thread, u46)
				end

				table.remove(v53, i)
			end
		end

		return u46
	end,
	GetReplion = function(_: {[any]: any}, s1: string)
		local v62 = t1[s1]

		if not v62 then
			return nil
		end

		assert(Freeze.Dictionary.count(v62) == 1, `There are multiple replions with the channel "{ s1 }". Did you mean to use GetReplionFor?`)

		local _, v64 = next(v62)

		return v64
	end,
	GetReplionFor = function(_, p8, p9)
		local v68 = t1[p9]

		if not v68 then
			return nil
		end

		local v69 = t3[p8]

		if not v69 then
			return nil
		end

		return v68[v69[p9]]
	end,
	GetReplionsFor = function(_, p11)
		local t9 = {}

		for _, v74 in t1 do
			for _, v76 in v74 do
				local ReplicateTo = v76.ReplicateTo

				if ReplicateTo == "All" or if type(ReplicateTo) ~= "table" then ReplicateTo == p11 else table.find(ReplicateTo, p11) ~= nil then
					table.insert(t9, v76)
				end
			end
		end

		return t9
	end,
	WaitReplion = function(p12, p13, p14)
		local Replion = p12:GetReplion(p13)

		if Replion then
			return Replion
		end

		local thread = coroutine.running()
		local v83 = t2
		local v84 = v83[p13]

		if not v84 then
			v84 = {}
			v83[p13] = v84
		end

		if p14 then
			t4[thread] = task.delay(p14, cancelWait, v84, thread)
		end

		table.insert(v84, {
			thread = thread
		})

		return coroutine.yield()
	end,
	WaitReplionFor = function(t10: {[any]: any}, p15, s2: string, n2: number?)
		local ReplionFor = t10:GetReplionFor(p15, s2)

		if ReplionFor then
			return ReplionFor
		end

		if typeof(p15) == "Instance" and not p15:IsDescendantOf(Players) then
			if _G.__DEV__ then
				local v90, v91 = debug.info(2, "sl")

				warn(`Warning: Trying to wait for a player that is not in the game at { v90 }:{ v91 }`)
			end

			return nil
		end

		local thread = coroutine.running()
		local v93 = t2
		local v94 = v93[s2]

		if not v94 then
			v94 = {}
			v93[s2] = v94
		end

		if n2 then
			t4[thread] = task.delay(n2, cancelWait, v94, thread)
		end

		table.insert(v94, {
			thread = thread,
			player = p15
		})

		return coroutine.yield()
	end,
	AwaitReplion = function(p16, p17, p18, p19)
		local Replion = p16:GetReplion(p17)

		if Replion then
			return p18(Replion)
		end

		local v100 = t2
		local v101 = v100[p17]

		if not v101 then
			v101 = {}
			v100[p17] = v101
		end

		local v102 = v101
		local co = coroutine.create(p18)

		if p19 then
			t4[co] = task.delay(p19, cancelWait, v102, co)
		end

		table.insert(v102, {
			async = true,
			thread = co
		})

		return function()
			cancelWait(v102, co)
		end
	end,
	AwaitReplionFor = function(p20, p21, p22, p23, p24)
		local ReplionFor = p20:GetReplionFor(p21, p22)

		if ReplionFor then
			return p23(ReplionFor)
		end

		if typeof(p21) == "Instance" and p21.Parent == nil then
			if _G.__DEV__ then
				local v110, v111 = debug.info(2, "sl")

				warn(`Warning: Trying to await for a player that is not in the game at { v110 }:{ v111 }`)
			end

			return nil
		end

		local v112 = t2
		local v113 = v112[p22]

		if not v113 then
			v113 = {}
			v112[p22] = v113
		end

		local v114 = v113
		local co = coroutine.create(p23)

		if p24 then
			t4[co] = task.delay(p24, cancelWait, v114, co)
		end

		table.insert(v114, {
			async = true,
			thread = co,
			player = p21
		})

		return function()
			cancelWait(v114, co)
		end
	end,
	OnReplionAdded = function(_, p26)
		return v8:Connect(p26)
	end,
	OnReplionRemoved = function(_, p28)
		return v9:Connect(p28)
	end
}

if not Utils.ShouldMock and RunService:IsServer() then
	Network.create({
		"Added",
		"Removed",
		"Update",
		"UpdateReplicateTo",
		"Set",
		"ArrayUpdate"
	})

	local function onPlayerAdded(p29)
		local t12 = {}

		for _, v123 in (t11:GetReplionsFor(p29)) do
			table.insert(t12, v123:_serialize())
		end

		if #t12 > 0 then
			Network.sendTo(p29, "Added", t12)
		end
	end

	for _, player in Players:GetPlayers() do
		task.spawn(onPlayerAdded, player)
	end

	Players.PlayerAdded:Connect(onPlayerAdded)
	Players.PlayerRemoving:Connect(function(player)
		local t13 = {}

		for _, v127 in t1 do
			for _, v129 in v127 do
				local ReplicateTo = v129.ReplicateTo

				if ReplicateTo ~= "All" then
					if type(ReplicateTo) == "table" then
						v129:SetReplicateTo(Freeze.List.removeValue(ReplicateTo, player))
					elseif ReplicateTo == player then
						if not v129.DisableAutoDestroy then
							v129:Destroy()
						else
							v129:BeforeDestroy(function()
								local v148 = table.find(t13, v129)

								if not v148 then
									return
								end

								table.remove(t13, v148)

								if #t13 == 0 then
									t3[player] = nil
								end
							end)
							table.insert(t13, v129)
						end
					end
				end
			end
		end

		if #t13 == 0 then
			t3[player] = nil
		end

		for v131, v132 in t2 do
			for i = #v132, 1, -1 do
				local v134 = v132[i]
				local thread = v134.thread

				if player == v134.player then
					if v134.async then
						Utils.safeCancelThread(thread)
					else
						pcall(task.spawn, thread)
					end

					t4[thread] = nil
					table.remove(v132, i)
				end
			end

			if #v132 == 0 then
				t2[v131] = nil
			end
		end
	end)
end

return t11
