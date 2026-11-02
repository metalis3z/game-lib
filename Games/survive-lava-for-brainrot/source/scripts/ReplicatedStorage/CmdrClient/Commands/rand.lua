-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v4 = {
	["Name"] = "rand",
	["Aliases"] = {},
	["Description"] = "Returns a random number between min and max",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "integer",
			["Name"] = "First number",
			["Description"] = "If second number is nil, random number is between 1 and this value. If second number is provided, number is between this number and the second number."
		},
		{
			["Type"] = "integer",
			["Name"] = "Second number",
			["Description"] = "The upper bound.",
			["Optional"] = true
		}
	},
	["Run"] = function(_, p1, p2)
		local v3 = p2 and math.random(p1, p2) or math.random(p1)
		return tostring(v3)
	end
}
return v4
