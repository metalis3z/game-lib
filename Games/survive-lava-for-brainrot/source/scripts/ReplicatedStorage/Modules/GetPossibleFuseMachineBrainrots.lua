-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Registries.BrainrotRegistry)
local v_u_3 = require(v1.Registries.FuseMachineRegistry)
require(v1.Registries.RarityRegistry)
local v_u_4 = require(v1.Modules.GetFuseMachineAverageTier)
require(v1.Types.ItemSchemas)
local function v_u_50(p5, p_u_6)
	local v_u_7 = {}
	local v8 = 0
	local v_u_9 = {}
	for v10 in p5 do
		local v11 = p_u_6[v10]
		local v12 = v11 == nil and 1 or v11
		if v12 < 0 or v12 > 1 then
			warn((("MaximumChance out of range for %*: %*"):format(v10, v12)))
			return {}
		end
		local v13 = math.min(0.01, v12)
		v_u_7[v10] = v13
		v8 = v8 + v13
		v_u_9[v10] = true
	end
	if v8 >= 1 then
		if v8 <= 1e-12 then
			for v14 in p5 do
				v_u_7[v14] = 0
			end
			return v_u_7
		end
		local v15 = 1 / v8
		for v16 in p5 do
			v_u_7[v16] = v_u_7[v16] * v15
		end
		return v_u_7
	end
	local v_u_17 = 1 - v8
	local function v28()
		-- upvalues: (copy) v_u_9, (ref) v_u_17, (copy) p_u_6, (copy) v_u_7
		local v18 = {}
		for v19 in v_u_9 do
			table.insert(v18, v19)
		end
		while v_u_17 > 1e-12 and #v18 > 0 do
			local v20 = v_u_17 / #v18
			v18 = {}
			local v21 = false
			for _, v22 in v18 do
				local v23 = p_u_6[v22]
				local v24 = v23 == nil and 1 or v23
				local v25 = v24 - (v_u_7[v22] or 0)
				local v26 = math.max(v25, 0)
				local v27 = math.min(v20, v26)
				if v27 > 1e-12 then
					v_u_7[v22] = (v_u_7[v22] or 0) + v27
					v_u_17 = v_u_17 - v27
					v21 = true
				end
				if v24 - (v_u_7[v22] or 0) > 1e-12 then
					table.insert(v18, v22)
				else
					v_u_9[v22] = nil
				end
			end
			if not v21 then
				break
			end
		end
	end
	while v_u_17 > 1e-12 and next(v_u_9) ~= nil do
		local v29 = 0
		for v30 in v_u_9 do
			local v31 = p5[v30] or 0
			if v31 > 0 then
				v29 = v29 + v31
			end
		end
		if v29 <= 1e-12 then
			v28()
			break
		end
		local v32 = false
		for v33 in v_u_9 do
			local v34 = p5[v33] or 0
			if v34 > 0 then
				local v35 = v_u_17 * (v34 / v29)
				local v36 = p_u_6[v33]
				local v37 = (v36 == nil and 1 or v36) - (v_u_7[v33] or 0)
				local v38 = math.max(v37, 0)
				local v39 = math.min(v38, v_u_17)
				if v39 + 1e-12 < v35 then
					v_u_7[v33] = (v_u_7[v33] or 0) + v39
					v_u_17 = v_u_17 - v39
					v_u_9[v33] = nil
					v32 = true
				end
			end
		end
		if not v32 then
			for v40 in v_u_9 do
				local v41 = p5[v40] or 0
				if v41 > 0 then
					v_u_7[v40] = (v_u_7[v40] or 0) + v_u_17 * (v41 / v29)
				end
			end
			v_u_17 = 0
			break
		end
	end
	if v_u_17 > 1e-8 and next(v_u_9) ~= nil then
		v28()
	end
	local v42 = 0
	for v43 in p5 do
		local v44 = p_u_6[v43]
		local v45 = v44 == nil and 1 or v44
		local v46 = v_u_7[v43] or 0
		local v47 = math.clamp(v46, 0, v45)
		v_u_7[v43] = v47
		v42 = v42 + v47
	end
	if v42 > 1.000001 then
		local v48 = 1 / v42
		for v49 in p5 do
			v_u_7[v49] = v_u_7[v49] * v48
		end
	end
	return v_u_7
end
return function(p51, p52)
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_2, (copy) v_u_50
	local v53 = v_u_4(p51)
	if v53 == -1 then
		return {}
	end
	local v54 = {}
	local v55 = (1 / 0)
	for _, v56 in v_u_3 do
		for v57, v58 in v56.Brainrots do
			local v59 = v_u_2[v57]
			if v59 and (v53 >= v58.MinimumTier and v58.MaximumTier > v53) then
				local v60 = v59.CashPerSec
				if v60 > 0 then
					v54[v57] = {
						["TierValue"] = v56.Value,
						["MaximumChance"] = v58.MaximumChance or 1,
						["LuckMaximumChance"] = v58.LuckMaximumChance or (v58.MaximumChance or 1),
						["CashPerSec"] = v60,
						["MinimumTier"] = v58.MinimumTier,
						["MaximumTier"] = v58.MaximumTier
					}
					v55 = math.min(v55, v60)
				end
			end
		end
	end
	if v55 == (1 / 0) then
		return {}
	end
	local v61 = {}
	local v62 = {}
	for v63, v64 in v54 do
		local v65 = v64.MinimumTier
		local v66 = v64.TierValue - v65
		local v67 = math.max(v66, 1e-6)
		local v68 = (v53 - v65) / v67
		local v69 = math.clamp(v68, 0, 1) * 1.5 + 0.5
		local v70 = v64.TierValue
		local v71 = math.max(v69, 1e-6)
		local v72 = 1.3 ^ (-(v70 - 1) / v71)
		local v73 = v64.CashPerSec
		local v74 = math.max(v69, 1e-6)
		local v75 = math.max(v73, 1e-9)
		local v76 = v72 * (math.max(v55, 1e-9) / v75) ^ (1.25 / v74)
		local v77
		if p52 then
			v77 = math.max(v76, 1e-12) ^ 0.5
		else
			v77 = math.max(v76, 1e-12) ^ 0.7
		end
		v61[v63] = v77
		local v78
		if p52 then
			v78 = v64.LuckMaximumChance
		else
			v78 = v64.MaximumChance
		end
		v62[v63] = v78
	end
	return v_u_50(v61, v62)
end
