-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "exp",
	["Aliases"] = {},
	["Description"] = "Give players an amount of exp.",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "Players",
			["Description"] = "Players to give too."
		},
		{
			["Type"] = "number",
			["Name"] = "EXP",
			["Description"] = "Amount of exp."
		}
	}
}
return v1