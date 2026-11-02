-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "join",
	["Aliases"] = { "jo" },
	["Description"] = "join in game.",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "players",
			["Description"] = "Players to respawn."
		},
		{
			["Type"] = "gameteams",
			["Name"] = "Team",
			["Description"] = "Team to join."
		}
	}
}
return v1