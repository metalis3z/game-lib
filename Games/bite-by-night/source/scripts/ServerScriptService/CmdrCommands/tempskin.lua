-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "tempskin",
	["Aliases"] = {},
	["Description"] = "Apply a skin that gets removed on leave.",
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