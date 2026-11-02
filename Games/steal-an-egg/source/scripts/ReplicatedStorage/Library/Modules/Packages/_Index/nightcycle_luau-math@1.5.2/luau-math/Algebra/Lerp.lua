-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.Types)

local t = {}

function lerp(p1, p2, p3) --[[ lerp | Line: 5 | Upvalues: t (ref) ]]
	assert(if typeof(p1) == typeof(p2) then true else false, "Type mismatch")
	assert(if typeof(p3) == "number" then true else false, "Bad alpha")

	return (t[typeof(p1)] or (function() --[[ Line: 10 | Upvalues: p1 (copy), p2 (copy), p3 (copy) ]]
		return p1:Lerp(p2, p3)
	end))(p1, p2, p3)
end
function sequence(p1, p2, p3) --[[ sequence | Line: 17 ]]
	local function eval(p1, p2) --[[ eval | Line: 25 ]]
		local Keypoints = p1.Keypoints

		if p2 == 0 then
			return Keypoints[1].Value
		end

		if p2 == 1 then
			return Keypoints[#p1.Keypoints].Value
		end

		for i = 1, #Keypoints - 1 do
			local v2 = Keypoints[i]
			local v3 = Keypoints[i + 1]

			if v2.Time <= p2 and p2 < v3.Time then
				local v4 = (p2 - v2.Time) / (v3.Time - v2.Time)

				if typeof(p1) == "ColorSequence" then
					return Color3.new((v3.Value.R - v2.Value.R) * v4 + v2.Value.R, (v3.Value.G - v2.Value.G) * v4 + v2.Value.G, (v3.Value.B - v2.Value.B) * v4 + v2.Value.B)
				end

				if typeof(p1) == "NumberSequence" then
					return (v3.Value - v2.Value) * v4 + v2.Value
				end

				break
			end
		end

		return nil
	end

	local t = {}
	local tbl = {}

	for i, v in ipairs(p1.Keypoints) do
		if typeof(p1) == "NumberSequence" then
			t[v.Time] = { v.Envelope, (eval(p2, v.Time)) }
		end

		tbl[v.Time] = { v.Value, (eval(p2, v.Time)) }
	end

	for i, v in ipairs(p2.Keypoints) do
		if typeof(p1) == "NumberSequence" then
			if t[v.Time] then
				t[v.Time][2] = v.Envelope
			else
				eval(p1, v.Time)
				t[v.Time] = { 0, v.Envelope }
			end
		end

		if tbl[v.Time] then
			tbl[v.Time][2] = v.Value

			continue
		end

		tbl[v.Time] = { eval(p1, v.Time), v.Value }
	end

	local list = {}

	for k, v in pairs(tbl) do
		table.insert(list, k)
	end

	table.sort(list, function(p1, p2) --[[ Line: 85 ]]
		return p1 < p2
	end)

	local t2 = {}

	for i, v in ipairs(list) do
		local v1 = tbl[v]
		local v2 = nil

		if typeof(p1) == "NumberSequence" then
			local v3 = t[v]

			v2 = NumberSequenceKeypoint.new(v, lerp(v1[1], v1[2], p3), lerp(v3[1], v3[2], p3))
		elseif typeof(p1) == "NumberSequence" then
			v2 = NumberSequenceKeypoint.new(v, lerp(v1[1], v1[2], p3))
		elseif typeof(p1) == "ColorSequence" then
			local v6 = v1[1]
			local v7 = v1[2]

			assert(if v6 == nil then false elseif typeof(v6) == "Color3" then true else false)
			assert(if v7 == nil then false elseif typeof(v7) == "Color3" then true else false)

			local v10 = lerp(v6, v7, p3)

			assert(if v10 == nil then false elseif typeof(v10) == "Color3" then true else false)
			v2 = ColorSequenceKeypoint.new(v, v10)
		end

		table.insert(t2, v2)
	end

	if typeof(p1) == "NumberSequence" then
		return NumberSequence.new(t2)
	end

	if typeof(p1) == "ColorSequence" then
		return ColorSequence.new(t2)
	end

	return p1
end
t = {
	number = function(p1, p2, p3) --[[ Line: 123 ]]
		return (p2 - p1) * p3 + p1
	end,
	string = function(p1, p2, p3) --[[ Line: 126 ]]
		local v3 = math.max(string.len(p1), (string.len(p2)))
		local v4 = math.ceil(v3 * p3)

		if v4 == v3 then
			return p2
		end

		local v5 = string.sub(p2, 1, v4)
		local v8 = string.sub(p1, v4, (math.max(v4, (string.len(p1)))))

		if string.len(v8) < string.len(v5) and string.len(v5) < v4 then
			v8 = string.rep(" ", v4 - string.len(v5) - 1) .. v8
		end

		return v5 .. v8
	end,
	boolean = function(p1, p2, p3) --[[ Line: 139 ]]
		if p3 >= 0.5 then
			return p1
		end

		return p2
	end,
	Color3 = function(p1, p2, p3) --[[ Line: 146 ]]
		local function to(p1) --[[ to | Line: 148 ]]
			local v2 = (p1.R * 0.4122214708 + p1.G * 0.5363325363 + p1.B * 0.0514459929) ^ 0.3333333333333333
			local v3 = (p1.R * 0.2119034982 + p1.G * 0.6806995451 + p1.B * 0.1073969566) ^ 0.3333333333333333
			local v4 = (p1.R * 0.0883024619 + p1.G * 0.2817188376 + p1.B * 0.6299787005) ^ 0.3333333333333333

			return Vector3.new(v2 * 0.2104542553 + v3 * 0.793617785 - v4 * 0.0040720468, v2 * 1.9779984951 - v3 * 2.428592205 + v4 * 0.4505937099, v2 * 0.0259040371 + v3 * 0.7827717662 - v4 * 0.808675766)
		end

		local function from(p1, p2) --[[ from | Line: 166 ]]
			local v2 = (p1.X + p1.Y * 0.3963377774 + p1.Z * 0.2158037573) ^ 3
			local v3 = (p1.X - p1.Y * 0.1055613458 - p1.Z * 0.0638541728) ^ 3
			local v4 = (p1.X - p1.Y * 0.0894841775 - p1.Z * 1.291485548) ^ 3
			local v5 = v2 * 4.0767416621 - v3 * 3.3077115913 + v4 * 0.2309699292
			local v6 = v2 * -1.2684380046 + v3 * 2.6097574011 - v4 * 0.3413193965
			local v7 = v2 * -0.0041960863 - v3 * 0.7034186147 + v4 * 1.707614701

			if not p2 then
				local v8 = math.clamp(v5, 0, 1)
				local v9 = math.clamp(v6, 0, 1)

				v5, v6, v7 = v8, v9, math.clamp(v7, 0, 1)
			end

			return Color3.new(v5, v6, v7)
		end

		return from(to(p1):Lerp(to(p2), p3))
	end,
	BrickColor = function(p1, p2, p3) --[[ Line: 191 ]]
		local v1 = Color3.new(p1.r, p1.g, p1.b)

		return BrickColor.new(v1:Lerp(Color3.new(p2.r, p2.g, p2.b), p3))
	end,
	ColorSequence = function(p1, p2, p3) --[[ Line: 196 ]]
		local v1 = sequence(p1, p2, p3)

		assert(typeof(v1) == "ColorSequence", "Bad ColorSequence")

		return v1
	end,
	NumberSequence = function(p1, p2, p3) --[[ Line: 201 ]]
		local v1 = sequence(p1, p2, p3)

		assert(typeof(v1) == "NumberSequence", "Bad NumberSequence")

		return v1
	end,
	ColorSequenceKeypoint = function(p1, p2, p3) --[[ Line: 206 ]]
		local v1 = lerp(p1.Time, p2.Time, p3)

		return ColorSequenceKeypoint.new(v1, (lerp(p1.Value, p2.Value, p3)))
	end,
	NumberSequenceKeypoint = function(p1, p2, p3) --[[ Line: 216 ]]
		local v1 = lerp(p1.Time, p2.Time, p3)

		return NumberSequenceKeypoint.new(v1, (lerp(p1.Value, p2.Value, p3)))
	end,
	DateTime = function(p1, p2, p3) --[[ Line: 225 ]]
		return DateTime.fromUnixTimestampMillis(lerp(p1.UnixTimestampMillis, p2.UnixTimestampMillis, p3))
	end,
	EnumItem = function(p1, p2, p3) --[[ Line: 230 ]]
		assert(if p1.EnumType == p2.EnumType then true else false, "EnumType mismatch")

		local v2 = p1.EnumType:GetEnumItems()

		return v2[math.clamp(math.round((lerp(p1.Value, p2.Value, p3))), 0, #v2 - 1) + 1]
	end,
	NumberRange = function(p1, p2, p3) --[[ Line: 237 ]]
		local v1 = lerp(p1.Min, p2.Min, p3)

		return NumberRange.new(v1, (lerp(p1.Max, p2.Max, p3)))
	end,
	PathWaypoint = function(p1, p2, p3) --[[ Line: 242 ]]
		local v1 = lerp(p1.Position, p2.Position, p3)

		return PathWaypoint.new(v1, (lerp(p1.Action, p2.Action, p3)))
	end,
	PhysicalProperties = function(p1, p2, p3) --[[ Line: 247 ]]
		local v1 = lerp(p1.Density, p2.Density, p3)
		local v2 = lerp(p1.Friction, p2.Friction, p3)
		local v3 = lerp(p1.Elasticity, p2.Elasticity, p3)
		local v4 = lerp(p1.FrictionWeight, p2.FrictionWeight, p3)

		return PhysicalProperties.new(v1, v2, v3, v4, (lerp(p1.ElasticityWeight, p2.ElasticityWeight, p3)))
	end,
	Ray = function(p1, p2, p3) --[[ Line: 260 ]]
		local v1 = lerp(p1.Origin, p2.Origin, p3)

		return Ray.new(v1, (lerp(p1.Direction, p2.Direction, p3)))
	end,
	Rect = function(p1, p2, p3) --[[ Line: 266 ]]
		local v1 = lerp(p1.Min, p2.Min, p3)

		return Rect.new(v1, (lerp(p1.Max, p2.Max, p3)))
	end,
	Region3 = function(p1, p2, p3) --[[ Line: 272 ]]
		local Position = (p1.CFrame * CFrame.new(-p1.Size * 0.5 / 2)).Position
		local Position2 = (p2.CFrame * CFrame.new(-p2.Size * 0.5 / 2)).Position
		local Position3 = (p1.CFrame * CFrame.new(p1.Size * 0.5 / 2)).Position
		local Position4 = (p2.CFrame * CFrame.new(p2.Size * 0.5 / 2)).Position
		local v1 = lerp(Position, Position2, p3)

		return Region3.new(v1, (lerp(Position3, Position4, p3)))
	end,
	Region3int16 = function(p1, p2, p3) --[[ Line: 284 ]]
		local v1 = lerp(p1.Min, p2.Min, p3)

		return Region3.new(v1, (lerp(p1.Max, p2.Max, p3)))
	end,
	UDim = function(p1, p2, p3) --[[ Line: 290 ]]
		local v1 = lerp(p1.Scale, p2.Scale, p3)

		return UDim.new(v1, (lerp(p1.Offset, p2.Offset, p3)))
	end,
	UDim2 = function(p1, p2, p3) --[[ Line: 295 ]]
		local v1 = lerp(p1.X, p2.X, p3)

		return UDim2.new(v1, (lerp(p1.Y, p2.Y, p3)))
	end
}

return lerp