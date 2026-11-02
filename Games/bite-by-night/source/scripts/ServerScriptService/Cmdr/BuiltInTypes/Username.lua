-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Shared.Util)
local v_u_2 = game:GetService("Players")
local v_u_7 = {
	["Transform"] = function(p3)
		-- upvalues: (copy) v_u_1, (copy) v_u_2
		return { v_u_1.MakeFuzzyFinder(v_u_2:GetPlayers())(p3), p3 }
	end,
	["Autocomplete"] = function(p4)
		-- upvalues: (copy) v_u_1
		if v_u_1.GetNames(p4[1]) then
			return v_u_1.GetNames(p4[1])
		else
			return p4[2]
		end
	end,
	["Parse"] = function(p5)
		return p5[2]
	end,
	["Default"] = function(p6)
		return p6.Name
	end,
	["ArgumentOperatorAliases"] = {
		["me"] = ".",
		["all"] = "*",
		["others"] = "**",
		["random"] = "?"
	}
}
return function(p8)
	-- upvalues: (copy) v_u_7, (copy) v_u_1
	p8:RegisterType("username", v_u_7)
	p8:RegisterType("usernames", v_u_1.MakeListableType(v_u_7))
end