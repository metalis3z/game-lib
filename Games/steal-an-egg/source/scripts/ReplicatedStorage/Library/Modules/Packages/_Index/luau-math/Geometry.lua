-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
function deduplicateList(p1) --[[ deduplicateList | Line: 2 ]]
	local tbl = {}

	for i, v in ipairs(p1) do
		if tbl[v] == nil then
			tbl[v] = i
		end
	end

	local t = {}

	for k, v in pairs(tbl) do
		table.insert(t, k)
	end

	return t
end
require(script.Parent.Types)

local Earcut = require(script.Earcut)
local t = {}

t.__index = t
t.phi = 1.618033988749895
function t.getLineLength(p1) --[[ getLineLength | Line: 41 ]]
	return (p1[1] - p1[2]).Magnitude
end
function t.getLineLengths(p1) --[[ getLineLengths | Line: 46 | Upvalues: t (copy) ]]
	local t2 = {}

	for k, v in pairs(p1) do
		t2[k] = t.getLineLength(v)
	end

	return t2
end
function t.getLineCenter(p1) --[[ getLineCenter | Line: 55 ]]
	return p1[1]:Lerp(p1[2], 0.5)
end
function t.getLineCenters(p1) --[[ getLineCenters | Line: 60 | Upvalues: t (copy) ]]
	local t2 = {}

	for k, v in pairs(p1) do
		t2[k] = t.getLineCenter(v)
	end

	return t2
end
function t.getLineAxis(p1) --[[ getLineAxis | Line: 69 ]]
	return (p1[1] - p1[2]).Unit
end
function t.getLineAxes(p1) --[[ getLineAxes | Line: 74 | Upvalues: t (copy) ]]
	local t2 = {}

	for k, v in pairs(p1) do
		t2[k] = t.getLineAxis(v)
	end

	return t2
end
function t.getIfVerticesConnected(p1, p2, p3) --[[ getIfVerticesConnected | Line: 83 ]]
	for k, v in pairs(p3) do
		if v[1] == p1 and v[2] == p2 then
			return true
		end

		if v[1] == p2 and v[2] == p1 then
			return true
		end
	end

	return false
end
function t.getConnectedVertices(p1, p2) --[[ getConnectedVertices | Line: 93 ]]
	local t = {}

	for k, v in pairs(p2) do
		if p1 == v[1] then
			table.insert(t, v[2])

			continue
		end

		if p1 == v[2] then
			table.insert(t, v[1])
		end
	end

	return t
end
function t.getAllVerticesFromLines(p1) --[[ getAllVerticesFromLines | Line: 106 ]]
	local t = {}

	for k, v in pairs(p1) do
		table.insert(t, v[1])
		table.insert(t, v[2])
	end

	return deduplicateList(t)
end
function t.getAllVertexConnectionsFromLines(p1) --[[ getAllVertexConnectionsFromLines | Line: 116 ]]
	local tbl = {}

	for k, v in pairs(p1) do
		tbl[v[1]] = tbl[v[1]] or {}
		tbl[v[1]][v[2]] = true
		tbl[v[2]] = tbl[v[2]] or {}
		tbl[v[2]][v[1]] = true
	end

	local t = {}

	for k, v in pairs(tbl) do
		local t2 = {}

		for k2, v2 in pairs(v) do
			table.insert(t2, k2)
		end

		t[k] = t2
	end

	return t
end
function t.getSharedVertex(p1, p2) --[[ getSharedVertex | Line: 136 ]]
	local v1 = nil

	for i, v in ipairs(p1) do
		for i2, v2 in ipairs(p2) do
			if v == v2 then
				v1 = v

				break
			end
		end
	end

	return v1
end
function t.getIfRightAngle(p1, p2, p3) --[[ getIfRightAngle | Line: 150 | Upvalues: t (copy) ]]
	local v1 = t.getConnectedVertices(p1, { p2, p3 })

	return math.round((p1 - v1[1]).Unit:Dot((p1 - v1[2]).Unit) * 100) / 100 == 0
end
function t.getIfRightAngleFromVertices(p1, p2, p3) --[[ getIfRightAngleFromVertices | Line: 159 | Upvalues: t (copy) ]]
	return t.getIfRightAngle(p1, { p1, p2 }, { p1, p3 })
