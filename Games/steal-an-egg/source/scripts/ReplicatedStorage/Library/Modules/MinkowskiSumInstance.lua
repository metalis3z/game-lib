-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Modules = game:GetService("ReplicatedStorage").Library.Modules
local TrianglePart = require(Modules.TrianglePart)
local QuickHull2 = require(Modules.QuickHull2)
local t = {
	meshCache = {},
	timeSpentTracing = 0
}
local t2 = {
	Vector3.new(0.5, 0.5, 0.5),
	Vector3.new(0.5, 0.5, -0.5),
	Vector3.new(-0.5, 0.5, 0.5),
	Vector3.new(-0.5, 0.5, -0.5),
	Vector3.new(0.5, -0.5, 0.5),
	Vector3.new(0.5, -0.5, -0.5),
	Vector3.new(-0.5, -0.5, 0.5),
	Vector3.new(-0.5, -0.5, -0.5)
}
local t3 = {
	Vector3.new(0.5, -0.5, -0.5),
	Vector3.new(-0.5, -0.5, -0.5),
	Vector3.new(0.5, -0.5, 0.5),
	Vector3.new(-0.5, -0.5, 0.5),
	Vector3.new(0.5, 0.5, 0.5),
	Vector3.new(-0.5, 0.5, 0.5)
}
local t4 = {
	Vector3.new(0.5, 0.5, -0.5),
	Vector3.new(0.5, -0.5, 0.5),
	Vector3.new(-0.5, -0.5, 0.5),
	Vector3.new(0.5, -0.5, -0.5),
	Vector3.new(-0.5, -0.5, -0.5)
}

local function IsUnique(p1, p2, p3) --[[ IsUnique | Line: 42 ]]
	for k, v in pairs(p1) do
		if math.abs(v.ed - p3) < 0.01 and v.n:Dot(p2) > 0.95 then
			return false
		end
	end

	return true
end

local function IsUniquePoint(p1, p2) --[[ IsUniquePoint | Line: 54 ]]
	for k, v in pairs(p1) do
		if (v - p2).magnitude < 0.001 then
			return false
		end
	end

	return true
end

local function IsUniqueTri(p1, p2, p3) --[[ IsUniqueTri | Line: 65 ]]
	for k, v in pairs(p1) do
		if not (math.abs(v[5] - p3) > 0.001 or v[4]:Dot(p2) < 0.999) then
			return false
		end
	end

	return true
end

function t.GetPlanesForInstance(p1, p2, p3, p4, p5, p6) --[[ GetPlanesForInstance | Line: 105 | Upvalues: t (copy) ]]
	if p2:IsA("MeshPart") and (p2.Anchored == true and (p2.CollisionFidelity == Enum.CollisionFidelity.Hull or p2.CollisionFidelity == Enum.CollisionFidelity.PreciseConvexDecomposition)) then
		return t:GetPlanesForInstanceMeshPart(p2, p3, p4, p5, p6)
	end

	local v1 = p1:GeneratePointsForInstance(p2, p3, p4)

	if p6 ~= nil then
		p1:VisualizePlanesForPoints(v1, p6)
	end

	return p1:GetPlanesForPoints(v1, p5)
end
function t.GetPlanesForPointsExpanded(p1, p2, p3, p4, p5) --[[ GetPlanesForPointsExpanded | Line: 130 | Upvalues: t2 (copy) ]]
	local t = {}

	for k, v in pairs(p2) do
		for k2, v2 in pairs(t2) do
			table.insert(t, v + v2 * p3)
		end
	end

	if p5 ~= nil then
		p1:VisualizePlanesForPoints(t, p5)
	end

	return p1:GetPlanesForPoints(t, p4)
end
function t.VisualizePlanesForPoints(p1, p2) --[[ VisualizePlanesForPoints | Line: 145 | Upvalues: QuickHull2 (copy) ]]
	p1:VisualizeTriangles(QuickHull2:GenerateHull(p2), Vector3.new(0, 0, 0))
