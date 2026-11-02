-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gears = require(ReplicatedStorage.Directory.Gears)

require(ReplicatedStorage.Directory.Gears.Types.Interface)

local Rarity = require(ReplicatedStorage.Directory.Rarity)
local AbstractItem = require(script.Parent.AbstractItem)
local Signal = require(ReplicatedStorage.Library.Signal)
local t = {
	Directory = Gears.Directory
}
local v1 = setmetatable({}, {
	__index = AbstractItem.Prototype
})
local v2, v3 = AbstractItem.Define("Gear", script, t)

v1.Class = v2
t.Class = v2
t.Prototype = v1

local function newGear(p1, p2) --[[ newGear | Line: 37 | Upvalues: Gears (copy), v3 (copy), t (copy) ]]
	local v1

	if type(p2) == "string" then
		assert(Gears.Directory[p2], (("Gear not found in directory for identifier: %*"):format(p2)))
		v1 = p2
	else
		assert(Gears.Directory[p2._id] == p2, (("Gear not found in directory for ID: %*"):format(p2._id)))
		v1 = p2._id
	end

	return v3.From(t, {
		id = v1
	})
end

function v1.AbstractPopulate(p1) --[[ AbstractPopulate | Line: 56 ]] end
function v1.GetId(p1) --[[ GetId | Line: 58 ]]
	return p1._data.id
end
function v1.SetId(p1, p2) --[[ SetId | Line: 62 | Upvalues: Gears (copy) ]]
	assert(Gears.Directory[p2], (("Gear not found in directory for ID: %*"):format(p2)))
	p1._data.id = p2

	return p1
end
function v1.SetDirectory(p1, p2) --[[ SetDirectory | Line: 68 | Upvalues: Gears (copy) ]]
	local v1 = if Gears.Directory[p2._id] == p2 then true else false

	assert(v1, (("Gear not found in directory for ID: %*"):format(p2._id)))

	return p1:SetId(p2._id)
end
function v1.Directory(p1) --[[ Directory | Line: 73 | Upvalues: Gears (copy) ]]
	return Gears.Directory[p1._data.id]
end
function v1.GetName(p1) --[[ GetName | Line: 77 ]]
	return p1:Directory().DisplayName or ""
end
function v1.GetRarity(p1) --[[ GetRarity | Line: 81 | Upvalues: Rarity (copy) ]]
	local Rarity2 = p1:Directory().Rarity

	return Rarity.Rarities[Rarity2] or Rarity.Rarities.Basic
end
function v1.GetIcon(p1) --[[ GetIcon | Line: 86 ]]
	return p1:Directory().Icon or ""
end
function v1.GetDesc(p1) --[[ GetDesc | Line: 90 ]]
	return p1:Directory().Description or ""
end
function v1.ToRewardFormat(p1, p2) --[[ ToRewardFormat | Line: 94 | Upvalues: Signal (copy) ]]
	local v1 = p1:GetId()
	local v2 = p1:GetAmount()

	return function(p1) --[[ Line: 97 | Upvalues: Signal (ref), v1 (copy), v2 (copy), p2 (copy) ]]
		Signal.Fire(Signal.MAP.Server.GearInventory.ADD, p1, v1, v2, nil, nil, p2)
	end
end

return setmetatable(t, {
	__index = v3,
	__call = newGear
})