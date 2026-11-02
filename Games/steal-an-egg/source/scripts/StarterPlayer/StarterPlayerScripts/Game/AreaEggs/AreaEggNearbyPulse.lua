-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local EggGrowthAnimation = require(ReplicatedStorage.Library.Client.Eggs.EggGrowthAnimation)
local Player = require(ReplicatedStorage.Library.Player)
local t = {}

t.__index = t
t.__class = "AreaEggNearbyPulse"
function t.new(p1) --[[ new | Line: 44 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.Player(p1)

	local v2 = setmetatable({}, t)

	v2._player = p1
	v2._random = Random.new()
	v2._registeredByUid = {}
	v2._nextPulseAt = nil

	return v2
end
function t._scheduleNextFor(p1, p2, p3) --[[ _scheduleNextFor | Line: 60 ]]
	local v3 = assert(p1._registeredByUid[p2], (("Area egg %* must be registered before scheduling"):format(p2)))
	local v4 = p3 + p1._random:NextNumber(6, 25)

	v3.NextPulseAt = v4

	local _nextPulseAt = p1._nextPulseAt

	if _nextPulseAt ~= nil and not (v4 < _nextPulseAt) then
		return
	end

	p1._nextPulseAt = v4
end
function t._recomputeNextPulseAt(p1) --[[ _recomputeNextPulseAt | Line: 70 ]]
	local v1 = nil

	for k, v in pairs(p1._registeredByUid) do
		if v1 == nil or v.NextPulseAt < v1 then
			v1 = v.NextPulseAt
		end
	end

	p1._nextPulseAt = v1
end
function t._collectClosest(p1, p2) --[[ _collectClosest | Line: 80 ]]
	local t = {}
	local list = {}

	for k, v in pairs(p1._registeredByUid) do
		if v.Model.Parent ~= nil and v.Root.Parent ~= nil then
			local v1 = v.Root.Position - p2
			local v2 = v1:Dot(v1)

			if not (v2 > 122500) then
				local v3 = #t + 1

				for i, v4 in ipairs(list) do
					if v2 < v4 then
						v3 = i

						break
					end
				end

				if v3 <= 8 then
					table.insert(t, v3, k)
					table.insert(list, v3, v2)

					if #t > 8 then
						table.remove(t)
						table.remove(list)
					end
				end
			end
		end
	end

	return t
end
function t.Bind(p1, p2, p3, p4) --[[ Bind | Line: 120 | Upvalues: Asserts (copy), EggGrowthAnimation (copy) ]]
	Asserts.string(p2)
	Asserts.Model(p3)
	Asserts.number(p4)
	p1:Unbind(p2)

	local PrimaryPart = p3.PrimaryPart

	assert(PrimaryPart ~= nil, (("Rendered area egg %* must have a PrimaryPart"):format(p2)))

	local t = {
		NextPulseAt = 0,
		Model = p3,
		Root = PrimaryPart,
		Animation = EggGrowthAnimation.new(p3, p3:GetPivot(), 2)
	}

	p1._registeredByUid[p2] = t
	p1:_scheduleNextFor(p2, p4)

	return function() --[[ Line: 138 | Upvalues: p1 (copy), p2 (copy), t (copy) ]]
		if p1._registeredByUid[p2] ~= t then
			return
		end

		p1:Unbind(p2)
	end
end
function t.Unbind(p1, p2) --[[ Unbind | Line: 145 | Upvalues: Asserts (copy) ]]
	Asserts.string(p2)

	local v1 = p1._registeredByUid[p2]

	if v1 == nil then
		return
	end

	p1._registeredByUid[p2] = nil
	v1.Animation:Destroy()

	if not (v1.NextPulseAt == p1._nextPulseAt) then
		return
	end

	p1:_recomputeNextPulseAt()
end
function t.Step(p1, p2) --[[ Step | Line: 161 | Upvalues: Asserts (copy), Player (copy) ]]
	Asserts.number(p2)

	local _nextPulseAt = p1._nextPulseAt

	if _nextPulseAt == nil or p2 < _nextPulseAt then
		return
	end

	local v1 = Player.Optional.HumanoidRootPart(p1._player)
	local t = {}

	if v1 ~= nil then
		assert(v1:IsA("BasePart"), "Local HumanoidRootPart must be a BasePart")

		for i, v in ipairs(p1:_collectClosest(v1.Position)) do
			t[v] = true
		end
	end

	p1._nextPulseAt = nil

	for k, v in pairs(p1._registeredByUid) do
		if v.NextPulseAt <= p2 then
			p1:_scheduleNextFor(k, p2)

			if t[k] then
				v.Animation:SetBasePivot(v.Model:GetPivot())
				v.Animation:Play()
			end

			continue
		end

		if p1._nextPulseAt == nil or v.NextPulseAt < p1._nextPulseAt then
			p1._nextPulseAt = v.NextPulseAt
		end
	end
end

return t