-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v1 = {
	["Name"] = "joinserver",
	["Aliases"] = { "js" },
	["Description"] = "Join the server with server code.",
	["Group"] = script:GetAttribute("Group"),
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "ServerCode",
			["Description"] = "The private server code to join"
		}
	},
	["IgnoreLog"] = true
}
return v1