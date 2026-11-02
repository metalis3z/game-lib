-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

return {
	DisplayName = "",
	Icon = "",
	Desc = "",
	Rarity = require(ReplicatedStorage.Directory.Rarity).Rarities.Basic,
	Sounds = {
		Single = {
			Ids = { "rbxassetid://122083641072193" },
			Data = {
				Volume = 0.5,
				Speed = { 0.95, 1.05 }
			}
		}
	}
}