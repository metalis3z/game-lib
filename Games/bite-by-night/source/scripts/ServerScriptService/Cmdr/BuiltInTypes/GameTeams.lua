-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Shared.Util)
local v_u_2 = { "Survivor", "Killer" }
local v_u_8 = {
	["Transform"] = function(p3)
		-- upvalues: (copy) v_u_1, (copy) v_u_2
		return v_u_1.MakeFuzzyFinder(v_u_2)(p3)
	end,
	["Validate"] = function(p4)
		return #p4 > 0, "No value with that name could be found."
	end,
	["Autocomplete"] = function(p5)
		-- upvalues: (copy) v_u_1
		if p5[1] ~= "." or p5[1] ~= "**" then
			return v_u_1.GetNames(p5)
		end
	end,
	["Parse"] = function(p6)
		return p6[1]
	end,
	["Default"] = function(p7)
		return p7
	end,
	["ArgumentOperatorAliases"] = {
		["all"] = "*",
		["random"] = "?"
	}
}
return function(p9)
	-- upvalues: (copy) v_u_8
	p9:RegisterType("gameteams", v_u_8)
end