end
function t.getRightAngleVertices(p1) --[[ getRightAngleVertices | Line: 166 | Upvalues: t (copy) ]]
	local t2 = {}

	for k, v in pairs((t.getAllVertexConnectionsFromLines(p1))) do
		if t.getIfRightAngleFromVertices(k, v[1], v[2]) then
			table.insert(t2, k)
		end
	end

	return t2
end
function t.getIntersectionBetweenTwoLines(p1, p2) --[[ getIntersectionBetweenTwoLines | Line: 180 | Upvalues: t (copy) ]]
	local v1 = t.getClosestPointToLineOnLine(p1, p2)

	if not v1 then
		return
	end

	local v2 = t.getClosestPointToLineOnLine(p2, p1)

	if not v2 then
		return
	end

	assert(if v1 == nil then false elseif v2 == nil then false else true)

	return v1:Lerp(v2, 0.5)
end
function t.getVertexOppositePointsFromLines(p1) --[[ getVertexOppositePointsFromLines | Line: 196 | Upvalues: t (copy) ]]
	local v1 = t.getRightAngleVertices(p1)
	local v2 = t.getAllVerticesFromLines(p1)
	local t2 = {}

	if #v1 == 4 then
		for i, v in ipairs(v1) do
			if t2[v] == nil then
				for i2, v3 in ipairs(v1) do
					if v3 ~= v and t.getIfVerticesConnected(v, v3, p1) == false then
						t2[v] = v3
						t2[v3] = v
					end
				end
			end
		end
	elseif #v1 == 1 then
		local v3 = v1[1]
		local v4 = if v2[1] == v3 then v2[2] else v2[1]
		local v5 = if v2[3] == v3 then v2[2] else v2[3]

		t2[v3] = v4:Lerp(v5, 0.5)
		t2[v4] = v3:Lerp(v5, 0.5)
		t2[v5] = v3:Lerp(v4, 0.5)
	elseif #v1 == 0 then
		local v6 = v2[1]
		local v7 = v2[3]
		local v8 = v2[2]

		t2[v6] = v7:Lerp(v8, 0.5)
		t2[v7] = v6:Lerp(v8, 0.5)
		t2[v8] = v7:Lerp(v6, 0.5)
	end

	return t2
end
function t.getDiagonalLinesFromEdges(p1) --[[ getDiagonalLinesFromEdges | Line: 234 | Upvalues: t (copy) ]]
	local tbl = {}

	for k, v in pairs((t.getVertexOppositePointsFromLines(p1))) do
		if not (tbl[k] or tbl[v]) then
			tbl[k] = { k, v }
		end
	end

	local t2 = {}

	for k, v in pairs(tbl) do
		table.insert(t2, v)
	end

	return t2
end
function t.getTrianglePerimeter(p1, p2, p3) --[[ getTrianglePerimeter | Line: 253 ]]
	return (p1 - p2).Magnitude + (p2 - p3).Magnitude + (p3 - p1).Magnitude
end
function t.getTriangleArea(p1, p2, p3) --[[ getTriangleArea | Line: 261 | Upvalues: t (copy) ]]
	local v1 = t.getTrianglePerimeter(p1, p2, p3) / 2

	return math.sqrt(v1 * (v1 - (p1 - p2).Magnitude) * (v1 - (p2 - p3).Magnitude) * (v1 - (p3 - p1).Magnitude))
end
function t.getIfPointIsInTriangle(p1, p2, p3, p4) --[[ getIfPointIsInTriangle | Line: 277 | Upvalues: t (copy) ]]
	local v1 = t.getTriangleArea(p2, p3, p4)

	return v1 == t.getTriangleArea(p1, p3, p4) + v1 + t.getTriangleArea(p2, p3, p1)
end
function t.getAngleThroughLawOfCos(p1, p2, p3) --[[ getAngleThroughLawOfCos | Line: 285 | Upvalues: t (copy) ]]
	local v1 = t.getLineLength(p1)
	local v2 = t.getLineLength(p2)
	local v3 = t.getLineLength(p3)

	if math.round(1000 * (v1 + v2)) == math.round(1000 * v3) then
		return 0
	end

	return math.acos((v1 ^ 2 + v2 ^ 2 - v3 ^ 2) / (2 * v1 * v2))
