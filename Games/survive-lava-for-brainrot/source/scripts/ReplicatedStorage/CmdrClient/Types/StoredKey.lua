-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = require(script.Parent.Parent.Shared.Util)
local v_u_2 = {
	"^%a[%w_]*$",
	"^%$%a[%w_]*$",
	"^%.%a[%w_]*$",
	"^%$%.%a[%w_]*$"
}
return function(p_u_3)
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v8 = {
		["Autocomplete"] = function(p4)
			-- upvalues: (copy) p_u_3
			return p_u_3.Cmdr.Util.MakeFuzzyFinder(p_u_3.Cmdr.Util.DictionaryKeys(p_u_3:GetStore("vars_used") or {}))(p4)
		end,
		["Validate"] = function(p5)
			-- upvalues: (ref) v_u_2
			for _, v6 in ipairs(v_u_2) do
				if p5:match(v6) then
					return true
				end
			end
			return false, "Key names must start with an optional modifier: . $ or $. and must begin with a letter."
		end,
		["Parse"] = function(p7)
			return p7
		end
	}
	p_u_3:RegisterType("storedKey", v8)
	p_u_3:RegisterType("storedKeys", v_u_1.MakeListableType(v8))
end
