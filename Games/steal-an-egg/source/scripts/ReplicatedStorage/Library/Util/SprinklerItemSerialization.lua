-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Library.Types.Sprinklers)

local PackVector3 = require(ReplicatedStorage.Library.Functions.PackVector3)
local UnpackVector3 = require(ReplicatedStorage.Library.Functions.UnpackVector3)

return {
	Serialize = function(p1) --[[ Serialize | Line: 14 | Upvalues: PackVector3 (copy) ]]
		return {
			Position = PackVector3(p1.Position),
			Remaining = p1.Remaining,
			Category = p1.Category
		}
	end,
	Deserialize = function(p1) --[[ Deserialize | Line: 24 | Upvalues: UnpackVector3 (copy) ]]
		return {
			Position = UnpackVector3(p1.Position),
			Remaining = p1.Remaining,
			Category = p1.Category
		}
	end
}