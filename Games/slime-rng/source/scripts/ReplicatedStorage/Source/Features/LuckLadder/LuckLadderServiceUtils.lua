-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: LuckLadderServiceUtils, time of decompilation: Sun May  3 10:12:14 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FormatTime = require(ReplicatedStorage.Source.Core.UI.FormatTime)
local t1 = {
	1,
	2,
	4,
	8,
	16,
	32,
	64,
	128,
	256,
	512,
	1024,
	2048,
	4096,
	8192,
	16384
}
local t2 = {
	2,
	4,
	8,
	16,
	32,
	64,
	128,
	256,
	512,
	1024,
	2048,
	4096,
	8192,
	16384
}
local t4 = {
	getDefaultState = function() --[[ getDefaultState ]] -- line: 49
		return {
			multiplier = 1,
			expirationTime = 0,
			lastPurchaserName = nil
		}
	end,
	reconcileState = function(p1) --[[ reconcileState ]] -- line: 57
		-- upvalues: t1 (copy)
		local v11 = if type(p1) ~= "table" then {} else p1
		local t3 = {}
		local multiplier = v11.multiplier
		local n1, g17

		if type(multiplier) ~= "number" then
			n1 = 1
		else
			g17 = nil
			n1 = nil

			for _, v16 in t1 do
				if v16 == multiplier then
					n1 = v16
					g17 = true
				end

				if g17 then
					break
				end
			end

			if not g17 then
				n1 = 1
			end
		end

		g17 = false
		t3.multiplier = n1

		local expirationTime = v11.expirationTime

		t3.expirationTime = if type(expirationTime) == "number" and expirationTime == expirationTime then math.max(math.floor(expirationTime + 0.5), 0) else 0
		t3.lastPurchaserName = if type(v11.lastPurchaserName) ~= "string" then nil else v11.lastPurchaserName

		return t3
	end,
	getBaseMultiplier = function() --[[ getBaseMultiplier ]] -- line: 67
		return 1
	end,
	getMaxMultiplier = function() --[[ getMaxMultiplier ]] -- line: 71
		return 16384
	end,
	getDuration = function() --[[ getDuration ]] -- line: 75
		return 900
	end,
	getTierMultipliers = function() --[[ getTierMultipliers ]] -- line: 79
		-- upvalues: t1 (copy)
		return table.clone(t1)
	end,
	getPurchasableMultipliers = function() --[[ getPurchasableMultipliers ]] -- line: 83
		-- upvalues: t2 (copy)
		return table.clone(t2)
	end,
	getProductKey = function(n2: number) --[[ getProductKey ]] -- line: 87
		return "luckLadder" .. tostring(n2)
	end
}

function t4.isActive(p2, n3: number) -- line: 91
	-- upvalues: t4 (copy)
	local v22 = t4.reconcileState(p2)

	return v22.multiplier > 1 and n3 < v22.expirationTime
end
function t4.getTimeRemaining(p3, n4: number) -- line: 96
	-- upvalues: t4 (copy)
	local v25 = t4.reconcileState(p3)

	if not t4.isActive(v25, n4) then
		return 0
	end

	return (math.max(v25.expirationTime - n4, 0))
end
function t4.getCurrentMultiplier(p4, n5: number) -- line: 105
	-- upvalues: t4 (copy)
	local v28 = t4.reconcileState(p4)

	if t4.isActive(v28, n5) then
		return v28.multiplier
	end

	return 1
end
function t4.getNextMultiplier(n6: number) -- line: 114
	-- upvalues: t1 (copy), t2 (copy)
	local n7, g33

	if type(n6) ~= "number" then
		n7 = 1
	else
		g33 = nil
		n7 = nil

		for _, v32 in t1 do
			if v32 == n6 then
				n7 = v32
				g33 = true
			end

			if g33 then
				break
			end
		end

		if not g33 then
			n7 = 1
		end
	end

	g33 = false

	if n7 >= 16384 then
		return 16384
	end

	for _, v35 in t2 do
		if n7 < v35 then
			return v35
		end
	end

	return nil
end
function t4.isMaxTier(n8: number) -- line: 130
	-- upvalues: t1 (copy)
	local n9

	if type(n8) ~= "number" then
		n9 = 1
	else
		for _, v39 in t1 do
			if v39 == n8 then
				n9 = v39

				return n9 >= 16384
			end
		end

		n9 = 1
	end

	return n9 >= 16384
end
function t4.resolvePurchaseMultiplier(n10: number, n11: number) -- line: 134
	-- upvalues: t1 (copy), t4 (copy)
	local g49 = nil
	local n13 = nil
	local n12, g45

	if type(n10) ~= "number" then
		n12 = 1
	else
		g45 = nil
		n12 = nil

		for _, v44 in t1 do
			if v44 == n10 then
				n12 = v44
				g45 = true
			end

			if g45 then
				break
			end
		end

		if not g45 then
			n12 = 1
		end
	end

	g45 = false

	if type(n11) ~= "number" then
		n13 = 1
	else
		for _, v48 in t1 do
			if v48 == n11 then
				n13 = v48
				g49 = true
			end

			if g49 then
				break
			end
		end

		if not g49 then
			n13 = 1
		end
	end

	g49 = false

	if n12 >= 16384 then
		return 16384
	end

	return (math.min(math.max(t4.getNextMultiplier(n12) or 16384, n13), 16384))
end
function t4.getRollStatModifier(p5, n14: number) -- line: 149
	-- upvalues: t4 (copy)
	local v52 = t4.getCurrentMultiplier(p5, n14)

	if v52 <= 1 then
		return nil
	end

	return {
		id = "luckLadder.serverLuck",
		stat = "luck",
		mode = "multiply",
		applyToFinalLuck = true,
		value = v52
	}
end
function t4.formatMultiplier(n15: number) -- line: 167
	-- upvalues: t1 (copy)
	local n16

	if type(n15) ~= "number" then
		n16 = 1
	else
		for _, v56 in t1 do
			if v56 == n15 then
				n16 = v56

				return "x" .. tostring(n16)
			end
		end

		n16 = 1
	end

	return "x" .. tostring(n16)
end
function t4.getPurchaseAnnouncementMessage(s1: string?, n17: number) -- line: 171
	-- upvalues: t4 (copy), FormatTime (copy)
	local v59 = t4.formatMultiplier(n17)
	local v60 = FormatTime(900)

	if s1 and s1 ~= "" then
		return `{ s1 } boosted Server Luck to { v59 } for { v60 }!`
	end

	return `Server Luck was boosted to { v59 } for { v60 }!`
end
function t4.getActiveAnnouncementMessage(p6, n18: number) -- line: 181
	-- upvalues: t4 (copy), FormatTime (copy)
	local v63 = t4.reconcileState(p6)

	if not t4.isActive(v63, n18) then
		return nil
	end

	local v64 = FormatTime(t4.getTimeRemaining(v63, n18))
	local v65 = t4.formatMultiplier(v63.multiplier)

	if v63.lastPurchaserName and v63.lastPurchaserName ~= "" then
		return `{ v63.lastPurchaserName } boosted Server Luck to { v65 }! { v64 } left.`
	end

	return `Server Luck is active at { v65 }! { v64 } left.`
end

return t4
