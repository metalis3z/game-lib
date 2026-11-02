-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v3 = {
	["Name"] = "pick",
	["Aliases"] = {},
	["Description"] = "Picks a value out of a comma-separated list.",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "integer",
			["Name"] = "Index to pick",
			["Description"] = "The index of the item you want to pick"
		},
		{
			["Type"] = "string",
			["Name"] = "CSV",
			["Description"] = "The comma-separated list"
		}
	},
	["Run"] = function(_, p1, p2)
		return p2:split(",")[p1] or ""
	end
}
return v3