end
function t.getAngleBetweenTwoLines(p1, p2) --[[ getAngleBetweenTwoLines | Line: 302 | Upvalues: t (copy) ]]
	local v1 = t.getSharedVertex(p1, p2)
	local t2 = {}
	local v2 = if p1[1] == v1 then p1[2] else p1[1]
	local v3 = if p2[1] == v1 then p2[2] else p2[1]

	t2[1] = v2
	t2[2] = v3

	return t.getAngleThroughLawOfCos(p1, p2, t2)
end
function t.getSideLengthThroughLawOfCos(p1, p2, p3) --[[ getSideLengthThroughLawOfCos | Line: 312 | Upvalues: t (copy) ]]
	local v1 = t.getLineLength(p2)
	local v2 = t.getLineLength(p3)

	return math.sqrt(v1 ^ 2 + v2 ^ 2 - v1 * 2 * v2 * math.cos(p1))
end
function t.getLineInwardNormal(p1, p2) --[[ getLineInwardNormal | Line: 319 | Upvalues: t (copy) ]]
	local v1 = t.getLineCenter(p1)
	local Unit = (p1[2] - p1[1]).Unit
	local Unit2 = (v1 - p2).Unit
	local v2 = Unit:Cross(Unit2):Cross(Unit)

	if v2:Dot(Unit2) > 0 then
		return v2
	end

	return -v2
end
function t.getClosestPointInList(p1, p2) --[[ getClosestPointInList | Line: 337 ]]
	local v1 = (1 / 0)
	local v2 = nil

	for i, v in ipairs(p2) do
		local Magnitude = (p1 - v).Magnitude

		if Magnitude < v1 then
			v1 = Magnitude
			v2 = v
		end
	end

	return v2
end
function t.getFarthestPointInList(p1, p2) --[[ getFarthestPointInList | Line: 351 ]]
	local v1 = 0
	local v2 = nil

	for i, v in ipairs(p2) do
		local Magnitude = (p1 - v).Magnitude

		if v1 < Magnitude then
			v1 = Magnitude
			v2 = v
		end
	end

	return v2
end
function t.getClosestPointOnLine(p1, p2) --[[ getClosestPointOnLine | Line: 365 | Upvalues: t (copy) ]]
	local v1 = p2[1]
	local v2 = p2[2]
	local v6 = v1 + (v2 - v1).Unit * math.min(math.cos((t.getAngleThroughLawOfCos({ p1, v1 }, p2, { p1, v2 }))) * (p1 - v1).Magnitude, (v1 - v2).Magnitude)

	if v6 ~= v6 then
		return p1
	end

	local v7 = p2[1]
	local v8 = p2[2]

	if (v8 - v7).Unit:Dot((v6 - v8).Unit) > 0 then
		return v7
	end

	if (v8 - v7).Magnitude < (v6 - v7).Magnitude then
		v6 = v8
	end

	return v6
end
function t.getLineClosestToPoint(p1, p2) --[[ getLineClosestToPoint | Line: 393 | Upvalues: t (copy) ]]
	local v1 = (1 / 0)
	local v2 = nil

	for k, v in pairs(p2) do
		local Magnitude = (t.getClosestPointOnLine(p1, v) - p1).Magnitude

		if Magnitude < v1 then
			v1 = Magnitude
			v2 = v
		end
	end

	return v2
end
function t.getCenterFromLines(p1) --[[ getCenterFromLines | Line: 408 | Upvalues: t (copy) ]]
	local v1 = t.getDiagonalLinesFromEdges(p1)
	local v2 = nil

	if #p1 == 4 then
		return t.getLineCenter(v1[1])
	end

	if #p1 == 3 then
		local v3 = t.getAllVerticesFromLines(p1)

		if #t.getRightAngleVertices(p1) == 1 then
			local v4 = v1[1]
			local v5 = v1[2]

			assert(v4 ~= nil, "Bad diagonal 1")
			assert(if v5 == nil then false else true, "Bad diagonal 2")

			return t.getIntersectionBetweenTwoLines(v4, v5)
		end

		v2 = v3[1]:Lerp(v3[3], 0.5):Lerp(v3[2], 0.66)
	end

	return v2
