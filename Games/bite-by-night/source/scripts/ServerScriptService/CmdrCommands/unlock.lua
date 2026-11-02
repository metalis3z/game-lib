-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "unlock",
	["Aliases"] = { "un" },
	["Description"] = "Unlock certain Emotes, Character, and or Skins for players.",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "Players",
			["Description"] = "Players to set Characters too."
		},
		{
			["Type"] = "string",
			["Name"] = "Type",
			["Description"] = "EMOTE , CHARACTER , SKIN."
		},
		{
			["Type"] = "character",
			["Name"] = "Character",
			["Description"] = "Character of asset."
		},
		{
			["Type"] = "string",
			["Name"] = "Asset",
			["Optional"] = true,
			["Description"] = "Name of asset to give."
		}
	}
}
return v1