-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Library.Types.EggItem)

local UnpackCFrame = require(ReplicatedStorage.Library.Functions.UnpackCFrame)
local PackCFrame = require(ReplicatedStorage.Library.Functions.PackCFrame)

return {
	Serialize = function(p1) --[[ Serialize | Line: 14 | Upvalues: UnpackCFrame (copy) ]]
		local t = {
			EggName = p1.EggName,
			IsFavorite = p1.IsFavorite
		}

		t.CFrame = p1.CFrame and UnpackCFrame(p1.CFrame) or nil
		t.TimeToHatch = p1.TimeToHatch
		t.HatchEndTime = p1.HatchEndTime
		t.IsActive = p1.IsActive
		t.SlotIndex = p1.SlotIndex
		t.Scale = p1.Scale

		return t
	end,
	Deserialize = function(p1) --[[ Deserialize | Line: 27 | Upvalues: PackCFrame (copy) ]]
		local t = {
			EggName = p1.EggName,
			IsFavorite = p1.IsFavorite
		}

		t.CFrame = p1.CFrame and PackCFrame(p1.CFrame) or nil
		t.TimeToHatch = p1.TimeToHatch
		t.HatchEndTime = p1.HatchEndTime
		t.IsActive = p1.IsActive
		t.SlotIndex = p1.SlotIndex
		t.Scale = p1.Scale

		return t
	end
}