-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v2 = {
	["Name"] = "len",
	["Aliases"] = {},
	["Description"] = "Returns the length of a comma-separated list",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "CSV",
			["Description"] = "The comma-separated list"
		}
	},
	["Run"] = function(_, p1)
		return #p1:split(",")
	end
}
return v2
