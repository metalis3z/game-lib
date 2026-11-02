-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Table, time of decompilation: Sun May  3 10:09:19 2026 ]]
local random = Random.new()
local _table = table
local t1 = {}

function t1.contains(p1, p2) -- line: 29
	-- upvalues: t1 (copy)
	return t1.indexOf(p1, p2) ~= nil
end
function t1.indexOf(p3, p4) -- line: 34
	-- upvalues: t1 (copy)
	local v8 = table.find(p3, p4)

	if v8 then
		return v8
	end

	return t1.keyOf(p3, p4)
end
function t1.keyOf(p5, p6) -- line: 43
	for k, v in pairs(p5) do
		if v == p6 then
			return k
		end
	end

	return nil
end
function t1.insertAndGetIndexOf(p7, p8) -- line: 53
	p7[#p7 + 1] = p8

	return #p7
end
function t1.skip(p9, p10) -- line: 59
	return table.move(p9, p10 + 1, #p9, 1, table.create(#p9 - p10))
end
function t1.take(p11, p12) -- line: 64
	return table.move(p11, 1, p12, 1, table.create(p12))
end
function t1.range(p13, p14, p15) -- line: 69
	return table.move(p13, p14, p15, 1, table.create(p15 - p14 + 1))
end
function t1.skipAndTake(p16, p17, p18) -- line: 74
	return table.move(p16, p17 + 1, p17 + p18, 1, table.create(p18))
end
function t1.random(p19) -- line: 79
	-- upvalues: random (copy)
	return p19[random:NextInteger(1, #p19)]
end
function t1.join(p20, p21) -- line: 84
	local t2 = table.create(#p20 + #p21)

	table.move(p20, 1, #p20, 1, t2)

	return table.move(p21, 1, #p21, #p20 + 1, t2)
end
function t1.removeObject(p22, p23) -- line: 91
	-- upvalues: t1 (copy)
	local v31 = t1.indexOf(p22, p23)

	if v31 then
		table.remove(p22, v31)
	end
end

return (setmetatable({}, {
	__index = function(_, p25) --[[ __index ]] -- line: 99
		-- upvalues: t1 (copy), _table (copy)
		if t1[p25] ~= nil then
			return t1[p25]
		end

		return _table[p25]
	end,
	__newindex = function(_, _, _) --[[ __newindex ]] -- line: 107
		error("Add new table entries by editing the Module itself.")
	end
}))
