-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = { 1, 4, 3, 2, 5, 6 }
local t2 = {}

local function buildOrder(p1) --[[ buildOrder | Line: 12 | Upvalues: t (copy) ]]
	-- structuring failed for function 1; please report this in our discord https://discord.gg/y63m4zUYa4
end

function t2.ArrangeEntries(p1) --[[ ArrangeEntries | Line: 45 | Upvalues: buildOrder (copy) ]]
	local v1 = #p1

	if v1 <= 1 then
		return table.clone(p1)
	end

	local v2 = buildOrder(v1)
	local v3 = table.create(v1)

	for i, v in ipairs(p1) do
		v3[v2[i]] = v
	end

	return v3
end
function t2.GetDisplayIndex(p1, p2) --[[ GetDisplayIndex | Line: 61 | Upvalues: buildOrder (copy) ]]
	assert(if p1 >= 1 then if p1 <= p2 then true else false else false, "Invalid rarity index")

	local v2 = buildOrder(p2)[p1]

	assert(v2 ~= nil, "Failed to compute display index")

	return v2
end
function t2.GetOrder(p1) --[[ GetOrder | Line: 72 | Upvalues: buildOrder (copy) ]]
	return buildOrder(p1)
end

return t2