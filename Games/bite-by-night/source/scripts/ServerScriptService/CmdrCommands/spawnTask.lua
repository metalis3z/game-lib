-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "spawntask",
	["Aliases"] = {},
	["Description"] = "spawn a task in the map.",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "task",
			["Name"] = "Task",
			["Description"] = "task to spawn."
		}
	}
}
return v1