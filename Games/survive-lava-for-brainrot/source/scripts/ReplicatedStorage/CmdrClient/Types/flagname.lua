-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(script.Parent.Parent.Shared.Util)
local v_u_3 = {}
for v4, _ in require(v1.Registries.ConfigList) do
	table.insert(v_u_3, v4)
end
local v_u_10 = {
	["Transform"] = function(p5)
		-- upvalues: (copy) v_u_2, (copy) v_u_3
		return v_u_2.MakeFuzzyFinder(v_u_3)(p5)
	end,
	["Validate"] = function(p6)
		return #p6 > 0, "no power by that name could be found."
	end,
	["Autocomplete"] = function(p7)
		-- upvalues: (copy) v_u_2
		return v_u_2.GetNames(p7)
	end,
	["Parse"] = function(p8)
		return p8[1]
	end,
	["Default"] = function(p9)
		return p9
	end,
	["ArgumentOperatorAliases"] = {
		["All"] = "*",
		["random"] = "?"
	}
}
return function(p11)
	-- upvalues: (copy) v_u_10, (copy) v_u_2
	p11:RegisterType(script.Name, v_u_10)
	p11:RegisterType(script.Name .. "s", v_u_2.MakeListableType(v_u_10))
end
