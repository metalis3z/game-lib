-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AbstractItem = require(script.Parent.AbstractItem)
local Rarity = require(ReplicatedStorage.Directory.Rarity)
local t = {}
local v1 = setmetatable({
	StackLimit = 1,
	LockingEnabled = false,
	TradingEnabled = false,
	CreationTimeEnabled = false,
	CreationUserEnabled = false,
	OwnerCountEnabled = false,
	OwnerLogEnabled = false,
	NicknameEnabled = false,
	SignedByEnabled = false
}, {
	__index = AbstractItem.Prototype
})
local v2, v3 = AbstractItem.Define("SpeedPower", script, t)

v1.Class = v2
t.Class = v2
t.Prototype = v1

local function newSpeedPower(p1) --[[ newSpeedPower | Line: 51 | Upvalues: v3 (copy), t (copy) ]]
	return v3.From(t, {})
end

function v1.AbstractGetMaxAmount(p1) --[[ AbstractGetMaxAmount | Line: 55 ]]
	return (1 / 0)
end
function v1.GetName(p1) --[[ GetName | Line: 59 ]]
	return "Speed Power"
end
function v1.GetDesc(p1) --[[ GetDesc | Line: 63 ]]
	return "SPEED"
end
function v1.GetIcon(p1) --[[ GetIcon | Line: 67 ]]
	return "rbxassetid://99458650446228"
end
function v1.GetRarity(p1) --[[ GetRarity | Line: 71 | Upvalues: Rarity (copy) ]]
	return Rarity.Rarities.Rare
end
function v1.Directory(p1) --[[ Directory | Line: 75 ]]
	return {}
end
function v1.GetValue(p1) --[[ GetValue | Line: 79 ]]
	local value = p1._data.value

	if typeof(value) == "number" then
		return value
	end

	return 0
end

return setmetatable(t, {
	__index = v3,
	__call = newSpeedPower
})