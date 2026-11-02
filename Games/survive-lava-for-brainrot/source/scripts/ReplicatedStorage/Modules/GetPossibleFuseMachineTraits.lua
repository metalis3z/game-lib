-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Registries.TraitsRegistry)
require(v1.Types.ItemSchemas)
return function(p3, _)
	-- upvalues: (copy) v_u_2
	local v4 = {}
	for _, v5 in p3 do
		local v6 = v5.Metadata
		if v6 then
			local v7 = v6.Traits
			if v7 then
				for _, v8 in v7 do
					if v_u_2[v8] then
						if v4[v8] then
							v4[v8] = v4[v8] + 0.1
						else
							v4[v8] = 0.15
						end
					end
				end
			end
		end
	end
	return v4
end
