-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RebirthServiceUtils, time of decompilation: Sun May  3 10:11:39 2026 ]]
local t1 = {
	getCost = function(n1: number?) --[[ getCost ]] -- line: 10
		return 2 ^ math.max(math.floor(n1 or 0), 0) * 500
	end,
	getLuckMultiplier = function(n2: number?) --[[ getLuckMultiplier ]] -- line: 14
		return 1.82 ^ math.max(math.floor(n2 or 0), 0)
	end
}

function t1.getLuckModifier(n3: number?) -- line: 18
	-- upvalues: t1 (copy)
	local v6 = t1.getLuckMultiplier(n3)

	if v6 <= 1 then
		return nil
	end

	return {
		id = "rebirths.luck",
		stat = "luck",
		mode = "multiply",
		value = v6
	}
end
function t1.addLuckModifier(t2: {[any]: any}, n4: number?) -- line: 32
	-- upvalues: t1 (copy)
	local v9 = t1.getLuckModifier(n4)

	if v9 then
		table.insert(t2, v9)
	end

	return t2
end
function t1.canAffordRebirth(n5: number?, n6: number?) -- line: 41
	-- upvalues: t1 (copy)
	return (n6 or 0) >= t1.getCost(n5)
end
function t1.getRemainingGoop(n7: number?, n8: number?) -- line: 45
	-- upvalues: t1 (copy)
	return (n7 or 0) - t1.getCost(n8)
end
function t1.getProgress(n9: number?, n10: number?) -- line: 49
	-- upvalues: t1 (copy)
	local v16 = t1.getCost(n9)

	if v16 <= 0 then
		return 1
	end

	return (math.clamp((n10 or 0) / v16, 0, 1))
end

return t1
