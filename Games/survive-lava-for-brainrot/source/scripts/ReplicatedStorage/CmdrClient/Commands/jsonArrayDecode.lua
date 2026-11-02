-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v3 = {
	["Name"] = "json-array-decode",
	["Aliases"] = {},
	["Description"] = "Decodes a JSON Array into a comma-separated list",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "json",
			["Name"] = "JSON",
			["Description"] = "The JSON array."
		}
	},
	["ClientRun"] = function(_, p1)
		local v2 = type(p1) ~= "table" and { p1 } or p1
		return table.concat(v2, ",")
	end
}
return v3
