-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local function v_u_5(p1)
	-- upvalues: (copy) v_u_5
	local v2 = table.clone(p1)
	for v3, v4 in v2 do
		if type(v4) == "table" then
			v2[v3] = v_u_5(v4)
		end
	end
	return v2
end
return v_u_5
