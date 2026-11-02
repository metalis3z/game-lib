-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = {
	["Name"] = script.Name,
	["Aliases"] = { "gbr" },
	["Description"] = script.Name,
	["Group"] = "DefaultAdmin",
	["Args"] = {
		{
			["Type"] = "number",
			["Name"] = "Impersonator",
			["Description"] = "Impersonator user Id!"
		},
		{
			["Type"] = "number",
			["Name"] = "Impersonating",
			["Description"] = "Person to impersonate user Id!"
		},
		{
			["Type"] = "boolean",
			["Name"] = "Verified",
			["Description"] = "If you are impersonating a verified person",
			["Optional"] = true
		}
	}
}
return v1
