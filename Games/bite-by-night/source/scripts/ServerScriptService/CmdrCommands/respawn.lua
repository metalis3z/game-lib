-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "respawn",
	["Aliases"] = { "re" },
	["Description"] = "respawn players.",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "players",
			["Description"] = "Players to respawn."
		}
	}
}
return v1