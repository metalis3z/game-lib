-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "effect",
	["Aliases"] = {},
	["Description"] = "give a player a status effect",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "Players",
			["Description"] = "Players to give the effects too."
		},
		{
			["Type"] = "string",
			["Name"] = "Effect Name",
			["Description"] = "Name of the Effect."
		},
		{
			["Type"] = "number",
			["Name"] = "Duration",
			["Description"] = "The Duration of the effect."
		},
		{
			["Type"] = "number",
			["Name"] = "Multiplier",
			["Description"] = "The Multiplier of the effect."
		}
	}
}
return v1