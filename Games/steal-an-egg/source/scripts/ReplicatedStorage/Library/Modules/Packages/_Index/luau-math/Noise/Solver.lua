-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
require(script.Parent.Parent.Types)

local Vector = require(script.Parent.Parent.Algebra.Vector)
local Matrix = require(script.Parent.Parent.Algebra.Matrix)

function t.translateVector(p1) --[[ translateVector | Line: 17 | Upvalues: Vector (copy) ]]
	assert(p1 ~= nil)

	if typeof(p1) == "Vector2" then
		return Vector.new(p1.X, p1.Y)
	end

	if typeof(p1) == "Vector3" then
		return Vector.new(p1.X, p1.Y, p1.Z)
	end

	assert(if typeof(p1) == "Vector2" then false elseif typeof(p1) == "Vector3" then false else true)
	assert(getmetatable(p1) == Vector)

	return p1
end
function t.__newindex(p1, p2, p3) --[[ __newindex | Line: 29 ]]
	if p1[p2] == nil then
		error(tostring(p2) .. " is not a valid solver property")
	end

	rawset(p1, p2, p3)

	return nil
end
function t._Rand(p1, p2) --[[ _Rand | Line: 39 ]]
	local v1 = p2:ToScalars()
	local Seed = p1.Seed

	for i, v in ipairs(v1) do
		Seed = Seed + 1 * Random.new(i * v * 1000):NextInteger(1, 100000) % (Seed / 100)
	end

	return Random.new(Seed):NextNumber()
end
function t._SetSeparationLimit(p1) --[[ _SetSeparationLimit | Line: 48 | Upvalues: Vector (copy) ]]
	local Points = p1.Points

	if #Points <= 1 then
		rawset(p1, "SeparationLimit", 0)

		return nil
	end

	local list = {}

	local function setClosest(p1) --[[ setClosest | Line: 56 | Upvalues: Points (copy), Vector (ref), list (copy) ]]
		local v1 = nil
		local v2 = (1 / 0)

		for i, v in ipairs(Points) do
			assert(if getmetatable(v) == Vector then true else false)

			if not Vector.__eq(v, p1) then
				local Magnitude = Vector.__sub(v, p1).Magnitude

				if Magnitude and (not v1 or Magnitude < v2) then
					v1 = v
					v2 = Magnitude
				end
			end
		end

		table.insert(list, v2)
	end

	for i, v in ipairs(Points) do
		setClosest(v)
	end

	local v1 = list[1]

	for i, v in ipairs(list) do
		v1 = math.max(v, v1)
	end

	rawset(p1, "SeparationLimit", v1)

	return nil
end
function t._CopyConfiguration(p1, p2) --[[ _CopyConfiguration | Line: 83 ]]
	for k, v in pairs(p1) do
		if typeof(v) == "number" or typeof(v) == "EnumItem" then
			p2[k] = v

			continue
		end

		if typeof(v) == "table" then
			local t = {}

			if k == "Octaves" then
				for k2, v2 in pairs(v) do
					t[k2] = v2:Clone()
				end
			else
				for k2, v2 in pairs(v) do
					t[k2] = v2
				end
			end

			p1[k] = t
		end
	end

	return nil
end
function t.ToMatrix(p1, p2) --[[ ToMatrix | Line: 105 | Upvalues: Vector (copy), Matrix (copy) ]]
	local count = 0
	local sum = 0
	local t = {}

	for i = 1, p2 do
		local t2 = {}

		for j = 1, p2 do
			local v1 = tick()

			t2[j] = p1:Get(Vector.new(i - 1, j - 1) / p2)
			sum = sum + (tick() - v1)
			count = count + 1
		end

		t[i] = Vector.new(unpack(t2))
	end

	return Matrix.new(unpack(t))
end
function t.Debug(p1, p2, p3, p4, p5, p6) --[[ Debug | Line: 124 | Upvalues: Vector (copy) ]]
	local v1 = p3 or 1

	assert(if v1 == nil then false else true)

	local v3 = p5 or p4
	local v4 = p6 or v3

	for i, v in ipairs(p4:ToVectors()) do
		for i2, v5 in ipairs(v:ToScalars()) do
			local v52 = v3[i][i2]
			local v6 = v4[i][i2]
			local Frame = Instance.new("Frame")

			Frame.Name = tostring(Vector.new(i, i2))
			Frame:SetAttribute("R", v5)
			Frame:SetAttribute("G", v52)
			Frame:SetAttribute("B", v6)
			Frame.BackgroundColor3 = Color3.new(math.clamp(v5, 0, 1), math.clamp(v52, 0, 1), (math.clamp(v6, 0, 1)))
			Frame.Position = UDim2.fromOffset(i * v1, i2 * v1)
			Frame.AnchorPoint = Vector2.new(0.5, 0.5)
			Frame.Size = UDim2.fromOffset(1 * v1, 1 * v1)
			Frame.BorderSizePixel = 0
			Frame.Parent = p2
		end
	end

	return nil
end
function t._Compile(p1, p2, p3) --[[ _Compile | Line: 150 ]]
	local sum = 0

	for k, v in pairs(p1.Octaves) do
		sum = sum + v:Get(p2)
	end

	return p1.Amplitude * (p3 + sum)
