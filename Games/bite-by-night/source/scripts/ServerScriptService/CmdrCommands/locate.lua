-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "locate",
	["Aliases"] = {},
	["Description"] = "Locate a certain player across SERVERS and teleport to their SERVER.",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "Player (FULL NAME)",
			["Description"] = "The player to locate."
		}
	}
}
return v1