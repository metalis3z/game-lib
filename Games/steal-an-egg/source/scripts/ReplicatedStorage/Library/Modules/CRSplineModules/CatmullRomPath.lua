-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local BaseSpline = require(script.Parent:WaitForChild("BaseSpline"))
local CatmullRomSpline = require(script.Parent:WaitForChild("CatmullRomSpline"))
local v1 = setmetatable({}, BaseSpline)

v1.__index = v1
function v1.new(p1, p2) --[[ new | Line: 69 | Upvalues: BaseSpline (copy), v1 (copy) ]]
	local v3 = setmetatable(BaseSpline.new(), v1)

	v3.LinkedSplines = {}
	v3.LinkConnectedSplinesOnly = p2 or false
	v3._Connections = {}

	if p1 ~= nil then
		for i = 1, #p1 do
			v3:LinkSpline(p1[i])
		end
	end

	return v3
end
function v1.fromPoints(p1, p2) --[[ fromPoints | Line: 92 | Upvalues: CatmullRomSpline (copy), v1 (copy) ]]
	if #p1 < 4 then
		error("Cannot create a CatmullRomPath from less than 4 control points!")
	end

	local t = {}

	for i = 3, #p1 - 1 do
		table.insert(t, CatmullRomSpline.new({
			p1[i - 2],
			p1[i - 1],
			p1[i],
			p1[i + 1]
		}, p2))
	end

	return v1.new(t, true)
end
function v1.LinkSpline(p1, p2) --[[ LinkSpline | Line: 120 ]]
	local LinkedSplines = p1.LinkedSplines
	local v1 = LinkedSplines[#LinkedSplines]

	if v1 ~= nil and p1.LinkConnectedSplinesOnly then
		local Points = v1.Points
		local Points2 = p2.Points
		local v2 = true

		if Points[2] == Points2[1] and Points[3] == Points2[2] then
			if Points[4] ~= Points2[3] then
				v2 = false
			end
		else
			v2 = false
		end

		if not v2 then
			error("Unable to link the given CatmullRomSpline to the CatmullRomPath!")
		end
	end

	table.insert(LinkedSplines, p2)
	p1:_ListenToSplineUpdate(p2)

	for i = 1, #LinkedSplines do
		if #LinkedSplines[i].Points < 4 then
			return
		end
	end

	p1:_UpdateLength()
end
function v1.UnlinkSpline(p1, p2) --[[ UnlinkSpline | Line: 159 ]]
	local LinkedSplines = p1.LinkedSplines
	local LinkConnectedSplinesOnly = p1.LinkConnectedSplinesOnly

	if typeof(p2) == "number" then
		if LinkConnectedSplinesOnly and p2 ~= #LinkedSplines then
			warn("Cannot unlink the spline; this path is meant to be connected by connected splines!\nTry setting CatmullRomSpline.LinkConnectedSplinesOnly to false!")

			return
		end

		if LinkedSplines[p2] == nil then
			return
		end

		table.remove(LinkedSplines, p2)
	else
		local v1 = table.find(LinkedSplines, p2)

		if v1 == nil then
			return
		end

		if LinkConnectedSplinesOnly and v1 ~= #LinkedSplines then
			return
		end

		table.remove(LinkedSplines, v1)
	end

	p1:_StopListeningToSplineUpdate(p2)

	if #LinkedSplines < 1 then
		return
	end

	for i = 1, #LinkedSplines do
		if #LinkedSplines[i].Points < 4 then
			return
		end
	end

	p1:_UpdateLength()
end
function v1.PiecewiseTransform(p1, p2) --[[ PiecewiseTransform | Line: 204 ]]
	local LinkedSplines = p1.LinkedSplines
	local v1 = #LinkedSplines

	if v1 == 1 then
		return LinkedSplines[1], p2
	end

	if v1 < 1 then
		error("Cannot return a spline at value t without splines!")
	end

	local v2 = 1 / v1
	local v3, v4

	if p2 <= 0 then
		v3 = 1
		v4 = p2 * v2
	elseif p2 >= 1 then
		v3 = #LinkedSplines
		v4 = (p2 - 1) * v2 + 1
	else
		local v5 = math.ceil(p2 * v1)

		v3 = v5
		v4 = p2 * v1 - v5 + 1
	end

	return LinkedSplines[v3], v4
end
function v1._ListenToSplineUpdate(p1, p2) --[[ _ListenToSplineUpdate | Line: 231 ]]
	p1:_StopListeningToSplineUpdate(p2)
	p1._Connections[p2] = p2.Updated:Connect(function() --[[ Line: 234 | Upvalues: p1 (copy) ]]
		p1:_UpdateLength()
	end)
end
function v1._StopListeningToSplineUpdate(p1, p2) --[[ _StopListeningToSplineUpdate | Line: 240 ]]
	local v1 = p1._Connections[p2]

	if not v1 then
		return
	end

	v1:Disconnect()
	v1[p2] = nil
end
function v1.Position(p1, p2) --[[ Position | Line: 249 ]]
	local v1, v2 = p1:PiecewiseTransform(p2)

	return v1:Position(v2)
end
function v1.Velocity(p1, p2) --[[ Velocity | Line: 254 ]]
	local v1, v2 = p1:PiecewiseTransform(p2)

	return v1:Velocity(v2)
end
function v1.Acceleration(p1, p2) --[[ Acceleration | Line: 259 ]]
	local v1, v2 = p1:PiecewiseTransform(p2)

	return v1:Acceleration(v2)
end

return v1