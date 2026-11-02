-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "ban",
	["Aliases"] = {},
	["Description"] = "ban player.",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "username",
			["Name"] = "player name",
			["Description"] = "Player to ban (FULL NAME)."
		},
		{
			["Type"] = "string",
			["Name"] = "reason",
			["Description"] = "reason."
		},
		{
			["Type"] = "integer",
			["Name"] = "duration",
			["Optional"] = true,
			["Description"] = "duration (seconds)."
		}
	}
}
return v1