end
function t._UpdateOctaves(p1) --[[ _UpdateOctaves | Line: 158 ]]
	for i, v in ipairs(p1.Octaves) do
		v:Set(nil, p1.Frequency * p1.Lacunarity ^ i, p1.Amplitude * p1.Persistence ^ i)
	end

	return nil
end
function t._TranslatePoints(p1, p2) --[[ _TranslatePoints | Line: 172 | Upvalues: t (copy) ]]
	local t2 = {}

	for i, v in ipairs(p2) do
		table.insert(t2, t.translateVector(v))
	end

	return t2
end
function t.GeneratePoints(p1, p2, p3, p4) --[[ GeneratePoints | Line: 181 | Upvalues: Vector (copy) ]]
	assert(if p2 > 0 then true else false, "Bad count")
	assert(if getmetatable(p3) == Vector then true else false)
	assert(if getmetatable(p4) == Vector then true else false)

	local v4 = Vector.__sub(p4, p3)
	local v5 = Random.new(p1.Seed)
	local t = {}

	for i = 1, p2 do
		local t2 = {}

		for j = 1, v4.Size do
			t2[j] = p3[j] + v5:NextNumber() * v4[j]
		end

		table.insert(t, Vector.new(unpack(t2)))
	end

	rawset(p1, "Points", t)
	p1:_SetSeparationLimit()

	return nil
end
function t.SetPoints(p1, p2) --[[ SetPoints | Line: 202 ]]
	assert(if p2 == nil then false else true, "Bad point vectors")
	rawset(p1, "Points", p1:_TranslatePoints(p2))
	p1:_SetSeparationLimit()

	return nil
end
function t.InsertOctave(p1, p2) --[[ InsertOctave | Line: 210 ]]
	assert(if p2 == nil then false else true, "Bad octave solver")
	table.insert(p1.Octaves, p2)
	p1:_UpdateOctaves()

	return nil
end
function t.SetPersistence(p1, p2) --[[ SetPersistence | Line: 218 ]]
	assert(if p2 == nil then false elseif type(p2) == "number" then true else false, "Bad persistence")
	rawset(p1, "Persistence", if p2 then p2 else p1.Persistence)
	p1:_UpdateOctaves()

	return nil
end
function t.SetLacunarity(p1, p2) --[[ SetLacunarity | Line: 226 ]]
	assert(if p2 == nil then false elseif type(p2) == "number" then true else false, "Bad lacunarity")
	rawset(p1, "Lacunarity", if p2 then p2 else p1.Lacunarity)
	p1:_UpdateOctaves()

	return nil
end
function t.SetAmplitude(p1, p2) --[[ SetAmplitude | Line: 234 ]]
	assert(if p2 == nil then false elseif type(p2) == "number" then true else false, "Bad amplitude")
	rawset(p1, "Amplitude", if p2 then p2 else p1.Amplitude)
	p1:_UpdateOctaves()

	return nil
end
function t.SetFrequency(p1, p2) --[[ SetFrequency | Line: 242 ]]
	assert(if p2 == nil then false elseif type(p2) == "number" then true else false, "Bad frequency")
	rawset(p1, "Frequency", p2)
	p1:_UpdateOctaves()

	return nil
end
function t.SetSeed(p1, p2) --[[ SetSeed | Line: 250 ]]
	assert(if p2 == nil then false elseif type(p2) == "number" then true else false, "Bad seed")
	rawset(p1, "Seed", p2)
	p1:_UpdateOctaves()

	return nil
end
function t.Get(p1, p2) --[[ Get | Line: 258 ]]
	local v1 = p1.translateVector(p2)

	return p1:_Compile(v1, p1:_Rand(v1))
end
function t.Clone(p1) --[[ Clone | Line: 264 | Upvalues: t (copy) ]]
	local v1 = t.new()

	assert(if getmetatable(v1) == t then true else false)

	return t:_CopyConfiguration(v1, p1)
end
function t.Set(p1, p2, p3, p4, p5, p6, p7) --[[ Set | Line: 271 ]]
	rawset(p1, "Seed", if p2 then p2 else p1.Seed)
	rawset(p1, "Amplitude", if p4 then p4 else p1.Amplitude)
	rawset(p1, "Frequency", if p3 then p3 else p1.Frequency)
	rawset(p1, "Persistence", if p6 then p6 else p1.Persistence)
	rawset(p1, "Lacunarity", if p5 then p5 else p1.Lacunarity)

	if p7 then
		rawset(p1, "Points", (p1:_TranslatePoints(p7)))
		p1:_SetSeparationLimit()
	end

	p1:_UpdateOctaves()

	return nil
end
function t._new() --[[ _new | Line: 323 | Upvalues: t (copy) ]]
	local t2 = {
		Seed = 1,
		Frequency = 1,
		Amplitude = 1,
		Lacunarity = 1,
		Persistence = 1,
		SeparationLimit = 0,
		Octaves = {},
		Points = {}
	}

	setmetatable(t2, t)

	return t2
end
function t.new(p1, p2, p3, p4, p5, p6) --[[ new | Line: 341 | Upvalues: t (copy) ]]
	local v1 = t._new()

	assert(if getmetatable(v1) == t then true else false)
	v1:Set(p1, p2, p3, p4, p5, p6)

	return v1
end

return t