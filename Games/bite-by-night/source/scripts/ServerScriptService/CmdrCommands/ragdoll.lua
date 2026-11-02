-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "ragdoll",
	["Aliases"] = {},
	["Description"] = "Ragdoll player.",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "players",
			["Name"] = "Players",
			["Description"] = "Players to ragdoll."
		},
		{
			["Type"] = "number",
			["Name"] = "Duration",
			["Description"] = "The Duration of the Ragdoll."
		}
	}
}
return v1