end
function t.getSurfaceCFrameFromLines(p1, p2) --[[ getSurfaceCFrameFromLines | Line: 434 | Upvalues: t (copy) ]]
	local v1 = 0
	local v2 = nil

	for k, v in pairs(p1) do
		local v3 = t.getLineLength(v)

		if v1 < v3 then
			v1 = v3
			v2 = v
		end
	end

	local v4 = t.getCenterFromLines(p1)

	assert(if v4 == nil then false else true, "Bad center point")

	local v6 = -t.getLineInwardNormal(v2, v4)

	return CFrame.fromMatrix(v4, v6:Cross(p2), p2, v6)
end
function t.getBoxBoundaries(p1, p2) --[[ getBoxBoundaries | Line: 457 ]]
	local v1 = p2 * 0.5

	return (p1 * CFrame.new(-v1.X, -v1.Y, -v1.Z)).Position, (p1 * CFrame.new(v1.X, v1.Y, v1.Z)).Position
end
function t.getPlaneIntersection(p1, p2, p3, p4) --[[ getPlaneIntersection | Line: 465 ]]
	local v3 = -math.abs((p2:Dot(p4)))

	if v3 == 0 then
		return p1, 0
	end

	local v4 = -(p1 - p3):Dot(p4) / v3

	return p1 + v4 * p2, v4
end
function t.getNonPerpindicularNormal(p1) --[[ getNonPerpindicularNormal | Line: 483 ]]
	local v1 = p1:Cross(Vector3.new(0, 1, 0))

	if math.abs((v1:Dot(p1))) == 1 then
		v1 = p1:Cross(Vector3.new(1, 0, 0))
	end

	return v1
end
function t.getSideLengthThroughLawOfSin(p1, p2, p3) --[[ getSideLengthThroughLawOfSin | Line: 492 ]]
	return (p3[2] - p3[1]).Magnitude * math.sin(p1) / math.sin(p2)
end
function t.getClosestPointToLineOnLine(p1, p2) --[[ getClosestPointToLineOnLine | Line: 497 | Upvalues: t (copy) ]]
	local v1 = p1[1]
	local v2 = p1[2] - p1[1]
	local Unit = v2.Unit
	local v3 = p2[1]

	if (p2[2] - p2[1]).Unit:Dot(Unit) > 0 then
		v3 = p2[2]

		local Unit2 = (p2[1] - p2[2]).Unit
	end

	local t2 = { v1, v3 }
	local v4 = t.getAngleBetweenTwoLines(t2, p1)
	local v5 = t.getAngleBetweenTwoLines(t2, p2)
	local v6 = t.getSideLengthThroughLawOfSin(v5, math.pi - v5 - v4, t2)

	return v1 + Unit * math.clamp(v6, 0, v2.Magnitude)
end
function t.getVolume(p1) --[[ getVolume | Line: 521 ]]
	return p1.X * p1.Y * p1.Z
