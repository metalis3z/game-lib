-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Registries.BrainrotRegistry)
local v_u_3 = require(v1.Registries.FuseMachineRegistry)
require(v1.Registries.RarityRegistry)
require(v1.Types.ItemSchemas)
local v_u_4 = {}
for _, v5 in v_u_2 do
	local v6 = v5.Rarity
	local v7 = v5.CashPerSec
	if type(v7) == "number" and v7 > 0 then
		local v8 = v_u_4[v6]
		if v8 then
			local v9 = v8.Min
			v8.Min = math.min(v9, v7)
			local v10 = v8.Max
			v8.Max = math.max(v10, v7)
		else
			v_u_4[v6] = {
				["Min"] = v7,
				["Max"] = v7
			}
		end
	end
end
return function(p11)
	-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_4
	local v12 = 0
	local v13 = 0
	local v14 = (1 / 0)
	local v15 = (-1 / 0)
	for _, v16 in p11 do
		local v17 = v16.Metadata
		local v18 = v17.Name
		local v19 = v_u_2[v18]
		if v19 then
			local v20 = v19.CashPerSec
			if type(v20) == "number" and v20 > 0 then
				local v21 = v_u_2[v18]
				local v22
				if v21 then
					local v23 = v_u_3[v21.Rarity]
					v22 = not v23 and 1 or v23.Value
				else
					v22 = 1
				end
				local v24 = (v17.Level - 1) * 0.005
				local v25 = v_u_4[v19.Rarity]
				local v26
				if v25 then
					local v27 = v25.Max - v25.Min
					if v27 > 0 then
						local v28 = (v20 - v25.Min) / v27
						v26 = math.clamp(v28, 0, 1) * 0.8
					else
						v26 = 0
					end
				else
					v26 = 0
				end
				local v29 = v22 + v26 + v24
				local v30 = v22 + 1
				local v31 = math.min(v29, v30)
				v14 = math.min(v14, v22)
				v15 = math.max(v15, v22)
				v12 = v12 + v31
				v13 = v13 + 1
			end
		end
	end
	if v13 == 0 then
		return -1
	end
	local v32 = v12 / v13
	if v14 >= v15 then
		return v32
	end
	local v33 = v15 - 0.75
	return math.max(v33, v32)
end
