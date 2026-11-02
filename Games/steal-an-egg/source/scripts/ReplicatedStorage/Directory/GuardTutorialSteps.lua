-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Library.Types.GuardTutorial)

local v1 = table.freeze({ "StealEgg", "HeadToPen", "EquipEgg", "PlaceEgg", "HatchEgg", "PlacePet", "ExpandPen", "TreadmillIntro" })
local t = {}

for i, v in ipairs(v1) do
	t[v] = i
end

table.freeze(t)

local t2 = {
	GetOrderedStepIds = function() --[[ GetOrderedStepIds | Line: 36 | Upvalues: v1 (copy) ]]
		return v1
	end,
	GetFirstStepId = function() --[[ GetFirstStepId | Line: 40 | Upvalues: v1 (copy) ]]
		return v1[1]
	end,
	GetIndex = function(p1) --[[ GetIndex | Line: 44 | Upvalues: t (copy) ]]
		return t[p1]
	end
}

function t2.GetNextStepId(p1) --[[ GetNextStepId | Line: 48 | Upvalues: t2 (copy), v1 (copy) ]]
	local v12 = t2.GetIndex(p1)

	if v12 == nil then
		return nil
	end

	return v1[v12 + 1]
end

return t2