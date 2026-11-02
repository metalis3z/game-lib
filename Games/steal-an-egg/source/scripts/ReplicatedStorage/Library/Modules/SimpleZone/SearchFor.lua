-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function splitRecursiveProperty(p1) --[[ splitRecursiveProperty | Line: 1 ]]
	local v1 = p1:split("_")

	return v1[1], if #v1 > 1 then table.concat(v1, "_", 2, #v1) else false
end

local function propertyChecker(p1, p2, p3, p4) --[[ propertyChecker | Line: 9 ]]
	for v2, v3 in p4 do
		local v1
		local v4 = v2:split("_")
		local v5 = v4[1]

		v1 = if #v4 > 1 then table.concat(v4, "_", 2, #v4) else false

		if v5 == "Parent" and v1 then
			p3(SearchFor({ p1.Parent }, {
				[v1] = v3
			}, p2)[p1.Parent])

			continue
		end

		if p1:FindFirstChild(v5) and v1 then
			p3(SearchFor({ p1:FindFirstChild(v5) }, {
				[v1] = v3
			}, p2)[p1.Parent])

			continue
		end

		if v3 == "Tag" then
			p3(p1:HasTag(v5))

			continue
		end

		if v5:match("Attribute_") then
			p3(if p1:GetAttribute(v5:split("_")[2]) == v3 then true else false)

			continue
		end

		p3(p1[v5] == v3)
	end
end

function SearchFor(p1, p2, p3) --[[ SearchFor | Line: 44 | Upvalues: propertyChecker (copy) ]]
	assert(if p3 == nil then false elseif p3 == "Or" then true elseif p3 == "And" then true else false, "Bad mode argument.")

	local t = {}

	for v2, v3 in p1 do
		local v4 = false

		propertyChecker(v3, p3, function(p1) --[[ checkCondition | Line: 52 | Upvalues: p3 (copy), t (copy), v3 (copy), v4 (ref) ]]
			if p1 and p3 == "Or" then
				table.insert(t, v3)

				return
			end

			if p1 or p3 ~= "And" then
				return
			end

			v4 = true
		end, p2)

		if not v4 and p3 == "And" then
			table.insert(t, v3)
		end
	end

	return t
end

return SearchFor