-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = ipairs
local v2 = Color3.new()

local function RobloxLerp(p1, p2) --[[ RobloxLerp | Line: 5 ]]
	return function(p12) --[[ Line: 6 | Upvalues: p1 (copy), p2 (copy) ]]
		return p1:Lerp(p2, p12)
	end
end

local function Lerp(p1, p2, p3) --[[ Lerp | Line: 11 ]]
	return p1 + p3 * (p2 - p1)
end

local function SortByTime(p1, p2) --[[ SortByTime | Line: 15 ]]
	return p1.Time < p2.Time
end

local function Color3Lerp(p1, p2) --[[ Color3Lerp | Line: 19 | Upvalues: v2 (copy) ]]
	local R = p1.R
	local G = p1.G
	local B = p1.B
	local v1 = R < 0.0404482362771076 and R / 12.92 or 0.87941546140213 * (R + 0.055) ^ 2.4
	local v22, v3

	if G < 0.0404482362771076 then
		v22 = G / 12.92

		if v22 then
			v3 = v1
		else
			v22 = 0.87941546140213 * (G + 0.055) ^ 2.4
			v3 = v1
		end
	else
		v22 = 0.87941546140213 * (G + 0.055) ^ 2.4
		v3 = v1
	end

	local v4, v5

	if B < 0.0404482362771076 then
		v4 = B / 12.92

		if v4 then
			v5 = v22
		else
			v4 = 0.87941546140213 * (B + 0.055) ^ 2.4
			v5 = v22
		end
	else
		v4 = 0.87941546140213 * (B + 0.055) ^ 2.4
		v5 = v22
	end

	local v6 = 0.2125862307855956 * v3 + 0.7151703037034108 * v5 + 0.0722004986433362 * v4
	local v7 = 3.6590806972265884 * v3 + 11.442689580057424 * v5 + 4.114991502426484 * v4
	local v8, v9

	if v6 > 0.008856451679035631 then
		v8 = 116 * v6 ^ 0.3333333333333333 - 16

		if v8 then
			v9 = v4
		else
			v9 = v4
			v8 = 903.296296296296 * v6
		end
	else
		v9 = v4
		v8 = 903.296296296296 * v6
	end

	local v10, v11, v12

	v10 = v8

	if v7 > 1e-15 then
		v11 = v8 * (9 * v6 / v7 - 0.46832)
		v12 = v8 * (0.9257063972951867 * v3 - 0.8333736323779866 * v5 - 0.09209820666085898 * v9) / v7
	else
		v11 = -0.46832 * v8
		v12 = -0.19783 * v8
	end

	local R2 = p2.R
	local G2 = p2.G
	local B2 = p2.B
	local v13 = R2 < 0.0404482362771076 and R2 / 12.92 or 0.87941546140213 * (R2 + 0.055) ^ 2.4
	local v14, v15

	if G2 < 0.0404482362771076 then
		v14 = G2 / 12.92

		if v14 then
			v15 = v13
		else
			v14 = 0.87941546140213 * (G2 + 0.055) ^ 2.4
			v15 = v13
		end
	else
		v14 = 0.87941546140213 * (G2 + 0.055) ^ 2.4
		v15 = v13
	end

	local v16, v17

	if B2 < 0.0404482362771076 then
		v16 = B2 / 12.92

		if v16 then
			v17 = v14
		else
			v16 = 0.87941546140213 * (B2 + 0.055) ^ 2.4
			v17 = v14
		end
	else
		v16 = 0.87941546140213 * (B2 + 0.055) ^ 2.4
		v17 = v14
	end

	local v18 = 0.2125862307855956 * v15 + 0.7151703037034108 * v17 + 0.0722004986433362 * v16
	local v19 = 3.6590806972265884 * v15 + 11.442689580057424 * v17 + 4.114991502426484 * v16
	local v20, v21

	if v18 > 0.008856451679035631 then
		v20 = 116 * v18 ^ 0.3333333333333333 - 16

		if v20 then
			v21 = v16
		else
			v21 = v16
			v20 = 903.296296296296 * v18
		end
	else
		v21 = v16
		v20 = 903.296296296296 * v18
	end

	local v222, v23, v24

	v222 = v20

	if v19 > 1e-15 then
		v23 = v20 * (0.9257063972951867 * v15 - 0.8333736323779866 * v17 - 0.09209820666085898 * v21) / v19
		v24 = v20 * (9 * v18 / v19 - 0.46832)
	else
		v23 = -0.19783 * v20
		v24 = -0.46832 * v20
	end

	return function(p1) --[[ Line: 54 | Upvalues: v10 (ref), v222 (ref), v2 (ref), v12 (ref), v23 (ref), v11 (ref), v24 (ref) ]]
		local v1 = (1 - p1) * v10 + p1 * v222

		if v1 < 0.0197955 then
			return v2
		end

		local v22 = ((1 - p1) * v12 + p1 * v23) / v1 + 0.19783
		local v3 = ((1 - p1) * v11 + p1 * v24) / v1 + 0.46832
		local v4 = (v1 + 16) / 116
		local v5 = v4 > 0.20689655172413793 and v4 * v4 * v4 or 0.12841854934601665 * v4 - 0.01771290335807126
		local v6 = v5 * v22 / v3
		local v7 = v5 * ((3 - 0.75 * v22) / v3 - 5)
		local sum = 7.2914074 * v6 - 1.537208 * v5 - 0.4986286 * v7
		local sum2 = -2.180094 * v6 + 1.8757561 * v5 + 0.0415175 * v7
		local sum3 = 0.1253477 * v6 - 0.2040211 * v5 + 1.0569959 * v7

		if sum < 0 and (sum < sum2 and sum < sum3) then
			sum = 0
			sum2 = sum2 - sum
			sum3 = sum3 - sum
		elseif sum2 < 0 and sum2 < sum3 then
			sum = sum - sum2
			sum2 = 0
			sum3 = sum3 - sum2
		elseif sum3 < 0 then
			sum = sum - sum3
			sum2 = sum2 - sum3
			sum3 = 0
		end

		local v8 = sum < 0.0031306684425 and 12.92 * sum or 1.055 * sum ^ 0.4166666666666667 - 0.055
		local v9, v102

		if sum2 < 0.0031306684425 then
			v9 = 12.92 * sum2

			if v9 then
				v102 = v8
			else
				v9 = 1.055 * sum2 ^ 0.4166666666666667 - 0.055
				v102 = v8
			end
		else
			v9 = 1.055 * sum2 ^ 0.4166666666666667 - 0.055
			v102 = v8
		end

		local v112, v122

		if sum3 < 0.0031306684425 then
			v112 = 12.92 * sum3

			if v112 then
				v122 = v9
			else
				v112 = 1.055 * sum3 ^ 0.4166666666666667 - 0.055
				v122 = v9
			end
		else
			v112 = 1.055 * sum3 ^ 0.4166666666666667 - 0.055
			v122 = v9
		end

		local v13 = if v102 > 1 then 1 elseif v102 < 0 then 0 else v102
		local v14, v15

		if v122 > 1 then
			v14 = 1
			v15 = v112
		elseif v122 < 0 then
			v14 = 0
			v15 = v112
		else
			v14 = v122
			v15 = v112
		end

		local v16, v17

		if v15 > 1 then
			v16 = 1
			v17 = v13
		elseif v15 < 0 then
			v16 = 0
			v17 = v13
		else
			v16 = v15
			v17 = v13
		end

		return Color3.new(v17, v14, v16)
	end
