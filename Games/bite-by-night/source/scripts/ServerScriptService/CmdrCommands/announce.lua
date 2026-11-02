-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "announce",
	["Aliases"] = { "m" },
	["Description"] = "Announcement across all servers.",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "Message",
			["Description"] = "The message."
		}
	}
}
return v1