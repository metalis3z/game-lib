-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "skin",
	["Aliases"] = {},
	["Description"] = "Skin applied to a character.",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "Players",
			["Description"] = "Players to set skins."
		},
		{
			["Type"] = "character",
			["Name"] = "Character",
			["Description"] = "Character to apply to."
		},
		{
			["Type"] = "string",
			["Optional"] = true,
			["Name"] = "Skin to use",
			["Description"] = "type full name"
		}
	}
}
return v1