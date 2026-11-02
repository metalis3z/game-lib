-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "deload",
	["Aliases"] = {},
	["Description"] = "Lock a character from being playable.",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "Asset to load",
			["Description"] = "Characters to make private."
		}
	}
}
return v1