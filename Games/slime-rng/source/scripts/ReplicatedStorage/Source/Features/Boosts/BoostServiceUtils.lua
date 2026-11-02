-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: BoostServiceUtils, time of decompilation: Sun May  3 10:11:22 2026 ]]
local t1 = {
	"luck",
	"ultraLuck",
	"currency",
	"rollSpeed"
}
local t2 = {
	luck = {
		duration = 180,
		order = 1,
		rollStatModifiers = {{
			id = "boosts.luck",
			stat = "luck",
			mode = "multiply",
			value = 2
		}}
	},
	ultraLuck = {
		duration = 180,
		order = 2,
		rollStatModifiers = {{
			id = "boosts.ultraLuck",
			stat = "luck",
			mode = "multiply",
			value = 3
		}}
	},
	currency = {
		duration = 180,
		order = 3,
		coinRewardModifier = {
			id = "boosts.currency",
			multiplier = 2
		}
	},
	rollSpeed = {
		duration = 180,
		order = 4,
		rollStatModifiers = {{
			id = "boosts.rollSpeed",
			stat = "rollSpeed",
			mode = "multiply",
			value = 2
		}}
	}
}
local t3 = {
	getKinds = function() --[[ getKinds ]] -- line: 90
		-- upvalues: t1 (copy)
		return t1
	end,
	getConfig = function(p1) --[[ getConfig ]] -- line: 94
		-- upvalues: t2 (copy)
		return t2[p1]
	end
}

function t3.getDuration(s1: string) -- line: 98
	-- upvalues: t3 (copy)
	local v8 = t3.getConfig(s1)

	if v8 then
		return v8.duration
	end

	return 0
end
function t3.getOrder(s2: string) -- line: 103
	-- upvalues: t3 (copy)
	local v10 = t3.getConfig(s2)

	if v10 then
		return v10.order
	end

	return 1e999
end
function t3.getDefaultBoostData() -- line: 108
	return {
		amount = 0,
		timeRemaining = 0,
		expirationTime = 0
	}
end
function t3.reconcileBoostData(p2) -- line: 116
	local v12 = if type(p2) ~= "table" then {} else p2
	local t4 = {}
	local amount = v12.amount

	t4.amount = if type(amount) == "number" and amount == amount then math.max(math.floor(amount + 0.5), 0) else 0

	local timeRemaining = v12.timeRemaining

	t4.timeRemaining = if type(timeRemaining) == "number" and timeRemaining == timeRemaining then math.max(math.floor(timeRemaining + 0.5), 0) else 0

	local expirationTime = v12.expirationTime

	t4.expirationTime = if type(expirationTime) == "number" and expirationTime == expirationTime then math.max(math.floor(expirationTime + 0.5), 0) else 0

	return t4
end
function t3.reconcileBoosts(p3) -- line: 126
	-- upvalues: t1 (copy), t3 (copy)
	local v18 = if type(p3) ~= "table" then {} else p3
	local t5 = {}

	for _, v21 in t1 do
		t5[v21] = t3.reconcileBoostData(v18[v21])
	end

	return t5
end
function t3.getBoostData(p4, s3: string) -- line: 137
	-- upvalues: t3 (copy)
	local v24 = if type(p4) ~= "table" then {} else p4

	return t3.reconcileBoostData(v24[s3])
end
function t3.getExpirationTime(t6: {[any]: any}) -- line: 142
	-- upvalues: t3 (copy)
	return t3.reconcileBoostData(t6).expirationTime
end
function t3.getTimeRemaining(t7: {[any]: any}, n1: number) -- line: 146
	-- upvalues: t3 (copy)
	local v28 = t3.reconcileBoostData(t7)
	local expirationTime = v28.expirationTime

	if expirationTime > 0 then
		return (math.max(expirationTime - n1, 0))
	end

	return v28.timeRemaining
end
function t3.isActive(t8: {[any]: any}, n2: number) -- line: 157
	-- upvalues: t3 (copy)
	return n2 < t3.getExpirationTime(t8) and t3.getTimeRemaining(t8, n2) > 0
end
function t3.hydrateBoostsForSession(p5, n3: number) -- line: 162
	-- upvalues: t3 (copy), t1 (copy)
	local v34 = t3.reconcileBoosts(p5)

	for _, v36 in t1 do
		local v37 = v34[v36]
		local timeRemaining = v37.timeRemaining

		v37.expirationTime = not (timeRemaining > 0) and 0 or n3 + timeRemaining
	end

	return v34
end
function t3.snapshotBoostsForSave(p6, n4: number) -- line: 174
	-- upvalues: t3 (copy), t1 (copy)
	local v41 = t3.reconcileBoosts(p6)

	for _, v43 in t1 do
		local v44 = v41[v43]

		v44.timeRemaining = t3.getTimeRemaining(v44, n4)
		v44.expirationTime = 0
	end

	return v41
end
function t3.withAddedAmount(p7, n5: number) -- line: 186
	-- upvalues: t3 (copy)
	local v47 = t3.reconcileBoostData(p7)
	local v48 = if type(n5) == "number" and n5 == n5 then math.max(math.floor(n5 + 0.5), 0) else 0

	return {
		amount = v47.amount + v48,
		timeRemaining = v47.timeRemaining,
		expirationTime = v47.expirationTime
	}
end
function t3.withAddedTime(p8, n6: number, n7: number) -- line: 197
	-- upvalues: t3 (copy)
	local v52 = t3.reconcileBoostData(p8)
	local v53 = if type(n6) == "number" and n6 == n6 then math.max(math.floor(n6 + 0.5), 0) else 0
	local v54 = t3.getTimeRemaining(v52, n7) + v53

	return {
		amount = v52.amount,
		timeRemaining = v54,
		expirationTime = not (v54 > 0) and 0 or n7 + v54
	}
end
function t3.getRollStatModifiers(p9, n8: number) -- line: 209
	-- upvalues: t3 (copy), t1 (copy), t2 (copy)
	local t9 = {}
	local v58 = t3.reconcileBoosts(p9)
	local n9 = 1

	for _, v61 in t1 do
		local v62 = t2[v61]
		local v63 = v58[v61]

		if v62.rollStatModifiers and t3.isActive(v63, n8) then
			for _, v65 in v62.rollStatModifiers do
				if v65.stat == "luck" and v65.mode == "multiply" and (v61 == "luck" or v61 == "ultraLuck") then
					n9 += v65.value - 1
				else
					table.insert(t9, table.clone(v65))
				end
			end
		end
	end

	if n9 > 1 then
		table.insert(t9, {
			id = "boosts.luckStack",
			stat = "luck",
			mode = "multiply",
			value = n9
		})
	end

	return t9
end
function t3.getCoinRewardModifiers(p10, n10: number) -- line: 240
	-- upvalues: t3 (copy), t1 (copy), t2 (copy)
	local t10 = {}
	local v69 = t3.reconcileBoosts(p10)

	for _, v71 in t1 do
		local v72 = t2[v71]
		local v73 = v69[v71]

		if v72.coinRewardModifier and t3.isActive(v73, n10) then
			table.insert(t10, table.clone(v72.coinRewardModifier))
		end
	end

	return t10
end

return t3
