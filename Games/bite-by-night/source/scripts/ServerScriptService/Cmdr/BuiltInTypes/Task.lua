-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = require(script.Parent.Parent.Shared.Util)
local v_u_2 = { "Generator", "Battery" }
local v_u_8 = {
	["Transform"] = function(p3)
		-- upvalues: (copy) v_u_1, (copy) v_u_2
		return v_u_1.MakeFuzzyFinder(v_u_2)(p3)
	end,
	["Validate"] = function(p4)
		if p4 then
			p4 = #p4 > 0
		end
		return p4, "No value with that name could be found."
	end,
	["Autocomplete"] = function(p5)
		-- upvalues: (copy) v_u_1
		return v_u_1.GetNames(p5)
	end,
	["Parse"] = function(p6)
		return p6[1]
	end,
	["Default"] = function(p7)
		return p7
	end,
	["ArgumentOperatorAliases"] = {
		["random"] = "?"
	}
}
return function(p9)
	-- upvalues: (copy) v_u_8
	p9:RegisterType("task", v_u_8)
end