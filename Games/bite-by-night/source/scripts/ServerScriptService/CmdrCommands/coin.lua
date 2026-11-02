-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "fazcoins",
	["Aliases"] = { "coins" },
	["Description"] = "Give players an amount of Fazcoins.",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "Players",
			["Description"] = "Players to give too."
		},
		{
			["Type"] = "number",
			["Name"] = "Coins",
			["Description"] = "Amount of Coins."
		}
	}
}
return v1