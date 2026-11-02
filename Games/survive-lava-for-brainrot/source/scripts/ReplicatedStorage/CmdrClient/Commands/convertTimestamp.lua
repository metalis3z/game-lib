-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v3 = {
	["Name"] = "convertTimestamp",
	["Aliases"] = { "date" },
	["Description"] = "Convert a timestamp to a human-readable format.",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "number",
			["Name"] = "timestamp",
			["Description"] = "A numerical representation of a specific moment in time.",
			["Optional"] = true
		}
	},
	["ClientRun"] = function(_, p1)
		local v2 = p1 or os.time()
		return ("%* %*"):format(os.date("%x", v2), (os.date("%X", v2)))
	end
}
return v3
