-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("Teams")
local v_u_2 = require(script.Parent.Parent.Shared.Util)
local v_u_7 = {
	["Transform"] = function(p3)
		-- upvalues: (copy) v_u_2, (copy) v_u_1
		return v_u_2.MakeFuzzyFinder(v_u_1:GetTeams())(p3)
	end,
	["Validate"] = function(p4)
		return #p4 > 0, "No team with that name could be found."
	end,
	["Autocomplete"] = function(p5)
		-- upvalues: (copy) v_u_2
		return v_u_2.GetNames(p5)
	end,
	["Parse"] = function(p6)
		return p6[1]
	end
}
local v_u_9 = {
	["Listable"] = true,
	["Transform"] = v_u_7.Transform,
	["Validate"] = v_u_7.Validate,
	["Autocomplete"] = v_u_7.Autocomplete,
	["Parse"] = function(p8)
		return p8[1]:GetPlayers()
	end
}
local v_u_11 = {
	["Transform"] = v_u_7.Transform,
	["Validate"] = v_u_7.Validate,
	["Autocomplete"] = v_u_7.Autocomplete,
	["Parse"] = function(p10)
		return p10[1].TeamColor
	end
}
return function(p12)
	-- upvalues: (copy) v_u_7, (copy) v_u_2, (copy) v_u_9, (copy) v_u_11
	p12:RegisterType("team", v_u_7)
	p12:RegisterType("teams", v_u_2.MakeListableType(v_u_7))
	p12:RegisterType("teamPlayers", v_u_9)
	p12:RegisterType("teamColor", v_u_11)
	p12:RegisterType("teamColors", v_u_2.MakeListableType(v_u_11))
end
