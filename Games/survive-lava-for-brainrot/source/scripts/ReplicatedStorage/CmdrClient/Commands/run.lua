-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v3 = {
	["Name"] = "run",
	["Aliases"] = { ">" },
	["AutoExec"] = { "alias \"discard|Run a command and discard the output.\" replace ${run $1} .* \\\"\\\"" },
	["Description"] = "Runs a given command string (replacing embedded commands).",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "Command",
			["Description"] = "The command string to run"
		}
	},
	["Run"] = function(p1, p2)
		return p1.Cmdr.Util.RunCommandString(p1.Dispatcher, p2)
	end
}
return v3
