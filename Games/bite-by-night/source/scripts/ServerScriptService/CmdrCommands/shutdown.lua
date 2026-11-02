-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "shutdown",
	["Aliases"] = {},
	["Description"] = "Shutdown all servers.",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "boolean",
			["Name"] = "Global",
			["Description"] = "True of False",
			["Optional"] = true
		}
	}
}
return v1