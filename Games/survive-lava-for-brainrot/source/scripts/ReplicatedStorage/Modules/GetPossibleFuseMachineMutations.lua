-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
require(v1.Registries.MutationRegistry)
require(v1.Types.ItemSchemas)
return function(p2, p3)
	local v4 = {}
	for _, v5 in p2 do
		local v6 = v5.Metadata
		if v6 then
			local v7 = v6.Mutation
			if v7 and v7 ~= "Normal" then
				if v4[v7] then
					v4[v7] = v4[v7] + 0.1
				else
					v4[v7] = 0.15
				end
			end
		end
	end
	if p3 then
		for v8, v9 in v4 do
			v4[v8] = v9 + 0.05
		end
	end
	return v4
end
