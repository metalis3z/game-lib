-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local BaseSpline = require(script.Parent:WaitForChild("BaseSpline"))
local t = { "number", "Vector2", "Vector3", "Instance" }

local function isCatmullRomPoint(p1) --[[ isCatmullRomPoint | Line: 78 | Upvalues: t (copy) ]]
	local v1 = typeof(p1)

	if table.find(t, v1) == nil then
		return false
	end

	if v1 == "Instance" then
		return p1:IsA("BasePart")
	end

	return true
end

local v1 = setmetatable({}, BaseSpline)

v1.__index = v1
function v1.new(p1, p2) --[[ new | Line: 95 | Upvalues: BaseSpline (copy), v1 (copy) ]]
	local v3 = setmetatable(BaseSpline.new(), v1)

	v3.Points = {}
	v3.Tension = p2 or 0.5
	v3._PointType = "nil"
	v3._Connections = {}

	if p1 ~= nil then
		for i = 1, #p1 do
			v3:AddPoint(p1[i])
		end
	end

	return v3
end
function v1.ChangeTension(p1, p2) --[[ ChangeTension | Line: 115 ]]
	if p1.Tension == p2 then
		return
	end

	p1.Tension = p2

	if #p1.Points ~= 4 then
		return
	end

	p1:_UpdateLength()
end
function v1.IsValidPoint(p1, p2) --[[ IsValidPoint | Line: 128 | Upvalues: isCatmullRomPoint (ref) ]]
	local v1 = false

	if p1._PointType == "Vector3" and (typeof(p2) == "Instance" and p2:IsA("BasePart")) or (p1._PointType == "Instance" and typeof(p2) == "Vector3" or p1._PointType == typeof(p2)) then
		v1 = true
	end

	return isCatmullRomPoint(p2) and v1
end
function v1.AddPoint(p1, p2, p3) --[[ AddPoint | Line: 143 | Upvalues: isCatmullRomPoint (ref) ]]
	local Points = p1.Points

	if #Points == 0 then
		p1._PointType = typeof(p2)
	elseif #Points > 3 then
		error("Cannot add more points to this CatmullRomSpline object!")
	end

	if not (isCatmullRomPoint(p2) and p1:IsValidPoint(p2)) then
		error("The given point is not a valid point for this CatmullRomSpline object!")
	end

	if typeof(p2) == "Instance" and p2:IsA("BasePart") then
		p1:_ListenToPositionChange(p2)
	end

	table.insert(Points, if p3 then p3 else #Points + 1, p2)

	if #Points ~= 4 then
		return
	end

	p1:_UpdateLength()
end
function v1.RemovePoint(p1, p2) --[[ RemovePoint | Line: 169 ]]
	local Points = p1.Points

	if Points[p2] == nil then
		return
	end

	local v1 = table.remove(Points, p2)

	if typeof(v1) == "Instance" and v1:IsA("BasePart") then
		p1:_StopListeningToPositionChange(v1)
	end

	if not (#Points < 4) then
		return
	end

	p1.Length = 0
	p1._LengthCache = {}
end
function v1.GetVectorPoints(p1) --[[ GetVectorPoints | Line: 188 ]]
	local t = {}

	for i, v in ipairs(p1.Points) do
		if typeof(v) == "Instance" then
			if v:IsA("BasePart") then
				t[i] = v.Position

				continue
			end

			local v1 = error

			v1("CatmullRomSpline expected a BasePart Instance, got " .. tostring(v.ClassName) .. "!")

			continue
		end

		t[i] = v
	end

	return t
end
function v1.GetVectorConstants(p1) --[[ GetVectorConstants | Line: 206 ]]
	local v1 = p1:GetVectorPoints()
	local v2 = #v1

	if not (v2 < 4) then
		local v3

		v3 = p1.Tension

		return v1[2], v3 * (v1[3] - v1[1]), 3 * (v1[3] - v1[2]) - v3 * (v1[4] - v1[2]) - 2 * v3 * (v1[3] - v1[1]), -2 * (v1[3] - v1[2]) + v3 * (v1[4] - v1[2]) + v3 * (v1[3] - v1[1])
	end

	error("CatmullRomSpline:GetVectorConstants() expected 4 points, got " .. tostring(v2) .. " points.")
end
function v1._ListenToPositionChange(p1, p2) --[[ _ListenToPositionChange | Line: 221 ]]
	p1._Connections[p2] = p2:GetPropertyChangedSignal("Position"):Connect(function() --[[ Line: 223 | Upvalues: p1 (copy) ]]
		if not (#p1.Points < 4) then
			p1:_UpdateLength()
		end
	end)
end
function v1._StopListeningToPositionChange(p1, p2) --[[ _StopListeningToPositionChange | Line: 232 ]]
	local _Connections = p1._Connections
	local v1 = _Connections[p2]

	if v1 ~= nil then
		v1:Disconnect()
		_Connections[p2] = nil
	end
end
function v1.Position(p1, p2) --[[ Position | Line: 244 ]]
	local v1, v2, v3, v4 = p1:GetVectorConstants()

	return v1 + v2 * p2 + v3 * p2 * p2 + v4 * p2 * p2 * p2
end
function v1.Velocity(p1, p2) --[[ Velocity | Line: 251 ]]
	local _, v1, v2, v3 = p1:GetVectorConstants()

	return v1 + 2 * v2 * p2 + 3 * v3 * p2 * p2
end
function v1.Acceleration(p1, p2) --[[ Acceleration | Line: 258 ]]
	local _, _2, v1, v2 = p1:GetVectorConstants()

	return 2 * v1 + 6 * v2 * p2
end

return v1