-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Library.Signal)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)

require(ReplicatedStorage.Library.Util.HumanoidStats.Types.Stats)

local StatsKernel = require(ReplicatedStorage.Library.Util.HumanoidStats.Kernel.StatsKernel)
local BASE_WALK_SPEED = Constants.BASE_WALK_SPEED
local SpeedChanged = Signal.MAP.Server.Kernel.SpeedChanged
local t = {}

t.__index = t
function t.new(p1) --[[ new | Line: 37 | Upvalues: BASE_WALK_SPEED (copy), Asserts (copy), t (copy), StatsKernel (copy), SpeedChanged (copy), Signal (copy) ]]
	local v1 = if p1 then p1 else BASE_WALK_SPEED

	Asserts.finite(v1)
	Asserts.cond(v1 > 0)

	local v4 = setmetatable({}, t)

	v4._baseSpeed = v1
	v4._kernel = StatsKernel.new(v1, SpeedChanged, t._speedPolicy)
	v4._humanoid = nil
	Signal.Fired(v4._kernel.Changed):Connect(function(p1) --[[ Line: 49 | Upvalues: v4 (copy) ]]
		v4:_onSpeedChanged(p1)
	end)

	return v4
end
function t._speedPolicy(p1, p2) --[[ _speedPolicy | Line: 57 | Upvalues: Asserts (copy) ]]
	Asserts.finite(p1)
	Asserts.table(p2)

	local list = {}
	local sum = 0

	for i, v in ipairs(p2) do
		if v.type == "positive" then
			sum = sum + v.value

			continue
		end

		if v.type == "malus" then
			table.insert(list, v.value)
		end
	end

	local v1 = p1 * (sum + 1)

	for i, v in ipairs(list) do
		v1 = v1 * (v + 1)
	end

	return math.max(0, v1)
end
function t.SetHumanoid(p1, p2) --[[ SetHumanoid | Line: 82 | Upvalues: Asserts (copy) ]]
	Asserts.optional.Humanoid(p2)

	if p1._humanoid ~= p2 then
		p1._humanoid = p2
		p1:_updateHumanoid()
	end
end
function t.GetValue(p1) --[[ GetValue | Line: 93 ]]
	return p1._kernel:GetValue()
end
function t.AddModifier(p1, p2, p3, p4, p5) --[[ AddModifier | Line: 97 | Upvalues: Asserts (copy) ]]
	Asserts.string(p2)
	Asserts.cond(if p3 == "positive" then true elseif p3 == "malus" then true else false)
	Asserts.finite(p4)
	Asserts.optional.string(p5)
	p1._kernel:AddModifier({
		id = p2,
		type = p3,
		value = p4,
		source = p5
	})
end
function t.RemoveModifier(p1, p2) --[[ RemoveModifier | Line: 111 | Upvalues: Asserts (copy) ]]
	Asserts.string(p2)
	p1._kernel:RemoveModifier(p2)
end
function t.RemoveModifiersBySource(p1, p2) --[[ RemoveModifiersBySource | Line: 116 | Upvalues: Asserts (copy) ]]
	Asserts.string(p2)
	p1._kernel:RemoveModifiersBySource(p2)
end
function t.GetBaseSpeed(p1) --[[ GetBaseSpeed | Line: 121 ]]
	return p1._baseSpeed
end
function t.SetBaseSpeed(p1, p2) --[[ SetBaseSpeed | Line: 125 | Upvalues: Asserts (copy) ]]
	Asserts.finite(p2)
	Asserts.cond(if p2 > 0 then true else false)
	p1._baseSpeed = p2
	p1._kernel:SetBase(p2)
end
function t.GetModifiers(p1) --[[ GetModifiers | Line: 133 ]]
	return p1._kernel:GetModifiers()
end
function t._onSpeedChanged(p1, p2) --[[ _onSpeedChanged | Line: 137 ]]
	p1:_updateHumanoid()
end
function t._updateHumanoid(p1) --[[ _updateHumanoid | Line: 141 ]]
	if p1._humanoid then
		p1._humanoid.WalkSpeed = p1:GetValue()
	end
end
function t.Destroy(p1) --[[ Destroy | Line: 150 ]]
	p1._humanoid = nil
end

return t