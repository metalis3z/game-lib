-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Library.Signal)
local Asserts = require(ReplicatedStorage.Library.Asserts)

require(ReplicatedStorage.Library.Util.HumanoidStats.Types.Stats)

local t = {}

t.__index = t
function t.new(p1, p2, p3) --[[ new | Line: 24 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.finite(p1)
	Asserts.func(p3)

	local v2 = setmetatable({}, t)

	v2._base = p1
	v2._policy = p3
	v2._modifiers = {}
	v2._value = p1
	v2.Changed = p2

	return v2
end
function t.GetBase(p1) --[[ GetBase | Line: 44 ]]
	return p1._base
end
function t.SetBase(p1, p2) --[[ SetBase | Line: 48 | Upvalues: Asserts (copy) ]]
	Asserts.finite(p2)

	if p1._base ~= p2 then
		p1._base = p2
		p1:_recalculate()
	end
end
function t.AddModifier(p1, p2) --[[ AddModifier | Line: 59 | Upvalues: Asserts (copy) ]]
	Asserts.table(p2)
	Asserts.string(p2.id)
	Asserts.cond(if p2.type == "positive" then true elseif p2.type == "malus" then true else false)
	Asserts.finite(p2.value)

	for i, v in ipairs(p1._modifiers) do
		if v.id == p2.id then
			error(string.format("Modifier with ID \'%s\' already exists", p2.id))
		end
	end

	table.insert(p1._modifiers, p2)
	p1:_recalculate()
end
function t.RemoveModifier(p1, p2) --[[ RemoveModifier | Line: 76 | Upvalues: Asserts (copy) ]]
	Asserts.string(p2)

	for i, v in ipairs(p1._modifiers) do
		if v.id == p2 then
			table.remove(p1._modifiers, i)
			p1:_recalculate()

			return
		end
	end
end
function t.RemoveModifiersBySource(p1, p2) --[[ RemoveModifiersBySource | Line: 90 | Upvalues: Asserts (copy) ]]
	Asserts.string(p2)

	local v1 = false

	for i = #p1._modifiers, 1, -1 do
		if p1._modifiers[i].source == p2 then
			table.remove(p1._modifiers, i)
			v1 = true
		end
	end

	if not v1 then
		return
	end

	p1:_recalculate()
end
function t.GetValue(p1) --[[ GetValue | Line: 108 ]]
	return p1._value
end
function t.GetModifiers(p1) --[[ GetModifiers | Line: 112 ]]
	return p1._modifiers
end
function t._recalculate(p1) --[[ _recalculate | Line: 116 | Upvalues: Signal (copy) ]]
	local v1 = p1._policy(p1._base, p1._modifiers)

	if not (math.abs(v1 - p1._value) < 0.001) then
		p1._value = v1
		Signal.Fire(p1.Changed, v1)
	end
end

return t