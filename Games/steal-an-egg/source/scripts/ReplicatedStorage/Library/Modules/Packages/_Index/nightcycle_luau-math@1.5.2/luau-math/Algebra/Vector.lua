-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

function t.__index(p1, p2) --[[ __index | Line: 7 | Upvalues: t (copy) ]]
	if p2 == "_scalars" then
		error("Don\'t try to index private variables")
	end

	if p2 == "Unit" then
		local v1 = 0

		for i, v in ipairs((rawget(p1, "_scalars"))) do
			v1 = math.max(v1, (math.abs(v)))
		end

		local t2 = {}

		for i, v in ipairs((rawget(p1, "_scalars"))) do
			t2[i] = v / v1
		end

		return t.new(unpack(t2))
	end

	local v4 = rawget(p1, p2)

	if not v4 then
		v4 = rawget(p1, "_scalars")[p2]

		if not v4 then
			v4 = rawget(t, p2)
		end
	end

	return v4
end
function t.__newindex(p1, p2, p3) --[[ __newindex | Line: 27 ]]
	error("You can\'t change values of this vector post-construction")
end
function t.__add(p1, p2) --[[ __add | Line: 32 | Upvalues: t (copy) ]]
	local t2 = {}

	for i, v in ipairs((rawget(p1, "_scalars"))) do
		if type(p2) == "table" and p2.Type == "Vector" then
			t2[i] = v + (p2[i] or 0)

			continue
		end

		t2[i] = v + p2
	end

	return t.new(unpack(t2))
end
function t.__sub(p1, p2) --[[ __sub | Line: 45 | Upvalues: t (copy) ]]
	local t2 = {}

	for i, v in ipairs((rawget(p1, "_scalars"))) do
		if type(p2) == "table" and p2.Type == "Vector" then
			t2[i] = v - (p2[i] or 0)

			continue
		end

		t2[i] = v - p2
	end

	return t.new(unpack(t2))
end
function t.__mul(p1, p2) --[[ __mul | Line: 58 | Upvalues: t (copy) ]]
	if typeof(p2) == "table" then
		local t2 = {}

		for i, v in ipairs((rawget(p1, "_scalars"))) do
			t2[i] = v * p2[i]
		end

		return t.new(unpack(t2))
	end

	if typeof(p2) ~= "number" then
		error("Bad value")
	end

	local t2 = {}

	for i, v in ipairs((rawget(p1, "_scalars"))) do
		t2[i] = v * p2
	end

	return t.new(unpack(t2))
end
function t.__div(p1, p2) --[[ __div | Line: 77 | Upvalues: t (copy) ]]
	if typeof(p2) == "table" then
		local t2 = {}

		for i, v in ipairs((rawget(p1, "_scalars"))) do
			t2[i] = v / p2[i]
		end

		return t.new(unpack(t2))
	end

	if typeof(p2) ~= "number" then
		error("Bad value")
	end

	local t2 = {}

	for i, v in ipairs((rawget(p1, "_scalars"))) do
		t2[i] = v / p2
	end

	return t.new(unpack(t2))
end
function t.__pow(p1, p2) --[[ __pow | Line: 96 | Upvalues: t (copy) ]]
	if typeof(p2) == "table" then
		local t2 = {}

		for i, v in ipairs((rawget(p1, "_scalars"))) do
			t2[i] = v ^ p2[i]
		end

		return t.new(unpack(t2))
	end

	if typeof(p2) ~= "number" then
		error("Bad value")
	end

	local t2 = {}

	for i, v in ipairs((rawget(p1, "_scalars"))) do
		t2[i] = v ^ p2
	end

	return t.new(unpack(t2))
end
function t.__mod(p1, p2) --[[ __mod | Line: 115 | Upvalues: t (copy) ]]
	if typeof(p2) == "table" then
		local t2 = {}

		for i, v in ipairs((rawget(p1, "_scalars"))) do
			t2[i] = v % p2[i]
		end

		return t.new(unpack(t2))
	end

	if typeof(p2) ~= "number" then
		error("Bad value")
	end

	local t2 = {}

	for i, v in ipairs((rawget(p1, "_scalars"))) do
		t2[i] = v % p2
	end

	return t.new(unpack(t2))
