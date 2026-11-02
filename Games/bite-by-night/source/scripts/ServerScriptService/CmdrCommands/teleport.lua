-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "tp",
	["Aliases"] = {},
	["Description"] = "teleport 2 players.",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "player",
			["Name"] = "player 1",
			["Description"] = "Player to teleport too"
		},
		{
			["Type"] = "player",
			["Name"] = "player 2",
			["Description"] = "Player being teleported"
		}
	}
}
return v1