-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Directory.Assets.Types.Personality)

local AssetWanderArea = require(script.Parent.AssetWanderArea)
local v1 = table.freeze({
	0,
	0.6108652381980153,
	-0.6108652381980153,
	1.2217304763960306,
	-1.2217304763960306,
	1.8325957145940461,
	-1.8325957145940461,
	2.443460952792061,
	-2.443460952792061,
	math.pi
})
local t = {}

local function rotateLocalFlatDirection(p1, p2) --[[ rotateLocalFlatDirection | Line: 35 ]]
	local v1 = math.cos(p2)
	local v2 = math.sin(p2)

	return Vector3.new(p1.X * v1 - p1.Z * v2, 0, p1.X * v2 + p1.Z * v1)
end

local function distanceToAreaEdge(p1, p2, p3) --[[ distanceToAreaEdge | Line: 41 | Upvalues: AssetWanderArea (copy) ]]
	local v1, v2 = AssetWanderArea.HalfExtents(p1)
	local v3 = (1 / 0)
	local v4 = (1 / 0)

	if p3.X > 0 then
		v3 = (v1 - p2.X) / p3.X
	elseif p3.X < 0 then
		v3 = (-v1 - p2.X) / p3.X
	end

	if p3.Z > 0 then
		v4 = (v2 - p2.Z) / p3.Z
	elseif p3.Z < 0 then
		v4 = (-v2 - p2.Z) / p3.Z
	end

	return math.max(math.min(v3, v4) - 2, 0)
end

local function ownerAwayDirection(p1, p2, p3) --[[ ownerAwayDirection | Line: 60 ]]
	local v3 = Vector3.new(p3.X - p2.X, 0, p3.Z - p2.Z)

	if v3.Magnitude > 0 then
		return v3.Unit
	end

	local v6 = Vector3.new(p3.X - p1.Position.X, 0, p3.Z - p1.Position.Z)

	if v6.Magnitude > 0 then
		return v6.Unit
	end

	local LookVector = p1.CFrame.LookVector
	local v7 = Vector3.new(LookVector.X, 0, LookVector.Z)

	assert(v7.Magnitude > 0, "Asset area must provide a horizontal retreat direction")

	return v7.Unit
end

function t.Destination(p1, p2, p3, p4, p5) --[[ Destination | Line: 81 | Upvalues: ownerAwayDirection (copy), v1 (copy), distanceToAreaEdge (copy), AssetWanderArea (copy) ]]
	local v12 = p1.CFrame:PointToObjectSpace(p5)
	local v3 = p1.CFrame:VectorToObjectSpace((ownerAwayDirection(p1, p4, p5)))
	local v4 = Vector3.new(v3.X, 0, v3.Z)

	assert(if v4.Magnitude > 0 then true else false, "Retreat direction must be horizontal")

	local Unit = v4.Unit
	local v6, v7, v8 = (-1 / 0), 0, Unit

	for i, v in ipairs(v1) do
		local v9 = math.cos(v)
		local v10 = math.sin(v)
		local Unit2 = Vector3.new(Unit.X * v9 - Unit.Z * v10, 0, Unit.X * v10 + Unit.Z * v9).Unit
		local v13 = distanceToAreaEdge(p1, v12, Unit2)
		local v15 = v13 * (math.max(Unit2:Dot(Unit), 0) + 0.6)

		if v6 < v15 then
			v6 = v15
			v7 = v13
			v8 = Unit2
		end
	end

	if v7 <= 0 then
		return AssetWanderArea.RandomPoint(p1, p2)
	end

	local v17 = v12 + v8 * (if p3.MaxTravelDistance == nil then v7 else math.min(p3.MaxTravelDistance, v7))

	return (p1.CFrame * CFrame.new(v17.X, 0, v17.Z)).Position
end

return t