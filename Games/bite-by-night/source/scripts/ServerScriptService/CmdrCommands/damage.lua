-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "damage",
	["Aliases"] = { "dmg" },
	["Description"] = "Hurt",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "Players",
			["Description"] = "Players to give no cooldown."
		},
		{
			["Type"] = "number",
			["Name"] = "Damage",
			["Description"] = "Amount of Damage."
		}
	}
}
return v1