end
function t.__eq(p1, p2) --[[ __eq | Line: 134 ]]
	if p2 == false then
		return false
	end

	if typeof(p2) ~= "table" or p2.Type ~= "Vector" then
		return false
	end

	for i, v in ipairs((rawget(p1, "_scalars"))) do
		if v ~= p2[i] then
			return false
		end
	end

	return true
end
function t.__tostring(p1) --[[ __tostring | Line: 151 ]]
	local v1 = p1:ToScalars()
	local v2 = "["

	for i = 1, p1.Size do
		if i ~= 1 then
			v2 = v2 .. ""
		end

		v2 = v2 .. "" .. tostring(v1[i]) .. ""

		if i < p1.Size then
			v2 = v2 .. ","
		end
	end

	return v2 .. "]"
end
function t.ToScalars(p1) --[[ ToScalars | Line: 168 ]]
	local t = {}

	for i, v in ipairs((rawget(p1, "_scalars"))) do
		assert(if v == nil then false elseif typeof(v) == "number" then true else false)
		table.insert(t, v)
	end

	return t
end
function t.Round(p1, p2) --[[ Round | Line: 178 | Upvalues: t (copy) ]]
	assert(if typeof(p2) == "number" then true elseif p2 == nil then true else false)

	local v2 = p2 or 0

	assert(if v2 == nil then false else true)

	local v4 = 10 ^ v2
	local t2 = {}

	for i, v in ipairs((rawget(p1, "_scalars"))) do
		t2[i] = math.round(v * v4) / v4
	end

	return t.new(unpack(t2))
end
function t.Floor(p1, p2) --[[ Floor | Line: 191 | Upvalues: t (copy) ]]
	assert(if typeof(p2) == "number" then true elseif p2 == nil then true else false)

	local v2 = 10 ^ (p2 or 0 or 0)
	local t2 = {}

	for i, v in ipairs((rawget(p1, "_scalars"))) do
		t2[i] = math.floor(v / v2) * v2
	end

	return t.new(unpack(t2))
end
function t.Ceil(p1, p2) --[[ Ceil | Line: 203 | Upvalues: t (copy) ]]
	assert(if typeof(p2) == "number" then true elseif p2 == nil then true else false)

	local v2 = 10 ^ (p2 or 0 or 0)
	local t2 = {}

	for i, v in ipairs((rawget(p1, "_scalars"))) do
		t2[i] = math.ceil(v / v2) * v2
	end

	return t.new(unpack(t2))
end
function t.Cross(p1, p2) --[[ Cross | Line: 215 | Upvalues: t (copy) ]]
	assert(if type(p2) == "table" then true else false)
	assert(p2.Size == p1.Size, "Size mismatch")

	if p1.Size == 3 then
		local v2 = p1[1]
		local v3 = p1[2]
		local v4 = p1[3]
		local v5 = p2[1]
		local v6 = p2[2]
		local v7 = p2[3]

		assert(if v2 == nil or v3 == nil then false elseif v4 == nil then false else true)
		assert(if v5 == nil or v6 == nil then false elseif v7 == nil then false else true)
		assert(if typeof(v2) == "number" and typeof(v3) == "number" then if typeof(v4) == "number" then true else false else false)
		assert(if typeof(v5) == "number" and typeof(v6) == "number" then if typeof(v7) == "number" then true else false else false)

		return t.new(v3 * v7 - v6 * v4, v4 * v5 - v7 * v2, v2 * v6 - v5 * v3)
	end

	if p1.Size ~= 7 then
		error("Cross products are currently only supported in the 3rd and 7th dimension")
	end

	local v12 = p1[1]
	local v13 = p1[2]
	local v14 = p1[3]
	local v15 = p1[4]
	local v16 = p1[5]
	local v17 = p1[6]
	local v18 = p1[7]
	local v19 = p2[1]
	local v20 = p2[2]
	local v21 = p2[3]
	local v22 = p2[4]
	local v23 = p2[5]
	local v24 = p2[6]
	local v25 = p2[7]

	assert(if v12 == nil or (v13 == nil or (v14 == nil or (v15 == nil or (v16 == nil or v17 == nil)))) then false elseif v18 == nil then false else true)
	assert(if v19 == nil or (v20 == nil or (v21 == nil or (v22 == nil or (v23 == nil or v24 == nil)))) then false elseif v25 == nil then false else true)
	assert(if typeof(v12) == "number" and (typeof(v13) == "number" and (typeof(v14) == "number" and (typeof(v15) == "number" and (typeof(v16) == "number" and typeof(v17) == "number")))) then if typeof(v18) == "number" then true else false else false)
	assert(if typeof(v19) == "number" and (typeof(v20) == "number" and (typeof(v21) == "number" and (typeof(v22) == "number" and (typeof(v23) == "number" and typeof(v24) == "number")))) then if typeof(v25) == "number" then true else false else false)

	return t.new(v13 * v22 - v15 * v20 + v14 * v25 - v18 * v21 + v16 * v24 + v17 * v24, v14 * v23 - v16 * v21 + v15 * v19 - v12 * v22 + v17 * v25 - v18 * v24, v15 * v24 - v17 * v22 + v16 * v20 - v13 * v23 + v18 * v19 - v12 * v25, v16 * v25 - v18 * v23 + v17 * v21 - v14 * v24 + v12 * v20 - v13 * v19, v17 * v19 - v12 * v24 + v18 * v22 - v15 * v25 + v13 * v21 - v14 * v20, v18 * v20 - v13 * v25 + v12 * v23 - v16 * v19 + v14 * v22 - v14 * v21, v12 * v21 - v14 * v19 + v13 * v24 - v17 * v20 + v15 * v23 - v16 * v22)
