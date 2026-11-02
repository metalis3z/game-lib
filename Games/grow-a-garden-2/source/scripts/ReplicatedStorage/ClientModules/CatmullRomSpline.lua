--credit to quartz games studio
local TweenService = game:GetService("TweenService")
local t = {}
local t2 = {}

function t.new(p1, p2) --[[ new | Line: 22 | Upvalues: t2 (copy) ]]
	local t = {
		Tension = p2 or 0.5,
		Points = {},
		LengthIterations = 1000,
		LengthIndices = {},
		Length = 0,
		ConnectedSplines = {},
		_connections = {}
	}

	if p1 ~= nil then
		for k, v in pairs(p1) do
			t2.AddPoint(t, v)
		end
	end

	setmetatable(t, {
		__index = t2,
		__newindex = function(p1, p2, p3) --[[ __newindex | Line: 44 ]]
			error("Cannot add new indices to CatmullRomSplineObject!")
		end
	})

	return t
end
function t2.ChangeTension(p1, p2) --[[ ChangeTension | Line: 57 | Upvalues: t2 (copy) ]]
	if type(p2) ~= "number" then
		error("CatmullRomSpline:ChangeTension() expected a number as an input, got " .. tostring(p2) .. "!")
	end

	p1.Tension = p2
	t2.UpdateLength(p1)
end
function t2.ChangeAllSplineTensions(p1, p2) --[[ ChangeAllSplineTensions | Line: 70 | Upvalues: t2 (copy) ]]
	if type(p2) ~= "number" then
		error("CatmullRomSpline:ChangeAllSplineTensions() expected a number as an input, got " .. tostring(p2) .. "!")
	end

	for k, v in pairs((t2.GetSplines(p1))) do
		v:ChangeTension(p2)
	end
