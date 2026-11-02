-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Library.Types.AssetEggItem)

local UnpackCFrame = require(ReplicatedStorage.Library.Functions.UnpackCFrame)
local PackCFrame = require(ReplicatedStorage.Library.Functions.PackCFrame)

return {
	Serialize = function(p1) --[[ Serialize | Line: 14 | Upvalues: UnpackCFrame (copy) ]]
		local t = {
			EggName = p1.EggName,
			Mutations = p1.Mutations,
			IsFavorite = p1.IsFavorite
		}

		t.CFrame = p1.CFrame and UnpackCFrame(p1.CFrame) or nil
		t.IsActive = p1.IsActive
		t.Scale = p1.Scale
		t.CreationTime = p1.CreationTime
		t.NestSlotIndex = p1.NestSlotIndex
		t.GrowthStartedAt = p1.GrowthStartedAt
		t.GrowthDuration = p1.GrowthDuration

		return t
	end,
	Deserialize = function(p1) --[[ Deserialize | Line: 31 | Upvalues: PackCFrame (copy) ]]
		local t = {
			EggName = p1.EggName,
			Mutations = p1.Mutations,
			IsFavorite = p1.IsFavorite
		}

		t.CFrame = p1.CFrame and PackCFrame(p1.CFrame) or nil
		t.IsActive = p1.IsActive
		t.Scale = p1.Scale
		t.CreationTime = p1.CreationTime
		t.NestSlotIndex = p1.NestSlotIndex
		t.GrowthStartedAt = p1.GrowthStartedAt
		t.GrowthDuration = p1.GrowthDuration

		return t
	end
}