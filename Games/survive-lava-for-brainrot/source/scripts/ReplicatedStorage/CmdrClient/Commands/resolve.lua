-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v3 = {
	["Name"] = "resolve",
	["Aliases"] = {},
	["Description"] = "Resolves Argument Value Operators into lists. E.g., resolve players * gives you a list of all players.",
	["Group"] = "DefaultUtil",
	["AutoExec"] = { "alias \"me|Displays your username\" resolve players ." },
	["Args"] = {
		{
			["Type"] = "type",
			["Name"] = "Type",
			["Description"] = "The type for which to resolve"
		},
		function(p1)
			if p1:GetArgument(1):Validate() ~= false then
				return {
					["Type"] = p1:GetArgument(1):GetValue(),
					["Name"] = "Argument Value Operator",
					["Description"] = "The value operator to resolve. One of: * ** . ? ?N",
					["Optional"] = true
				}
			end
		end
	},
	["Run"] = function(p2)
		return table.concat(p2:GetArgument(2).RawSegments, ",")
	end
}
return v3
