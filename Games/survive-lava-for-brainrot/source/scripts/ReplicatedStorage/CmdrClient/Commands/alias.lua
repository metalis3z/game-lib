-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v4 = {
	["Name"] = "alias",
	["Aliases"] = {},
	["Description"] = "Creates a new, single command out of a command and given arguments.",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "Alias name",
			["Description"] = "The key or input type you\'d like to bind the command to."
		},
		{
			["Type"] = "string",
			["Name"] = "Command string",
			["Description"] = "The command text you want to run. Separate multiple commands with \"&&\". Accept arguments with $1, $2, $3, etc."
		}
	},
	["ClientRun"] = function(p1, p2, p3)
		p1.Cmdr.Registry:RegisterCommandObject(p1.Cmdr.Util.MakeAliasCommand(p2, p3), true)
		return ("Created alias %q"):format(p2)
	end
}
return v4
