-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "stun",
	["Aliases"] = {},
	["Description"] = "Stun",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "Players",
			["Description"] = "Players to give no cooldown."
		},
		{
			["Type"] = "number",
			["Name"] = "Stun Length",
			["Description"] = "Time Stunned."
		}
	}
}
return v1