end
function t.triangulate2D(p1, p2) --[[ triangulate2D | Line: 525 | Upvalues: Earcut (copy) ]]
	local t = {}
	local v1 = p2 or {}

	assert(if v1 == nil then false else true)

	local v3, v4

	if p1[1] == p1[#p1] then
		v3 = false
		v4 = v1
	else
		v3 = true
		v4 = v1
	end

	assert(v3, "Perimeter has a duplicate index")

	for i, v in ipairs(v4) do
		assert(p1[1] ~= p1[#p1], "Hole " .. tostring(i) .. " has a duplicate ending index")
	end

	local t2 = {}

	local function insertPerimeterSequence(p1) --[[ insertPerimeterSequence | Line: 544 | Upvalues: t2 (copy) ]]
		local t = {}

		for i, v in ipairs(p1) do
			t[i] = { v.X, v.Y }
		end

		table.insert(t2, t)

		return nil
	end

	insertPerimeterSequence(p1)

	for i, v in ipairs(v4) do
		insertPerimeterSequence(v)
	end

	local t3 = {}
	local t4 = {}
	local t5 = {}
	local t6 = {}
	local sum = 1

	for i = 1, #t2 do
		for j = 1, #t2[i] do
			for k = 1, 2 do
				t6[k] = math.max(t6[k] or (-1 / 0), t2[i][j][k])
				t4[k] = math.min(t4[k] or (1 / 0), t2[i][j][k])
				table.insert(t5, t2[i][j][k])
			end
		end

		if i > 1 then
			sum = sum + #t2[i - 1]
			table.insert(t3, sum)
		end
	end

	local v12 = Earcut(t5, t3, 2)

	for n = 1, #v12, 3 do
		local v13 = v12[n]
		local v14 = v12[n + 1]
		local v15 = v12[n + 2]

		assert(if v13 == nil or v14 == nil then false elseif v15 == nil then false else true)

		local v17 = v13 * 2 + 1
		local v18 = v14 * 2 + 1
		local v19 = v15 * 2 + 1

		table.insert(t, { Vector2.new(t5[v17], t5[v17 + 1]), Vector2.new(t5[v18], t5[v18 + 1]), Vector2.new(t5[v19], t5[v19 + 1]) })
	end

	return t
end
function t.flattenPerimeterSequence(p1, p2) --[[ flattenPerimeterSequence | Line: 603 ]]
	local v1 = p2:Inverse()
	local t = {}
	local t2 = {}

	for i, v in ipairs(p1) do
		local v2 = v1 * CFrame.new(v)

		t[i] = Vector2.new(v2.X, v2.Y)
		t2[t[i]] = v
	end

	return t, t2
end
function t.triangulate3D(p1, p2, p3) --[[ triangulate3D | Line: 620 | Upvalues: t (copy) ]]
	local t2 = {}
	local t3 = {}

	for v3, v4 in ipairs(if p3 then p3 else {}) do
		local v5, v6 = t.flattenPerimeterSequence(v4, p1)

		t2[v3] = v5

		local v7 = v6

		for i, v in ipairs(t2[v3]) do
			t3[v.X] = t3[v.X] or {}
			t3[v.X][v.Y] = v7[v]
		end
	end

	local v9, v10 = t.flattenPerimeterSequence(p2, p1)

	for i, v in ipairs(v9) do
		t3[v.X] = t3[v.X] or {}
		t3[v.X][v.Y] = v10[v]
	end

	local t4 = {}

	for i, v in ipairs((t.triangulate2D(v9, t2))) do
		local t5 = {}

		for i2, v3 in ipairs(v) do
			t5[i2] = t3[v3.X][v3.Y]
		end

		t4[i] = t5
	end

	return t4
end
function t.getRegularPolygonInnerAngle(p1) --[[ getRegularPolygonInnerAngle | Line: 654 ]]
	assert(p1 > 2, "You can\'t have a 2-sided polygon")

	return 6.283185307179586 / p1
end
function t.getRegularPolygonVertexAngle(p1) --[[ getRegularPolygonVertexAngle | Line: 660 | Upvalues: t (copy) ]]
	assert(p1 > 2, "You can\'t have a 2-sided polygon")

	return 2 * (math.pi - t.getRegularPolygonInnerAngle(p1) / 2)
end
function t.getRegularPolygonEdgeCenterDistance(p1, p2) --[[ getRegularPolygonEdgeCenterDistance | Line: 667 | Upvalues: t (copy) ]]
	assert(if p2 > 0 then true else false, "Radius needs to be larger than 0")
	assert(if p1 > 2 then true else false, "You can\'t have a 2-sided polygon")

	return math.cos(t.getRegularPolygonInnerAngle(p1) / 2) * p2
end
function t.getRegularPolygonSideLength(p1, p2) --[[ getRegularPolygonSideLength | Line: 676 | Upvalues: t (copy) ]]
	assert(if p2 > 0 then true else false, "Radius needs to be larger than 0")
	assert(if p1 > 2 then true else false, "You can\'t have a 2-sided polygon")

	return math.sin(t.getRegularPolygonInnerAngle(p1) / 2) * 2 * p2
end
function t.getRegularPolygonPerimeter(p1, p2) --[[ getRegularPolygonPerimeter | Line: 685 | Upvalues: t (copy) ]]
	assert(if p2 > 0 then true else false, "Radius needs to be larger than 0")
	assert(if p1 > 2 then true else false, "You can\'t have a 2-sided polygon")

	return t.getRegularPolygonSideLength(p1, p2) * p1
end
function t.getRegularPolygonArea(p1, p2) --[[ getRegularPolygonArea | Line: 693 | Upvalues: t (copy) ]]
	return t.getRegularPolygonEdgeCenterDistance(p1, p2) * t.getRegularPolygonSideLength(p1, p2) * p1
end

return t