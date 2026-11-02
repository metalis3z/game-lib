--credit to leon games studio
local t = {}

t.__index = t
function B(p1, p2, p3) --[[ B | Line: 20 ]]
	local function v1(p1) --[[ fact | Line: 23 | Upvalues: v1 (copy) ]]
		if p1 == 0 then
			return 1
		end

		return p1 * v1(p1 - 1)
	end

	local v2 = if p1 == 0 then 1 else p1 * v1(p1 - 1)
	local v3 = if p2 == 0 then 1 else p2 * v1(p2 - 1)
	local v4 = p1 - p2

	return v2 / (v3 * (if v4 == 0 then 1 else v4 * v1(v4 - 1))) * p3 ^ p2 * (1 - p3) ^ (p1 - p2)
end
function t.new(...) --[[ new | Line: 38 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.Points = {}
	v2.LengthIterations = 1000
	v2.LengthIndeces = {}
	v2.Length = 0
	v2._connections = {}

	for k, v in pairs({ ... }) do
		if typeof(v) == "Vector3" or typeof(v) == "Instance" and v:IsA("BasePart") then
			v2:AddBezierPoint(v)

			continue
		end

		error("The Bezier.new() constructor only takes in Vector3s and BaseParts as inputs!")
	end

	return v2
end
function t.AddBezierPoint(p1, p2, p3) --[[ AddBezierPoint | Line: 70 ]]
	if (not p2 or (typeof(p2) ~= "Instance" or not p2:IsA("BasePart"))) and typeof(p2) ~= "Vector3" then
		error("Bezier:AddBezierPoint() only accepts a Vector3 or BasePart as the first argument!")
	end

	local t = {}

	t.Type = if typeof(p2) == "Vector3" then "StaicPoint" else "BasePartPoint"
	t.Point = p2

	if t.Type == "BasePartPoint" then
		local v2 = p2.Changed:Connect(function(p12) --[[ Line: 84 | Upvalues: p1 (copy) ]]
			if p12 ~= "Position" then
				return
			end

			p1:UpdateLength()
		end)
		local v3 = p2.AncestryChanged:Connect(function(p12, p2) --[[ Line: 91 | Upvalues: p1 (copy), t (copy), v2 (ref) ]]
			if p2 ~= nil then
				return
			end

			local v1 = table.find(p1.Points, t)

			if v1 then
				table.remove(p1.Points, v1)
			end

			v2:Disconnect()
			v2:Disconnect()
		end)

		if not p1._connections[p2] then
			p1._connections[p2] = {}
		end

		local v5 = v2

		table.insert(p1._connections[p2], v5)
		table.insert(p1._connections[p2], v3)
	end

	if p3 and type(p3) == "number" then
		table.insert(p1.Points, p3, t)
	elseif p3 then
		if type(p3) ~= "number" then
			error("Bezier:AddBezierPoint() only accepts an integer as the second argument!")
		end
	else
		table.insert(p1.Points, t)
	end

	p1:UpdateLength()
end
function t.ChangeBezierPoint(p1, p2, p3) --[[ ChangeBezierPoint | Line: 137 ]]
	if type(p2) ~= "number" then
		error("Bezier:ChangeBezierPoint() only accepts a number index as the first argument!")
	end

	if (not p3 or (typeof(p3) ~= "Instance" or not p3:IsA("BasePart"))) and typeof(p3) ~= "Vector3" then
		error("Bezier:ChangeBezierPoint() only accepts a Vector3 or BasePart as the second argument!")
	end

	local v1 = p1.Points[p2]

	if not v1 then
		error("Did not find BezierPoint at index " .. tostring(p2))
	end

	v1.Type = if typeof(p3) == "Vector3" then "StaicPoint" else "BasePartPoint"
	v1.Point = p3
	p1:UpdateLength()
end
function t.GetAllPoints(p1) --[[ GetAllPoints | Line: 171 ]]
	local t = {}

	for i = 1, #p1.Points do
		table.insert(t, p1:GetPoint(i))
	end

	return t
end
function t.GetPoint(p1, p2) --[[ GetPoint | Line: 189 ]]
	local Points = p1.Points

	if not Points[p2] then
		error("Did not find a BezierPoint at index " .. tostring(p2) .. "!")
	end

	return typeof(Points[p2].Point) == "Vector3" and Points[p2].Point or Points[p2].Point.Position
end
function t.RemoveBezierPoint(p1, p2) --[[ RemoveBezierPoint | Line: 202 ]]
	if not p1.Points[p2] then
		return
	end

	local v1 = table.remove(p1.Points, p2)

	if typeof(v1.Point) == "Instance" and v1.Point:IsA("BasePart") then
		for k, v in pairs(p1._connections[v1.Point]) do
			if v.Connected then
				v:Disconnect()
			end
		end

		p1._connections[v1.Point] = nil
	end

	p1:UpdateLength()
end
function t.UpdateLength(p1) --[[ UpdateLength | Line: 225 ]]
	local v1 = p1:GetAllPoints()
	local LengthIterations = p1.LengthIterations

	if #v1 < 2 then
		return 0, {
			{ 0, 0, 0 },
			{ 0, 0, 0 }
		}
	end

	local sum = 0
	local t = {}

	for i = 1, LengthIterations do
		local v2 = p1:CalculateDerivativeAt((i - 1) / (LengthIterations - 1))

		sum = sum + v2.Magnitude * (1 / LengthIterations)
		table.insert(t, { (i - 1) / (LengthIterations - 1), sum, v2 })
	end

	p1.Length = sum
	p1.LengthIndeces = t
end
function t.CalculatePositionAt(p1, p2) --[[ CalculatePositionAt | Line: 251 ]]
	if type(p2) ~= "number" then
		error("Bezier:CalculatePositionAt() only accepts a number, got " .. tostring(p2) .. "!")
	end

	if not (#p1.Points > 0) then
		error("Bezier:CalculatePositionAt() only works if there is at least 1 BezierPoint!")
	end

	local v1 = p1:GetAllPoints()
	local v2 = #v1
	local sum = Vector3.new()

	for i = 1, v2 do
		sum = sum + B(v2 - 1, i - 1, p2) * v1[i]
	end

	return sum
end
function t.CalculatePositionRelativeToLength(p1, p2) --[[ CalculatePositionRelativeToLength | Line: 291 ]]
	if type(p2) ~= "number" then
		error("Bezier:CalculatePositionRelativeToLength() only accepts a number, got " .. tostring(p2) .. "!")
	end

	if not (#p1.Points > 0) then
		error("Bezier:CalculatePositionRelativeToLength() only works if there is at least 1 BezierPoint!")
	end

	local LengthIndeces = p1.LengthIndeces
	local LengthIterations = p1.LengthIterations

	if not (#p1:GetAllPoints() > 1) then
		return p1:CalculatePositionAt(0)
	end

	local v1 = p1.Length * p2
	local v2 = nil
	local v3 = nil

	for i, v in ipairs(LengthIndeces) do
		if v1 - v[2] <= 0 or i == #LengthIndeces then
			v2 = i
			v3 = v

			break
		end
	end

	local v4, v5

	if LengthIndeces[v2 - 1] then
		local v6 = p1:CalculatePositionAt(LengthIndeces[v2 - 1][1])

		v4, v5 = p1:CalculatePositionAt(v3[1]), v6
	else
		local v8 = p1:CalculatePositionAt(v3[1])

		v4, v5 = p1:CalculatePositionAt(LengthIndeces[v2 + 1][1]), v8
	end

	return v5 + (v4 - v5) * (1 - (v3[2] - v1) / (v4 - v5).Magnitude)
end
function t.CalculateDerivativeAt(p1, p2) --[[ CalculateDerivativeAt | Line: 357 ]]
	if type(p2) ~= "number" then
		error("Bezier:CalculateDerivativeAt() only accepts a number, got " .. tostring(p2) .. "!")
	end

	if not (#p1.Points > 1) then
		error("Bezier:CalculateDerivativeAt() only works if there are at least 2 BezierPoints!")
	end

	local v1 = p1:GetAllPoints()
	local v2 = #v1
	local sum = Vector3.new()

	for i = 1, v2 - 1 do
		sum = sum + B(v2 - 2, i - 1, p2) * ((v2 - 1) * (v1[i + 1] - v1[i]))
	end

	return sum
end
function t.CalculateDerivativeRelativeToLength(p1, p2) --[[ CalculateDerivativeRelativeToLength | Line: 400 ]]
	if type(p2) ~= "number" then
		error("Bezier:CalculateDerivativeRelativeToLength() only accepts a number, got " .. tostring(p2) .. "!")
	end

	if not (#p1.Points > 1) then
		error("Bezier:CalculateDerivativeRelativeToLength() only works if there are at least 2 BezierPoints!")
	end

	local LengthIndeces = p1.LengthIndeces
	local LengthIterations = p1.LengthIterations

	p1:GetAllPoints()

	local v1 = p1.Length * p2
	local v2 = nil
	local v3 = nil

	for i, v in ipairs(LengthIndeces) do
		if v1 - v[2] <= 0 or i == #LengthIndeces then
			v2 = i
			v3 = v

			break
		end
	end

	local v4, v5

	if LengthIndeces[v2 - 1] then
		local v6 = p1:CalculateDerivativeAt(LengthIndeces[v2 - 1][1])

		v4, v5 = p1:CalculateDerivativeAt(v3[1]), v6
	else
		local v8 = p1:CalculateDerivativeAt(v3[1])

		v4, v5 = p1:CalculateDerivativeAt(LengthIndeces[v2 + 1][1]), v8
	end

	return v5 + (v4 - v5) * (1 - (v3[2] - v1) / (v4 - v5).Magnitude)
end
function t.CreateVector3Tween(p1, p2, p3, p4, p5) --[[ CreateVector3Tween | Line: 458 ]]
	if #p1.Points == 0 then
		error("Bezier:CreateVector3Tween() only works if there is at least 1 BezierPoint in the Bezier!")
	end

	if typeof(p2) ~= "Instance" and typeof(p2) ~= "table" then
		error("Bezier:CreateVector3Tween() requires an Instance or a table as the first argument!")
	end

	if typeof(p4) ~= "TweenInfo" then
		error("Bezier:CreateVector3Tween() requires a TweenInfo object as the third argument!")
	end

	local ok, result = pcall(function() --[[ Line: 476 | Upvalues: p3 (copy), p2 (copy) ]]
		for k, v in pairs(p3) do
			if typeof(p2[v]) ~= "Vector3" and typeof(p2[v]) ~= "nil" then
				return false
			end
		end

		return true
	end)

	if ok and result then
		local TweenService = game:GetService("TweenService")
		local v1 = Instance.new("NumberValue")
		local v2 = TweenService:Create(v1, p4, {
			Value = 1
		})
		local v3 = nil

		v2.Changed:Connect(function(p12) --[[ Line: 493 | Upvalues: v2 (copy), v3 (ref), v1 (copy), p3 (copy), p2 (copy), p5 (copy), p1 (copy) ]]
			if p12 ~= "PlaybackState" then
				return
			end

			if v2.PlaybackState == Enum.PlaybackState.Playing then
				v3 = v1.Changed:Connect(function(p12) --[[ Line: 497 | Upvalues: p3 (ref), p2 (ref), p5 (ref), p1 (ref) ]]
					for k, v in pairs(p3) do
						p2[v] = p5 and p1:CalculatePositionRelativeToLength(p12) or p1:CalculatePositionAt(p12)
					end
				end)

				return
			end

			if not v3 then
				return
			end

			v3:Disconnect()
			v3 = nil
		end)

		return v2
	end

	error("Bezier:CreateVector3Tween() requires a matching property table with Vector3 or nil property names for the object as the second argument!")
end
function t.CreateCFrameTween(p1, p2, p3, p4, p5) --[[ CreateCFrameTween | Line: 519 ]]
	if #p1.Points <= 1 then
		error("Bezier:CreateVector3Tween() only works if there are at least 2 BezierPoints in the Bezier!")
	end

	if typeof(p2) ~= "Instance" and typeof(p2) ~= "table" then
		error("Bezier:CreateCFrameTween() requires an Instance or a table as the first argument!")
	end

	if typeof(p4) ~= "TweenInfo" then
		error("Bezier:CreateCFrameTween() requires a TweenInfo object as the third argument!")
	end

	local ok, result = pcall(function() --[[ Line: 537 | Upvalues: p3 (copy), p2 (copy) ]]
		for k, v in pairs(p3) do
			if typeof(p2[v]) ~= "CFrame" and typeof(p2[v]) ~= "nil" then
				return false
			end
		end

		return true
	end)

	if ok and result then
		local TweenService = game:GetService("TweenService")
		local v1 = Instance.new("NumberValue")
		local v2 = TweenService:Create(v1, p4, {
			Value = 1
		})
		local v3 = nil

		v2.Changed:Connect(function(p12) --[[ Line: 554 | Upvalues: v2 (copy), v3 (ref), v1 (copy), p3 (copy), p5 (copy), p1 (copy), p2 (copy) ]]
			if p12 ~= "PlaybackState" then
				return
			end

			if v2.PlaybackState == Enum.PlaybackState.Playing then
				v3 = v1.Changed:Connect(function(p12) --[[ Line: 558 | Upvalues: p3 (ref), p5 (ref), p1 (ref), p2 (ref) ]]
					for k, v in pairs(p3) do
						local v1 = p5 and p1:CalculatePositionRelativeToLength(p12) or p1:CalculatePositionAt(p12)

						p2[v] = CFrame.new(v1, v1 + (p5 and p1:CalculateDerivativeRelativeToLength(p12) or p1:CalculateDerivativeAt(p12)))
					end
				end)

				return
			end

			if not v3 then
				return
			end

			v3:Disconnect()
			v3 = nil
		end)

		return v2
	end

	error("Bezier:CreateCFrameTween() requires a matching property table with CFrame or nil property names for the object as the second argument!")
end

return t