end
function t2.AddPoint(p1, p2, p3) --[[ AddPoint | Line: 86 | Upvalues: t2 (copy), t (copy) ]]
	local Points = p1.Points

	local function checkIfPointsMatch(p12) --[[ checkIfPointsMatch | Line: 89 | Upvalues: t2 (ref), p1 (copy) ]]
		for k, v in pairs((t2.GetPoints(p1))) do
			if typeof(v) ~= typeof(p12) then
				return false
			end
		end

		return true
	end

	if #Points == 4 then
		if typeof(p2) == "number" or (typeof(p2) == "Vector2" or typeof(p2) == "Vector3") then
			if checkIfPointsMatch(p2) then
				local v1 = t2.GetSplines(p1)
				local v2 = v1[#v1]

				t2.ConnectSpline(p1, (t.new({
					v2.Points[2],
					v2.Points[3],
					v2.Points[4],
					p2
				}, v2.Tension)))
			end
		elseif p2:IsA("BasePart") and checkIfPointsMatch(p2.Position) then
			local v4 = t2.GetSplines(p1)
			local v5 = v4[#v4]

			t2.ConnectSpline(p1, (t.new({
				v5.Points[2],
				v5.Points[3],
				v5.Points[4],
				p2
			}, v5.Tension)))
		end
	elseif typeof(p2) == "number" or (typeof(p2) == "Vector2" or typeof(p2) == "Vector3") then
		if checkIfPointsMatch(p2) then
			table.insert(Points, if p3 then p3 else #Points + 1, p2)
		end
	elseif p2:IsA("BasePart") then
		if checkIfPointsMatch(p2.Position) then
			table.insert(Points, if p3 then p3 else #Points + 1, p2)
			p1._connections[p2] = p2.Changed:Connect(function(p12) --[[ Line: 131 | Upvalues: t2 (ref), p1 (copy) ]]
				if p12 ~= "Position" then
					return
				end

				t2.UpdateLength(p1)
			end)
		end
	else
		error("Invalid input received for CatmullRomSpline:AddPoint(), expected Vector3 or BasePart, got " .. tostring(p2) .. "!")
	end

	if #Points ~= 4 then
		return
	end

	t2.UpdateLength(p1)
end
function t2.RemovePoint(p1, p2) --[[ RemovePoint | Line: 150 ]]
	if type(p) ~= "number" then
		error("CatmullRomSpline:RemovePoint() expected a number as the input, got " .. tostring(p2) .. "!")
	end

	local v2 = table.remove(p1.Points, p2)

	if v2 == nil or (typeof(v2) ~= "Instance" or not (v2:IsA("BasePart") and p1._connections[v2])) then
		return
	end

	p1._connections[v2]:Disconnect()
	p1._connections[v2] = nil
end
function t2.GetPoints(p1) --[[ GetPoints | Line: 170 ]]
	local t = {}

	for i = 1, #p1.Points do
		t[i] = typeof(p1.Points[i]) == "Instance" and p1.Points[i].Position or p1.Points[i]
	end

	return t
end
function t2.ConnectSpline(p1, p2) --[[ ConnectSpline | Line: 187 | Upvalues: t2 (copy) ]]
	local Points = p2.Points
	local v1 = t2.GetSplines(p1)
	local Points2 = v1[#v1].Points

	local function checkIfPointsMatch(p12) --[[ checkIfPointsMatch | Line: 195 | Upvalues: t2 (ref), p1 (copy) ]]
		for k, v in pairs((t2.GetPoints(p1))) do
			if typeof(v) ~= typeof(p12) then
				return false
			end
		end

		return true
	end

	local v3, v4

	if typeof(Points2[1]) == "number" or typeof(Points2[1]) == "Vector3" then
		v3 = Points2[1]
		v4 = checkIfPointsMatch

		if not v3 then
			v3 = Points2[1].Position
		end
	else
		v4 = checkIfPointsMatch
		v3 = Points2[1].Position
	end

	if not v4(v3) then
		error("Cannot connect the spline because the splines do not have the same types of points!")
	end

	if Points2[2] == Points[1] and (Points2[3] == Points[2] and Points2[4] == Points[3]) then
		table.insert(p1.ConnectedSplines, p2)
		t2.UpdateLength(p1)
	else
		error("Cannot connect the spline because the splines do not share 3 common points!")
	end
end
function t2.GetSplines(p1) --[[ GetSplines | Line: 218 ]]
	local t = { p1 }

	for i = 1, #p1.ConnectedSplines do
		table.insert(t, p1.ConnectedSplines[i])
	end

	return t
end
function t2.GetSplineAt(p1, p2) --[[ GetSplineAt | Line: 230 | Upvalues: t2 (copy) ]]
	local v1 = t2.GetSplines(p1)

	local function percentage(p1, p2, p3) --[[ percentage | Line: 235 ]]
		local v1 = 1 / (p3 - p2)

		return v1 * p1 - v1 * p3 + 1
	end

	if type(p2) ~= "number" then
		error("CatmullRomSpline:GetSplineAt() expected a number as an input, got " .. tostring(p2) .. "!")
	end

	if #v1 == 1 then
		return p1, p2
	end

	local v2 = 1 / #v1

	if p2 <= 0 then
		return p1, p2 * v2
	end

	if p2 >= 1 then
		return v1[#v1], (p2 - 1) * v2 + 1
	end

	local v3 = math.ceil(p2 * #v1)
	local v4 = v3 * v2
	local v5 = 1 / (v4 - (v3 - 1) * v2)

	return v1[v3], v5 * p2 - v5 * v4 + 1
end
function t2.UpdateLength(p1) --[[ UpdateLength | Line: 265 | Upvalues: t2 (copy) ]]
	local t = {}
	local v2 = 0

	for k, v in pairs((t2.GetSplines(p1))) do
		local v3 = t2.GetPoints(v)

		if #v3 ~= 4 then
			error("Cannot get the length of the CatmullRomSpline object, expected 4 control points for all splines, got " .. tostring(#t) .. " points for spline " .. tostring(k) .. "!")
		end

		for k2, v4 in pairs(v3) do
			table.insert(t, v4)
		end
	end

	local LengthIterations = p1.LengthIterations
	local t3 = {}

	for i = 1, LengthIterations do
		local v4 = t2.CalculateDerivativeAt(p1, (i - 1) / (LengthIterations - 1))

		v2 = if typeof(v4) == "number" then v2 + v4 * (1 / LengthIterations) else v2 + v4.Magnitude * (1 / LengthIterations)
		table.insert(t3, { (i - 1) / (LengthIterations - 1), v2, v4 })
	end

	p1.Length = v2
	p1.LengthIndices = t3
end
function t2.CalculatePositionAt(p1, p2) --[[ CalculatePositionAt | Line: 301 | Upvalues: t2 (copy) ]]
	if type(p2) ~= "number" then
		error("The given t value in CatmullRomSpline:CalculatePositionAt() was not between 0 and 1, got " .. tostring(p2) .. "!")
	end

	local v1, v2 = t2.GetSplineAt(p1, p2)
	local v3 = t2.GetPoints(v1)

	if #v3 ~= 4 then
		error("The CatmullRomSpline object has an invalid number of points (" .. tostring(#v3) .. "), expected 4 points!")
	end

	local Tension = v1.Tension

	return v3[2] + Tension * (v3[3] - v3[1]) * v2 + (3 * (v3[3] - v3[2]) - Tension * (v3[4] - v3[2]) - 2 * Tension * (v3[3] - v3[1])) * v2 ^ 2 + (-2 * (v3[3] - v3[2]) + Tension * (v3[4] - v3[2]) + Tension * (v3[3] - v3[1])) * v2 ^ 3
end
function t2.CalculatePositionRelativeToLength(p1, p2) --[[ CalculatePositionRelativeToLength | Line: 330 | Upvalues: t2 (copy) ]]
	if type(p2) ~= "number" then
		error("CatmullRomSpline:CalculatePositionRelativeToLength() only accepts a number, got " .. tostring(p2) .. "!")
	end

	local Points = p1.Points

	if #Points ~= 4 then
		error("The CatmullRomSpline object has an invalid number of points (" .. tostring(#Points) .. "), expected 4 points!")
	end

	local LengthIndices = p1.LengthIndices
	local LengthIterations = p1.LengthIterations

	t2.GetPoints(p1)

	local v1 = p1.Length * p2
	local v2 = nil
	local v3 = nil

	for i, v in ipairs(LengthIndices) do
		if v1 - v[2] <= 0 or i == #LengthIndices then
			v2 = i
			v3 = v

			break
		end
	end

	local v4, v5

	if LengthIndices[v2 - 1] then
		local v6 = t2.CalculatePositionAt(p1, LengthIndices[v2 - 1][1])

		v4, v5 = v6, t2.CalculatePositionAt(p1, v3[1])
	else
		local v8 = t2.CalculatePositionAt(p1, v3[1])

		v4, v5 = v8, t2.CalculatePositionAt(p1, LengthIndices[v2 + 1][1])
	end

	if typeof(v4) == "number" and typeof(v5) == "number" then
		return v4 + (v5 - v4) * (1 - (v3[2] - v1) / (v5 - v4))
	end

	return v4 + (v5 - v4) * (1 - (v3[2] - v1) / (v5 - v4).Magnitude)
end
function t2.CalculateDerivativeAt(p1, p2) --[[ CalculateDerivativeAt | Line: 387 | Upvalues: t2 (copy) ]]
	if type(p2) ~= "number" then
		error("The given t value in CatmullRomSpline:CalculateDerivativeAt() was not between 0 and 1, got " .. tostring(p2) .. "!")
	end

	local v1, v2 = t2.GetSplineAt(p1, p2)
	local v3 = t2.GetPoints(v1)

	if #v3 ~= 4 then
		error("The CatmullRomSpline object has an invalid number of points (" .. tostring(#v3) .. "), expected 4 points!")
	end

	local Tension = v1.Tension

	return Tension * (v3[3] - v3[1]) + 2 * (3 * (v3[3] - v3[2]) - Tension * (v3[4] - v3[2]) - 2 * Tension * (v3[3] - v3[1])) * v2 + 3 * (-2 * (v3[3] - v3[2]) + Tension * (v3[4] - v3[2]) + Tension * (v3[3] - v3[1])) * v2 ^ 2
end
function t2.CalculateDerivativeRelativeToLength(p1, p2) --[[ CalculateDerivativeRelativeToLength | Line: 415 | Upvalues: t2 (copy) ]]
	if type(p2) ~= "number" then
		error("CatmullRomSpline:CalculateDerivativeRelativeToLength() only accepts a number, got " .. tostring(p2) .. "!")
	end

	local Points = p1.Points

	if #Points ~= 4 then
		error("The CatmullRomSpline object has an invalid number of points (" .. tostring(#Points) .. "), expected 4 points!")
	end

	local LengthIndices = p1.LengthIndices
	local LengthIterations = p1.LengthIterations

	t2.GetPoints(p1)

	local v1 = p1.Length * p2
	local v2 = nil
	local v3 = nil

	for i, v in ipairs(LengthIndices) do
		if v1 - v[2] <= 0 or i == #LengthIndices then
			v2 = i
			v3 = v

			break
		end
	end

	local v4, v5

	if LengthIndices[v2 - 1] then
		local v6 = t2.CalculateDerivativeAt(p1, LengthIndices[v2 - 1][1])

		v4, v5 = v6, t2.CalculateDerivativeAt(p1, v3[1])
	else
		local v8 = t2.CalculateDerivativeAt(p1, v3[1])

		v4, v5 = v8, t2.CalculateDerivativeAt(p1, LengthIndices[v2 + 1][1])
	end

	return v4 + (v5 - v4) * (1 - (if typeof(v4) == "number" and typeof(v5) == "number" then if math.abs(v5 - v4) > 0 then (v3[2] - v1) / (v5 - v4) else 0 elseif (v5 - v4).Magnitude > 0 then (v3[2] - v1) / (v5 - v4).Magnitude else 0))
end
function t2.CreateTween(p1, p2, p3, p4, p5) --[[ CreateTween | Line: 483 | Upvalues: TweenService (copy), t2 (copy) ]]
	if typeof(p2) ~= "Instance" then
		error("CatmullRomSplineObject:CreateTween() expected an instance as the first input, got " .. tostring(p2) .. "!")
	end

	if typeof(p3) ~= "TweenInfo" then
		error("CatmullRomSplineObject:CreateTween() expected a TweenInfo object as the second input, got " .. tostring(p3) .. "!")
	end

	local v1 = true

	for k, v in pairs(p4) do
		local ok, result = pcall(function() --[[ Line: 497 | Upvalues: p2 (copy), v (copy) ]]
			return p2[v]
		end)

		if not ok or result == nil then
			v1 = false
		end
	end

	if v1 then
		local v2, v3, v4

		v2 = Instance.new("NumberValue")
		v3 = TweenService:Create(v2, p3, {
			Value = 1
		})
		v4 = nil
		v3.Changed:Connect(function(p13) --[[ Line: 512 | Upvalues: v3 (copy), v4 (ref), v2 (copy), p4 (copy), p5 (copy), t2 (ref), p1 (copy), p2 (copy) ]]
			if p13 ~= "PlaybackState" then
				return
			end

			if v3.PlaybackState == Enum.PlaybackState.Playing then
				v4 = v2.Changed:Connect(function(p13) --[[ Line: 516 | Upvalues: p4 (ref), p5 (ref), t2 (ref), p1 (ref), p2 (ref) ]]
					for k2, v in pairs(p4) do
						local v1 = p5 and t2.CalculatePositionRelativeToLength(p1, p13) or t2.CalculatePositionAt(p1, p13)
						local v2 = p5 and t2.CalculateDerivativeRelativeToLength(p1, p13) or t2.CalculateDerivativeAt(p1, p13)
						local v3 = typeof(v1) == "Vector3" and typeof(v2) == "Vector3" and CFrame.new(v1, v1 + v2) or v1

						if typeof(p2[v]) == "number" or typeof(p2[v] == "Vector2") then
							p2[v] = v3
						else
							if typeof(p2[v]) == "CFrame" then
								p2[v] = v3

								continue
							end

							if typeof(p2[v] == "Vector3") then
								p2[v] = v3.Position

								continue
							end

							error("CatmullRomSplineObject:CreateTween() could not set the value of the instance property " .. tostring(v) .. ", not a numerical value!")
						end
					end
				end)

				return
			end

			if v4 == nil then
				return
			end

			v4:Disconnect()
			v4 = nil
		end)

		return v3
	end

	error("CatmullRomSplineObject:CreateTween() was given properties in the property table that do not belong to the instance!")
end

return t