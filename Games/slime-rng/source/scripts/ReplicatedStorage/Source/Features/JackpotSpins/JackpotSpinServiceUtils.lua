-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: JackpotSpinServiceUtils, time of decompilation: Sun May  3 10:12:16 2026 ]]
local t1 = {
	ITEM_ID = "jackpotSpin",
	ARMED_DATA_KEY = "armedJackpotSpins"
}
local t2 = {
	{
		key = "jackpotSpinSingle",
		amount = 1,
		description = nil,
		layoutOrder = 1
	},
	{
		key = "jackpotSpinBundle",
		amount = 5,
		description = "(4 +1 bonus)",
		layoutOrder = 2
	},
	{
		key = "jackpotSpinCrate",
		amount = 12,
		description = "(8 + 4 bonus)",
		layoutOrder = 3
	}
}

function t1.getProductDefinitions() -- line: 27
	-- upvalues: t2 (copy)
	return table.clone(t2)
end
function t1.getAmount(p1) -- line: 31
	-- upvalues: t1 (copy)
	return (math.max(math.floor(((if type(p1) ~= "table" then {} else p1))[t1.ITEM_ID] or 0), 0))
end
function t1.getArmedAmount(p2) -- line: 36
	return (math.max(math.floor(p2 or 0), 0))
end
function t1.isActive(p3) -- line: 40
	-- upvalues: t1 (copy)
	return t1.getArmedAmount(p3) > 0
end

return t1
