-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v4 = {
	["Name"] = "unbind",
	["Aliases"] = {},
	["Description"] = "Unbinds an input previously bound with Bind",
	["Group"] = "DefaultUtil",
	["Args"] = {
		{
			["Type"] = "userInput ! bindableResource @ player",
			["Name"] = "Input/Key",
			["Description"] = "The key or input type you\'d like to unbind."
		}
	},
	["ClientRun"] = function(p1, p2)
		local v3 = p1:GetStore("CMDR_Binds")
		if not v3[p2] then
			return "That input wasn\'t bound."
		end
		v3[p2]:Disconnect()
		v3[p2] = nil
		return "Unbound command from input."
	end
}
return v4
