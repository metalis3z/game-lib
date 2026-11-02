-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "kick",
	["Aliases"] = {},
	["Description"] = "kick player.",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "players",
			["Description"] = "Players."
		},
		{
			["Type"] = "string",
			["Name"] = "reason",
			["Description"] = "reason."
		}
	}
}
return v1