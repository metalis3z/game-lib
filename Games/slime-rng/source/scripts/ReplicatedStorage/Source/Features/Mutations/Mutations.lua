-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: Mutations, time of decompilation: Sun May  3 10:11:39 2026 ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Source.Game.Items.DataTemplate)

local t1 = {
	big = {
		id = "big",
		name = "BIG",
		category = "size",
		value = 2,
		odds = 0.01,
		iconZoom = 1.66,
		sizeScale = 1.5,
		statMultiplier = 4
	},
	huge = {
		id = "huge",
		name = "HUGE",
		category = "size",
		value = 3,
		odds = 0.001,
		iconZoom = 2,
		sizeScale = 2.2,
		statMultiplier = 10
	},
	shiny = {
		id = "shiny",
		name = "Shiny",
		category = "modifier",
		value = 1,
		odds = 0.004,
		statMultiplier = 6
	},
	inverted = {
		id = "inverted",
		name = "Inverted",
		category = "modifier",
		value = 4,
		odds = 0.0004,
		statMultiplier = 13
	}
}
local t2 = {}

for v4, v5 in t1 do
	assert(v5.value ~= nil, "Mutation must have a value")
	assert(t2[v5.value] == nil, "Duplicate mutation value: " .. v5.value .. " for mutation " .. v4)
	t2[v5.value] = v4
end

local t3 = {
	size = {},
	modifier = {}
}

for _, v8 in t2 do
	table.insert(t3[t1[v8].category], v8)
end

local t4 = {
	mutations = t1,
	sortedMutations = t2,
	sizeMutations = t3.size,
	modifierMutations = t3.modifier,
	get = function(p1) --[[ get ]] -- line: 89
		-- upvalues: t1 (copy)
		return t1[p1]
	end,
	getByValue = function(n1: number) --[[ getByValue ]] -- line: 93
		-- upvalues: t1 (copy), t2 (copy)
		return t1[t2[n1]]
	end,
	has = function(p2, p3) --[[ has ]] -- line: 97
		return p2 ~= nil and p2[p3] == true
	end
}

function t4.getIds(p4) -- line: 101
	-- upvalues: t4 (copy)
	local t5 = {}

	if not p4 then
		return t5
	end

	for _, v17 in t4.sortedMutations do
		if p4[v17] then
			table.insert(t5, v17)
		end
	end

	return t5
end
function t4.getCategoryIds(s1: string) -- line: 116
	-- upvalues: t3 (copy)
	return t3[s1]
end
function t4.hasAny(p5) -- line: 120
	-- upvalues: t4 (copy)
	if not p5 then
		return false
	end

	for _, v21 in t4.sortedMutations do
		if p5[v21] then
			return true
		end
	end

	return false
end
function t4.getSizeMutationId(p6) -- line: 134
	-- upvalues: t3 (copy)
	if not p6 then
		return nil
	end

	for _, v24 in t3.size do
		if p6[v24] then
			return v24
		end
	end

	return nil
end
function t4.getSizeScale(p7) -- line: 148
	-- upvalues: t4 (copy)
	local v26 = t4.getSizeMutationId(p7)

	if v26 == nil then
		return 1
	end

	return t4.get(v26).sizeScale or 1
end
function t4.getIconZoom(p8) -- line: 157
	-- upvalues: t4 (copy)
	local v28 = t4.getSizeMutationId(p8)

	if v28 == nil then
		return 1
	end

	local v29 = t4.get(v28)

	return v29.iconZoom or (v29.sizeScale or 1)
end
function t4.getDisplayName(s2: string, p9) -- line: 167
	-- upvalues: t4 (copy)
	local v32 = t4.getIds(p9)

	if #v32 == 0 then
		return s2
	end

	local t6 = table.create(#v32)

	for _, v35 in v32 do
		table.insert(t6, t4.get(v35).name)
	end

	table.insert(t6, s2)

	return table.concat(t6, " ")
end
function t4.getVisualOddsMultiplier(p10) -- line: 182
	-- upvalues: t4 (copy)
	if not p10 then
		return 1
	end

	local n2 = 1
	local v38 = t4.getSizeMutationId(p10)

	for _, v40 in t4.sortedMutations do
		local v41 = t4.get(v40)

		if (v41.category ~= "size" or v40 == v38) and p10[v40] and v41.odds > 0 then
			n2 *= 1 / v41.odds
		end
	end

	return n2
end
function t4.getStatBonus(p11, s3: string) -- line: 202
	-- upvalues: t4 (copy)
	if not p11 then
		return 1
	end

	local n3 = 1

	for _, v46 in t4.sortedMutations do
		if p11[v46] and (s3 == "health" or s3 == "maxHealth" or s3 == "damage") then
			n3 *= t4.get(v46).statMultiplier
		end
	end

	return n3
end

return t4
