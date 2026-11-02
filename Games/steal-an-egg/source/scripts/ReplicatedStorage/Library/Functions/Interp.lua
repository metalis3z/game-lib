-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

function NumberSearch(p1, p2) --[[ NumberSearch | Line: 3 ]]
	local v1 = 1
	local v2 = #p1

	while v1 <= v2 do
		local v3 = v1 + (v2 - v1) // 2
		local v4 = p1[v3] - p2

		if v4 > 0 then
			v2 = v3 - 1
		else
			if not (v4 < 0) then
				return v3
			end

			v1 = v3 + 1
		end
	end

	return v1 - 1
end
function Map(p1, p2, p3, p4, p5) --[[ Map | Line: 23 ]]
	return p4 + (p5 - p4) * (p1 - p2) / (p3 - p2)
end
t.NumberSearch = NumberSearch
t.Map = Map
function t.Interp(p1, p2, p3) --[[ Interp | Line: 28 ]]
	assert(if type(p1) == "table" then true else false, "X must be a table")
	assert(if type(p2) == "table" then true else false, "Y must be a table")
	assert(if #p1 >= 2 then true else false, "Must have atleast 2 samples")
	assert(if #p1 == #p2 then true else false, "X and Y must have the same length")
	assert(if p3 == nil then true elseif type(p3) == "function" then true else false, "xEasing must be a function or nil")

	local v6 = table.clone(p1)
	local v7 = table.clone(p2)
	local v8 = 0
	local count = 0
	local count2 = 0

	for i = 1, #v6 do
		local v9 = v6[i]

		if p3 then
			local v10 = p3(v9)

			v6[i] = v10
			v9 = v10
		end

		if i > 1 and v8 < v9 then
			count = count + 1
		elseif i > 1 and v9 < v8 then
			count2 = count2 + 1
		end

		v8 = v9
	end

	if count > 0 then
		assert(if count2 == 0 then true else false, "Y contains both increasing and decreasing elements")
	elseif count2 > 0 then
		local v12 = #v6

		for j = 1, v12 // 2 do
			local v14 = v6[j]

			v6[j] = v6[v12 - j + 1]
			v6[v12 - j + 1] = v14

			local v16 = v7[j]

			v7[j] = v7[v12 - j + 1]
			v7[v12 - j + 1] = v16
		end
	end

	return function(p1) --[[ Line: 75 | Upvalues: p3 (copy), v6 (ref), v7 (ref) ]]
		if p3 then
			p1 = p3(p1)
		end

		local v4 = math.clamp(NumberSearch(v6, p1), 1, #v6 - 1)

		return Map(p1, v6[v4], v6[v4 + 1], v7[v4], v7[v4 + 1])
	end
end
function t.InterpFunction(p1, p2, p3, p4, p5) --[[ InterpFunction | Line: 83 | Upvalues: t (copy) ]]
	assert(if type(p1) == "function" then true else false, "f must be a function")
	assert(if type(p2) == "number" then true else false, "xMin must be a number")
	assert(if type(p3) == "number" then true else false, "xMax must be a number")
	assert(if p2 == p3 then false else true, "xMin cannot equal xMax")
	assert(if type(p4) == "number" then true else false, "step must be a number")
	assert(if p4 > 0 then true else false, "xStep must positive")
	assert(if p5 == nil then true elseif type(p5) == "function" then true else false, "xEasing must be a function or nil")

	local v10 = math.max(math.ceil(math.abs(p3 - p2) / p4) + 1, 3)

	warn("This function is sub-optimal and needs to not do a binary search on x")

	local v11 = table.create(0, v10)
	local v12 = table.create(0, v10)
	local v13 = v11

	for i = 1, v10 do
		local v14 = p2 + (i - 1) * (p3 - p2) / (v10 - 1)
		local v15 = p1(v14)

		v13[i] = v14
		v12[i] = v15
	end

	return t.Interp(v13, v12, p5)
end
function t.InverseInterp(p1, p2, p3) --[[ InverseInterp | Line: 107 | Upvalues: t (copy) ]]
	return t.Interp(p2, p1, p3)
end
function t.InverseInterpFunction(p1, p2, p3, p4, p5) --[[ InverseInterpFunction | Line: 110 | Upvalues: t (copy) ]]
	assert(if type(p1) == "function" then true else false, "f must be a function")
	assert(if type(p2) == "number" then true else false, "xMin must be a number")
	assert(if type(p3) == "number" then true else false, "xMax must be a number")
	assert(if p2 == p3 then false else true, "xMin cannot equal xMax")
	assert(if type(p4) == "number" then true else false, "step must be a number")
	assert(if p4 > 0 then true else false, "xStep must positive")
	assert(if p5 == nil then true elseif type(p5) == "function" then true else false, "yEasing must be a function or nil")

	local v10 = math.max(math.ceil(math.abs(p3 - p2) / p4) + 1, 3)
	local v11 = table.create(0, v10)
	local v12 = table.create(0, v10)
	local v13 = v11

	for i = 1, v10 do
		local v14 = p2 + (i - 1) * (p3 - p2) / (v10 - 1)
		local v15 = p1(v14)

		v13[i] = v14
		v12[i] = v15
	end

	return t.InverseInterp(v13, v12, p5)
end

return t