end

local t = {
	boolean = function(p1, p2) --[[ boolean | Line: 93 ]]
		return function(p12) --[[ Line: 94 | Upvalues: p1 (copy), p2 (copy) ]]
			if p12 < 0.5 then
				return p1
			end

			return p2
		end
	end,
	number = function(p1, p2) --[[ number | Line: 103 ]]
		local v1 = p2 - p1

		return function(p12) --[[ Line: 105 | Upvalues: p1 (copy), v1 (copy) ]]
			return p1 + v1 * p12
		end
	end,
	string = function(p1, p2) --[[ string | Line: 110 ]]
		local v1 = false
		local v2, v3, v4, v5 = string.match(p1, "^([+-]?)(%d*):[+-]?(%d*):[+-]?(%d*)$")
		local v6, v7, v8, v9 = string.match(p2, "^([+-]?)(%d*):[+-]?(%d*):[+-]?(%d*)$")
		local v10, v11

		if v2 and v6 then
			v10 = 3600 * (tonumber(v3) or 0) + 60 * (tonumber(v4) or 0) + (tonumber(v5) or 0)

			local v12 = 3600 * (tonumber(v7) or 0) + 60 * (tonumber(v8) or 0) + (tonumber(v9) or 0)

			if v2 == "-" then
				v10 = -v10
			end

			v11 = (43200 + (if v6 == "-" or not v12 then -v12 else v12) - v10) % 86400 - 43200
		else
			v1 = true
			v10 = nil
			v11 = nil
		end

		if v1 then
			local v15 = #p2

			return function(p1) --[[ Line: 132 | Upvalues: v15 (copy), p2 (copy) ]]
				local v1 = 1 + v15 * p1

				return string.sub(p2, 1, if v1 < v15 then v1 else v15)
			end
		end

		return function(p1) --[[ Line: 137 | Upvalues: v10 (ref), v11 (ref) ]]
			local v1 = (v10 + v11 * p1) % 86400
			local v2 = math.abs(v1)

			return string.format(if v1 < 0 then "-%.2u:%.2u:%.2u" else "%.2u:%.2u:%.2u", (v2 - v2 % 3600) / 3600, (v2 % 3600 - v2 % 60) / 60, v2 % 60)
		end
	end,
	CFrame = RobloxLerp,
	Color3 = Color3Lerp,
	NumberRange = function(p1, p2) --[[ NumberRange | Line: 152 ]]
		local Min = p1.Min
		local Max = p1.Max
		local v1 = p2.Min - Min
		local v2 = p2.Max - Max

		return function(p1) --[[ Line: 156 | Upvalues: Min (copy), v1 (copy), Max (copy), v2 (copy) ]]
			return NumberRange.new(Min + p1 * v1, Max + p1 * v2)
		end
	end,
	NumberSequenceKeypoint = function(p1, p2) --[[ NumberSequenceKeypoint | Line: 161 ]]
		local Time = p1.Time
		local v1 = p1.Value
		local Envelope = p1.Envelope
		local v2 = p2.Time - Time
		local v3 = p2.Value - v1
		local v4 = p2.Envelope - Envelope

		return function(p1) --[[ Line: 165 | Upvalues: Time (copy), v2 (copy), v1 (copy), v3 (copy), Envelope (copy), v4 (copy) ]]
			return NumberSequenceKeypoint.new(Time + p1 * v2, v1 + p1 * v3, Envelope + p1 * v4)
		end
	end,
	PhysicalProperties = function(p1, p2) --[[ PhysicalProperties | Line: 170 ]]
		local Density = p1.Density
		local Elasticity = p1.Elasticity
		local ElasticityWeight = p1.ElasticityWeight
		local Friction = p1.Friction
		local FrictionWeight = p1.FrictionWeight
		local v1 = p2.Density - Density
		local v2 = p2.Elasticity - Elasticity
		local v3 = p2.ElasticityWeight - ElasticityWeight
		local v4 = p2.Friction - Friction
		local v5 = p2.FrictionWeight - FrictionWeight

		return function(p1) --[[ Line: 176 | Upvalues: Density (copy), v1 (copy), Elasticity (copy), v2 (copy), ElasticityWeight (copy), v3 (copy), Friction (copy), v4 (copy), FrictionWeight (copy), v5 (copy) ]]
			return PhysicalProperties.new(Density + p1 * v1, Elasticity + p1 * v2, ElasticityWeight + p1 * v3, Friction + p1 * v4, FrictionWeight + p1 * v5)
		end
	end,
	Ray = function(p1, p2) --[[ Ray | Line: 187 ]]
		local Origin = p1.Origin
		local Direction = p1.Direction
		local Origin2 = p2.Origin
		local Direction2 = p2.Direction
		local X = Origin.X
		local Y = Origin.Y
		local Z = Origin.Z
		local X2 = Direction.X
		local Y2 = Direction.Y
		local Z2 = Direction.Z
		local v1 = Origin2.X - X
		local v2 = Origin2.Y - Y
		local v3 = Origin2.Z - Z
		local v4 = Direction2.X - X2
		local v5 = Direction2.Y - Y2
		local v6 = Direction2.Z - Z2

		return function(p1) --[[ Line: 192 | Upvalues: X (copy), v1 (copy), Y (copy), v2 (copy), Z (copy), v3 (copy), X2 (copy), v4 (copy), Y2 (copy), v5 (copy), Z2 (copy), v6 (copy) ]]
			return Ray.new(Vector3.new(X + p1 * v1, Y + p1 * v2, Z + p1 * v3), (Vector3.new(X2 + p1 * v4, Y2 + p1 * v5, Z2 + p1 * v6)))
		end
	end,
	UDim = function(p1, p2) --[[ UDim | Line: 200 ]]
		local Scale = p1.Scale
		local Offset = p1.Offset
		local v1 = p2.Scale - Scale
		local v2 = p2.Offset - Offset

		return function(p1) --[[ Line: 204 | Upvalues: Scale (copy), v1 (copy), Offset (copy), v2 (copy) ]]
			return UDim.new(Scale + p1 * v1, Offset + p1 * v2)
		end
	end,
	UDim2 = RobloxLerp,
	Vector2 = RobloxLerp,
	Vector3 = RobloxLerp,
	Rect = function(p1, p2) --[[ Rect | Line: 212 ]]
		return function(p12) --[[ Line: 213 | Upvalues: p1 (copy), p2 (copy) ]]
			return Rect.new(p1.Min.X + p12 * (p2.Min.X - p1.Min.X), p1.Min.Y + p12 * (p2.Min.Y - p1.Min.Y), p1.Max.X + p12 * (p2.Max.X - p1.Max.X), p1.Max.Y + p12 * (p2.Max.Y - p1.Max.Y))
		end
	end,
	Region3 = function(p1, p2) --[[ Region3 | Line: 223 ]]
		return function(p12) --[[ Line: 224 | Upvalues: p1 (copy), p2 (copy) ]]
			local v1 = p1.CFrame * (-p1.Size / 2)
			local v2 = v1 + p12 * (p2.CFrame * (-p2.Size / 2) - v1)
			local v3 = p1.CFrame * (p1.Size / 2)
			local v4 = v3 + p12 * (p2.CFrame * (p2.Size / 2) - v3)
			local X = v2.X
			local X2 = v4.X
			local Y = v2.Y
			local Y2 = v4.Y
			local Z = v2.Z
			local Z2 = v4.Z

			return Region3.new(Vector3.new(if X < X2 then X else X2, if Y < Y2 then Y else Y2, if Z < Z2 then Z else Z2), (Vector3.new(if X2 < X then X else X2, if Y2 < Y then Y else Y2, if Z2 < Z then Z else Z2)))
		end
	end,
	NumberSequence = function(p1, p2) --[[ NumberSequence | Line: 250 | Upvalues: v1 (copy), SortByTime (copy) ]]
		return function(p12) --[[ Line: 251 | Upvalues: v1 (ref), p1 (copy), p2 (copy), SortByTime (ref) ]]
			local count = 0
			local t = {}
			local t2 = {}

			for v3, v4 in v1(p1.Keypoints) do
				local v12, v2
				local v5 = nil
				local v6 = nil

				for v7, v8 in v1(p2.Keypoints) do
					if v8.Time == v4.Time then
						v5 = v8
						v6 = v8

						break
					end

					if v8.Time < v4.Time and (v6 == nil or v8.Time > v6.Time) then
						v6 = v8

						continue
					end

					if v8.Time > v4.Time and (v5 == nil or v8.Time < v5.Time) then
						v5 = v8
					end
				end

				if v5 == v6 then
					v12 = v5.Value
					v2 = v5.Envelope
				else
					local v9 = (v4.Time - v6.Time) / (v5.Time - v6.Time)

					v12 = (v5.Value - v6.Value) * v9 + v6.Value
					v2 = (v5.Envelope - v6.Envelope) * v9 + v6.Envelope
				end

				count = count + 1
				t[count] = NumberSequenceKeypoint.new(v4.Time, (v12 - v4.Value) * p12 + v4.Value, (v2 - v4.Envelope) * p12 + v4.Envelope)
				t2[v4.Time] = true
			end

			for v122, v13 in v1(p2.Keypoints) do
				local v10, v11

				if not t2[v13.Time] then
					local v14 = nil
					local v15 = nil

					for v16, v17 in v1(p1.Keypoints) do
						if v17.Time == v13.Time then
							v14 = v17
							v15 = v17

							break
						end

						if v17.Time < v13.Time and (v15 == nil or v17.Time > v15.Time) then
							v15 = v17

							continue
						end

						if v17.Time > v13.Time and (v14 == nil or v17.Time < v14.Time) then
							v14 = v17
						end
					end

					if v14 == v15 then
						v10 = v14.Value
						v11 = v14.Envelope
					else
						local v18 = (v13.Time - v15.Time) / (v14.Time - v15.Time)

						v10 = (v14.Value - v15.Value) * v18 + v15.Value
						v11 = (v14.Envelope - v15.Envelope) * v18 + v15.Envelope
					end

					count = count + 1
					t[count] = NumberSequenceKeypoint.new(v13.Time, (v13.Value - v10) * p12 + v10, (v13.Envelope - v11) * p12 + v11)
				end
			end

			table.sort(t, SortByTime)

			return NumberSequence.new(t)
		end
	end,
	ColorSequence = function(p1, p2) --[[ ColorSequence | Line: 326 | Upvalues: v1 (copy), Color3Lerp (copy), SortByTime (copy) ]]
		return function(p12) --[[ Line: 327 | Upvalues: v1 (ref), p1 (copy), p2 (copy), Color3Lerp (ref), SortByTime (ref) ]]
			local count = 0
			local t = {}
			local t2 = {}

			for v2, v3 in v1(p1.Keypoints) do
				local v12
				local v4 = nil
				local v5 = nil

				for v6, v7 in v1(p2.Keypoints) do
					if v7.Time == v3.Time then
						v4 = v7
						v5 = v7

						break
					end

					if v7.Time < v3.Time and (v5 == nil or v7.Time > v5.Time) then
						v5 = v7

						continue
					end

					if v7.Time > v3.Time and (v4 == nil or v7.Time < v4.Time) then
						v4 = v7
					end
				end

				v12 = if v4 == v5 then v4.Value else Color3Lerp(v5.Value, v4.Value)((v3.Time - v5.Time) / (v4.Time - v5.Time))
				count = count + 1
				t[count] = ColorSequenceKeypoint.new(v3.Time, Color3Lerp(v3.Value, v12)(p12))
				t2[v3.Time] = true
			end

			for v10, v11 in v1(p2.Keypoints) do
				local v9

				if not t2[v11.Time] then
					local v122 = nil
					local v13 = nil

					for v14, v15 in v1(p1.Keypoints) do
						if v15.Time == v11.Time then
							v122 = v15
							v13 = v15

							break
						end

						if v15.Time < v11.Time and (v13 == nil or v15.Time > v13.Time) then
							v13 = v15

							continue
						end

						if v15.Time > v11.Time and (v122 == nil or v15.Time < v122.Time) then
							v122 = v15
						end
					end

					v9 = if v122 == v13 then v122.Value else Color3Lerp(v13.Value, v122.Value)((v11.Time - v13.Time) / (v122.Time - v13.Time))
					count = count + 1
					t[count] = ColorSequenceKeypoint.new(v11.Time, Color3Lerp(v11.Value, v9)(p12))
				end
			end

			table.sort(t, SortByTime)

			return ColorSequence.new(t)
		end
	end
}

return setmetatable(t, {
	__index = function(p1, p2) --[[ __index | Line: 394 ]]
		error("No lerp function is defined for type " .. tostring(p2) .. ".", 4)
	end,
	__newindex = function(p1, p2) --[[ __newindex | Line: 398 ]]
		error("No lerp function is defined for type " .. tostring(p2) .. ".", 4)
	end
})