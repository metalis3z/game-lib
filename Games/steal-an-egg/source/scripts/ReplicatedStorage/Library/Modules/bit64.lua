-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local bxor = bit32.bxor
local bor = bit32.bor
local band = bit32.band
local bnot = bit32.bnot
local t = {
	band = function(p1, p2) --[[ band | Line: 8 | Upvalues: band (copy) ]]
		return band(p1 // 4294967296, p2 // 4294967296) * 4294967296 + band(p1, p2)
	end,
	bnot = function(p1) --[[ bnot | Line: 12 | Upvalues: bnot (copy), band (copy) ]]
		return band(bnot(p1 // 4294967296), 2097151) * 4294967296 + bnot(p1)
	end,
	bor = function(p1, p2) --[[ bor | Line: 16 | Upvalues: bor (copy) ]]
		return bor(p1 // 4294967296, p2 // 4294967296) * 4294967296 + bor(p1, p2)
	end,
	bxor = function(p1, p2) --[[ bxor | Line: 20 | Upvalues: bxor (copy) ]]
		return bxor(p1 // 4294967296, p2 // 4294967296) * 4294967296 + bxor(p1, p2)
	end
}

table.freeze(t)
assert(t.bxor(5337546457632111, 927896922657421) == 4993512435277794)
assert(t.bor(5337546457632111, 927896922657421) == 5629477907783663)
assert(t.band(5337546457632111, 927896922657421) == 635965472505869)
assert(t.bnot(5337546457632111) == 3669652797108880)

return t