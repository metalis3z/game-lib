-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "nocooldown",
	["Aliases"] = { "nc" },
	["Description"] = "Cooldowns?",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "Players",
			["Description"] = "Players to give no cooldown."
		},
		{
			["Type"] = "boolean",
			["Name"] = "Enabled",
			["Description"] = "On or Off."
		}
	}
}
return v1