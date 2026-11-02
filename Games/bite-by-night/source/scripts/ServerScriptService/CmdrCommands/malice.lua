-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "malice",
	["Aliases"] = {},
	["Description"] = "Chance to be killer.",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "Players",
			["Description"] = "Players to set malice too."
		},
		{
			["Type"] = "number",
			["Name"] = "Amount",
			["Description"] = "Amount of malice given."
		}
	}
}
return v1