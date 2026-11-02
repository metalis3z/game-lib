--credit to prince games studio
local function hash(p1, p2, p3) --[[ hash | Line: 48 ]]
	return (bit32.band(p1, 262143) * 262144 + bit32.band(p3, 262143)) * 131072 + bit32.band(p2, 131071)
end

local function quantize(p1, p2) --[[ quantize | Line: 54 ]]
	return p1.X // p2, p1.Y // p2, p1.Z // p2
end

local function key(p1, p2) --[[ key | Line: 58 ]]
	return (bit32.band(p1.X // p2, 262143) * 262144 + bit32.band(p1.Z // p2, 262143)) * 131072 + bit32.band(p1.Y // p2, 131071)
end

local t = {}
local v1 = table.freeze({
	__index = t
})

function t.Insert(p1, p2, p3) --[[ Insert | Line: 68 ]]
	assert(if typeof(p2) == "Vector3" then true else false)

	local Epsilon = p1.Epsilon
	local v5 = (bit32.band(p2.X // Epsilon, 262143) * 262144 + bit32.band(p2.Z // Epsilon, 262143)) * 131072 + bit32.band(p2.Y // Epsilon, 131071)
	local Table = p1.Table

	if not Table[v5] then
		Table[v5] = {}
	end

	table.insert(Table[v5], {
		Pos = p2,
		Value = p3
	})
end
function t.Remove(p1, p2, p3) --[[ Remove | Line: 80 ]]
	assert(if typeof(p2) == "Vector3" then true else false)

	local Epsilon = p1.Epsilon
	local v5 = (bit32.band(p2.X // Epsilon, 262143) * 262144 + bit32.band(p2.Z // Epsilon, 262143)) * 131072 + bit32.band(p2.Y // Epsilon, 131071)
	local v6 = p1.Table[v5]

	if not v6 then
		return
	end

	for i = #v6, 1, -1 do
		if v6[i].Value == p3 then
			table.remove(v6, i)
		end
	end

	if #v6 ~= 0 then
		return
	end

	p1.Table[v5] = nil
end
function t.Collect(p1, p2, p3) --[[ Collect | Line: 99 ]]
	assert(if typeof(p2) == "Vector3" then true else false)
	assert(if p3 == nil then true elseif type(p3) == "number" and p3 > 0 then if math.floor(p3) == p3 then true else false else false)

	local Epsilon = p1.Epsilon
	local v3 = p2.X // Epsilon
	local v4 = p2.Y // Epsilon
	local v5 = p2.Z // Epsilon
	local Table = p1.Table
	local v6 = p3 or 1
	local count = 0
	local t = {}

	for i = -v6, v6 do
		for j = -v6, v6 do
			for k = -v6, v6 do
				local v7 = Table[(bit32.band(v3 + i, 262143) * 262144 + bit32.band(v5 + k, 262143)) * 131072 + bit32.band(v4 + j, 131071)]

				if v7 then
					for i2, v in ipairs(v7) do
						count = count + 1
						t[count] = v.Value
					end
				end
			end
		end
	end

	t.n = count

	return t
end
function t.Query(p1, p2, p3) --[[ Query | Line: 128 ]]
	assert(if typeof(p2) == "Vector3" then true else false)
	assert(if p3 == nil then true elseif type(p3) == "number" and p3 > 0 then if math.floor(p3) == p3 then true else false else false)

	local Epsilon = p1.Epsilon
	local v3 = p2.X // Epsilon
	local v4 = p2.Y // Epsilon
	local v5 = p2.Z // Epsilon
	local Table = p1.Table
	local v6 = p3 or 1
	local v7 = nil
	local v8 = nil

	for i = -v6, v6 do
		for j = -v6, v6 do
			for k = -v6, v6 do
				local v9 = Table[(bit32.band(v3 + i, 262143) * 262144 + bit32.band(v5 + k, 262143)) * 131072 + bit32.band(v4 + j, 131071)]

				if v9 then
					for i2, v in ipairs(v9) do
						local Magnitude = (v.Pos - p2).Magnitude

						if not v7 or Magnitude < v7 then
							v8 = v.Value
							v7 = Magnitude
						end
					end
				end
			end
		end
	end

	return v8
end
table.freeze(t)

return table.freeze({
	new = function(p1, p2) --[[ new | Line: 163 | Upvalues: v1 (copy) ]]
		assert(if p1 == nil then true elseif type(p1) == "number" then if p1 > 0 then true else false else false)

		return setmetatable({
			Table = {},
			Epsilon = p1 or 10
		}, v1)
	end
})