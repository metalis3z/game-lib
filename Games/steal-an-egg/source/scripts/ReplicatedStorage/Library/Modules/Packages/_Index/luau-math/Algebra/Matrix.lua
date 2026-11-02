-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local Vector = require(script.Parent.Vector)

function t.new(...) --[[ new | Line: 22 | Upvalues: Vector (copy), t (copy) ]]
	local t2 = {
		_vectors = { ... }
	}

	t2.Dimensions = Vector.new(#t2._vectors, t2._vectors[1].Size)
	t2.Type = "Matrix"
	t2.Magnitude = 0

	for i, v in ipairs(t2._vectors) do
		t2.Magnitude = t2.Magnitude + v.Magnitude
	end

	setmetatable(t2, t)

	return t2
end
function t.__index(p1, p2) --[[ __index | Line: 46 | Upvalues: t (copy) ]]
	if p2 == "_vectors" then
		error("Don\'t try to index private variables")
	end

	local v1 = rawget(p1, p2)

	if not v1 then
		v1 = rawget(p1, "_vectors")[p2]

		if not v1 then
			v1 = rawget(t, p2)
		end
	end

	return v1
end
function t.__newindex(p1, p2, p3) --[[ __newindex | Line: 54 ]]
	error("You can\'t change values of this vector post-construction")
end
function t.ToVectors(p1) --[[ ToVectors | Line: 59 ]]
	local t = {}

	for i, v in ipairs((rawget(p1, "_vectors"))) do
		table.insert(t, v)
	end

	return t
end
function t.__add(p1, p2) --[[ __add | Line: 68 | Upvalues: Vector (copy), t (copy) ]]
	local t2 = {}

	for i, v in ipairs((rawget(p1, "_vectors"))) do
		assert(if typeof(p2) == "table" then true else false)

		local v2 = p2[i]

		if typeof(v2) == "table" and p2.Type == "Matrix" then
			assert(typeof(v2) ~= "number")
			assert(if getmetatable(v2) == Vector then true else false)
			t2[i] = v + v2

			continue
		end

		assert(if typeof(v2) == "number" then true else false)
		t2[i] = v + v2
	end

	return t.new(unpack(t2))
end
function t.__sub(p1, p2) --[[ __sub | Line: 93 | Upvalues: t (copy) ]]
	local t2 = {}

	for i, v in ipairs((rawget(p1, "_vectors"))) do
		assert(if typeof(p2) == "table" then true else false)

		local v2 = p2[i]

		if typeof(v2) == "table" and p2.Type == "Matrix" then
			assert(typeof(v2) ~= "number")
			t2[i] = v + v2

			continue
		end

		assert(if typeof(v2) == "number" then true else false)
		t2[i] = v + v2
	end

	return t.new(unpack(t2))
end
function t.__mul(p1, p2) --[[ __mul | Line: 115 | Upvalues: Vector (copy), t (copy) ]]
	if typeof(p2) == "table" then
		assert(if p2.Type == "Matrix" then true elseif p2.Type == "Vector" then true else false)

		if p2.Type == "Matrix" then
			assert(p1.Dimensions[1] == p1.Dimensions[2], "Bad square matrix")
			assert(p2.Dimensions == p1.Dimensions, "Bad matrix match")

			local v4 = p2:ToVectors()
			local t2 = {}

			for i, v in ipairs(p1:ToRows()) do
				local v5 = v:ToScalars()

				t2[i] = t2[i] or {}

				for i2, v7 in ipairs(v5) do
					local v72 = v4[i2]:ToScalars()
					local sum = 0

					for i3, v8 in ipairs(v5) do
						sum = sum + v8 * v72[i3]
					end

					t2[i][i2] = sum
				end

				t2[i] = Vector.new(unpack(t2[i]))
			end

			return t.new(unpack(t2)):Transpose()
		elseif p2.Type == "Vector" then
			local v10 = p2:GetScalars()
			local t2 = {}

			for i, v in ipairs((rawget(p1, "_vectors"))) do
				local v11 = v10[i]

				t2[i] = 0

				for i2, v3 in ipairs(v:GetScalars()) do
					t2[i] = t2[i] + v11 * v3
				end
			end

			return t2
		end
	else
		if typeof(p2) == "number" then
			local t2 = {}

			for i, v in ipairs((rawget(p1, "_vectors"))) do
				t2[i] = v * p2
			end

			return t.new(unpack(t2))
		end

		error("Bad value")
	end

	return nil
end
function t.__div(p1, p2) --[[ __div | Line: 169 | Upvalues: t (copy) ]]
	if typeof(p2) == "table" and p2.Type == "Matrix" then
		error("I didn\'t code matrix division")
	end

	if typeof(p2) ~= "number" then
		error("Bad value")
	end

	local t2 = {}

	for i, v in ipairs((rawget(p1, "_vectors"))) do
		t2[i] = v / p2
	end

	return t.new(unpack(t2))
end
function t.__pow(p1, p2) --[[ __pow | Line: 184 | Upvalues: t (copy) ]]
	if typeof(p2) == "table" then
		local t2 = {}

		for i, v in ipairs((rawget(p1, "_vectors"))) do
			t2[i] = v ^ p2[i]
		end

		return t.new(unpack(t2))
	end

	if typeof(p2) ~= "number" then
		error("Bad value")
	end

	local t2 = {}

	for i, v in ipairs((rawget(p1, "_vectors"))) do
		t2[i] = v ^ p2
	end

	return t.new(unpack(t2))
end
function t.__mod(p1, p2) --[[ __mod | Line: 203 | Upvalues: t (copy) ]]
	if typeof(p2) == "table" then
		local t2 = {}

		for i, v in ipairs((rawget(p1, "_vectors"))) do
			t2[i] = v % p2[i]
		end

		return t.new(unpack(t2))
	end

	if typeof(p2) ~= "number" then
		error("Bad value")
	end

	local t2 = {}

	for i, v in ipairs((rawget(p1, "_vectors"))) do
		t2[i] = v % p2
	end

	return t.new(unpack(t2))
end
function t.__eq(p1, p2) --[[ __eq | Line: 222 ]]
	if p2 == false then
		return false
	end

	if typeof(p2) ~= "table" or p2.Type ~= "Matrix" then
		return false
	end

	for i, v in ipairs((rawget(p1, "_vectors"))) do
		if v ~= p2[i] then
			return false
		end
	end

	return true
end
function t.ToRows(p1) --[[ ToRows | Line: 239 | Upvalues: Vector (copy) ]]
	local list = {}

	for i, v in ipairs((rawget(p1, "_vectors"))) do
		for i2, v2 in ipairs(v:ToScalars()) do
			list[i2] = list[i2] or {}
			table.insert(list[i2], v2)
		end
	end

	local t = {}

	for i, v in ipairs(list) do
		t[i] = Vector.new(unpack(v))
	end

	return t
end
function t.Transpose(p1) --[[ Transpose | Line: 256 | Upvalues: t (copy) ]]
	return t.new(unpack((p1:ToRows())))
end
function t.__tostring(p1) --[[ __tostring | Line: 262 ]]
	local v2 = ""

	for i, v in ipairs((p1:ToRows())) do
		local v3 = ""

		if i ~= 1 then
			v3 = v3 .. "\n"
		end

		for i2, v4 in ipairs(v) do
			if i2 == 1 then
				v3 = tostring(v4)

				continue
			end

			v3 = v3 .. "|" .. tostring(v4)
		end

		v2 = v2 .. v3
	end

	return v2
end
function t.one(p1) --[[ one | Line: 283 | Upvalues: Vector (copy) ]]
	local t = {}

	for i = 1, p1[1] do
		table.insert(t, Vector.one(p1[2]))
	end

	return Vector.new(unpack(t))
end
function t.identity(p1) --[[ identity | Line: 292 | Upvalues: Vector (copy) ]]
	local t = {}

	for i = 1, p1[1] do
		table.insert(t, Vector.identity(p1[2], i))
	end

	return Vector.new(unpack(t))
end

return t