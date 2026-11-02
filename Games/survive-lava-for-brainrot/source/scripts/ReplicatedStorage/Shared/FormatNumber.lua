-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = {
	{
		["Value"] = 1e33,
		["Suffix"] = "De"
	},
	{
		["Value"] = 1e30,
		["Suffix"] = "No"
	},
	{
		["Value"] = 1e27,
		["Suffix"] = "Oc"
	},
	{
		["Value"] = 1e24,
		["Suffix"] = "Sp"
	},
	{
		["Value"] = 1e21,
		["Suffix"] = "Sx"
	},
	{
		["Value"] = 1e18,
		["Suffix"] = "Qn"
	},
	{
		["Value"] = 1000000000000000,
		["Suffix"] = "Qd"
	},
	{
		["Value"] = 1000000000000,
		["Suffix"] = "T"
	},
	{
		["Value"] = 1000000000,
		["Suffix"] = "B"
	},
	{
		["Value"] = 1000000,
		["Suffix"] = "M"
	},
	{
		["Value"] = 1000,
		["Suffix"] = "k"
	}
}
return function(p2)
	-- upvalues: (copy) v_u_1
	for _, v3 in v_u_1 do
		if v3.Value <= p2 then
			local v4 = p2 / v3.Value * 10
			local v5 = math.floor(v4) / 10
			return string.format(v5 <= 1 and "%.0f%s" or "%.1f%s", v5, v3.Suffix):gsub("%.0", "")
		end
	end
	return p2
end