end
function t.VisualizeTriangles(p1, p2, p3) --[[ VisualizeTriangles | Line: 154 | Upvalues: TrianglePart (copy) ]]
	local v1 = Color3.fromHSV(math.random(), 0.5, 1)

	for k, v in pairs(p2) do
		local v2, v3 = TrianglePart:Triangle(v[1] + p3, v[2] + p3, v[3] + p3)

		v2.Parent = game.Workspace.Terrain
		v2.Color = v1
		v3.Parent = game.Workspace.Terrain
		v3.Color = v1

		local unit = (v[1] - v[2]):Cross(v[1] - v[3]).unit
		local v4 = (v[1] + v[2] + v[3]) / 3
		local Part = Instance.new("Part")

		Part.Size = Vector3.new(0.1, 0.1, 2)
		Part.CFrame = CFrame.lookAt(v4 + unit, v4 + unit * 2)
		Part.Parent = game.Workspace.Terrain
		Part.CanCollide = false
		Part.Anchored = true
	end
end
function t.GetPlanesForPoints(p1, p2, p3) --[[ GetPlanesForPoints | Line: 178 | Upvalues: QuickHull2 (copy), IsUnique (copy) ]]
	local v1 = QuickHull2:GenerateHull(p2)
	local t = {}

	if v1 ~= nil then
		for k, v in pairs(v1) do
			local unit = (v[1] - v[2]):Cross(v[1] - v[3]).unit
			local v2 = v[1]:Dot(unit)

			p3 = p3 + 1

			if IsUnique(t, unit, v2) then
				table.insert(t, {
					n = unit,
					ed = v2,
					planeNum = p3
				})
			end
		end
	end

	return t, p3
end
function t.GetPlanePointForPoints(p1, p2) --[[ GetPlanePointForPoints | Line: 204 | Upvalues: QuickHull2 (copy), IsUniqueTri (copy) ]]
	local v1 = QuickHull2:GenerateHull(p2)
	local t = {}

	if v1 ~= nil then
		for k, v in pairs(v1) do
			local unit = (v[1] - v[2]):Cross(v[1] - v[3]).unit
			local v2 = v[1]:Dot(unit)

			if IsUniqueTri(t, unit, v2) then
				table.insert(t, {
					v[1],
					v[2],
					v[3],
					unit,
					v2
				})
			end
		end
	end

	return t
end
function t.PointInsideHull(p1, p2, p3) --[[ PointInsideHull | Line: 224 ]]
	for k, v in pairs(p2) do
		if p3:Dot(v.n) - v.ed > 0 then
			return true
		end
	end

	return false
end
function t.GeneratePointsForInstance(p1, p2, p3, p4) --[[ GeneratePointsForInstance | Line: 235 | Upvalues: t2 (copy), t3 (copy), t4 (copy) ]]
	local t = {}
	local v1 = t2

	if p2:IsA("Part") then
		v1 = t2
	elseif p2:IsA("WedgePart") then
		v1 = t3
	elseif p2:IsA("CornerWedgePart") then
		v1 = t4
	end

	for k, v in pairs(v1) do
		local v2 = p4 * CFrame.new(v * p2.Size)

		for k2, v3 in pairs(t2) do
			table.insert(t, (v2 + v3 * p3).Position)
		end
	end

	return t
end
function t.GetRaytraceInstancePoints(p1, p2, p3) --[[ GetRaytraceInstancePoints | Line: 263 | Upvalues: QuickHull2 (copy), IsUnique (copy) ]]
	-- structuring failed for function 12; please report this in our discord https://discord.gg/y63m4zUYa4
end
function t.GetPlanesForInstanceMeshPart(p1, p2, p3, p4, p5, p6) --[[ GetPlanesForInstanceMeshPart | Line: 413 | Upvalues: t2 (copy), QuickHull2 (copy), IsUnique (copy) ]]
	local t = {}

	for k, v in pairs((p1:GetRaytraceInstancePoints(p2, p4))) do
		for k2, v2 in pairs(t2) do
			table.insert(t, v + v2 * p3)
		end
	end

	local v2 = QuickHull2:GenerateHull(t)
	local t3 = {}

	if v2 == nil then
		return nil, p5
	end

	for k, v in pairs(v2) do
		local unit = (v[1] - v[2]):Cross(v[1] - v[3]).unit
		local v3 = v[1]:Dot(unit)

		p5 = p5 + 1

		if IsUnique(t3, unit, v3) then
			table.insert(t3, {
				n = unit,
				ed = v3,
				planeNum = p5
			})
		end
	end

	return t3, p5
end

return t