end
function t.DotProduct(p1, p2) --[[ DotProduct | Line: 273 | Upvalues: t (copy) ]]
	assert(if type(p2) == "table" then true else false)
	assert(p2.Size == p1.Size, "Size mismatch")

	local t2 = {}

	for i = 1, p1.Size do
		t2[i] = p1[i] * p2[i]
	end

	return t.new(unpack(t2))
end
function t.Dot(p1, p2) --[[ Dot | Line: 286 ]]
	local sum = 0

	for i, v in ipairs(p1:DotProduct(p2):ToScalars()) do
		sum = sum + v
	end

	return sum
end
function t.Lerp(p1, p2, p3) --[[ Lerp | Line: 296 | Upvalues: t (copy) ]]
	local t2 = {}

	for i, v in ipairs((rawget(p1, "_scalars"))) do
		t2[i] = v + (p2[i] - v) * p3
	end

	return t.new(unpack(t2))
end
function t.ToVector3(p1) --[[ ToVector3 | Line: 305 ]]
	local v1 = p1:ToScalars()

	return Vector3.new(v1[1] or 0, v1[2] or 0, v1[3] or 0)
end
function t.ToVector2(p1) --[[ ToVector2 | Line: 311 ]]
	local v1 = p1:ToScalars()

	return Vector2.new(v1[1] or 0, v1[2] or 0)
end
function t.zero(p1) --[[ zero | Line: 317 | Upvalues: t (copy) ]]
	local t2 = {}

	for i = 1, p1 do
		table.insert(t2, 0)
	end

	return t.new(unpack(t2))
end
function t.fromVector3(p1) --[[ fromVector3 | Line: 326 | Upvalues: t (copy) ]]
	return t.new(p1.X, p1.Y, p1.Z)
end
function t.fromVector2(p1) --[[ fromVector2 | Line: 331 | Upvalues: t (copy) ]]
	return t.new(p1.X, p1.Y)
end
function t.one(p1) --[[ one | Line: 336 | Upvalues: t (copy) ]]
	local t2 = {}

	for i = 1, p1 do
		table.insert(t2, 1)
	end

	return t.new(unpack(t2))
end
function t.identity(p1, p2) --[[ identity | Line: 345 | Upvalues: t (copy) ]]
	local t2 = {}

	for i = 1, p1 do
		if i == p2 then
			table.insert(t2, 1)

			continue
		end

		table.insert(t2, 0)
	end

	return t.new(unpack(t2))
end
function t.new(...) --[[ new | Line: 370 | Upvalues: t (copy) ]]
	local t2 = {
		_scalars = { ... }
	}

	assert(typeof(t2._scalars) == "table")
	t2.Size = #t2._scalars
	t2.Type = "Vector"
	t2.Magnitude = 0

	for i, v in ipairs(t2._scalars) do
		t2.Magnitude = t2.Magnitude + v ^ 2
	end

	t2.Magnitude = math.sqrt(t2.Magnitude)
	setmetatable(t2, t)

	return t2
end

return t