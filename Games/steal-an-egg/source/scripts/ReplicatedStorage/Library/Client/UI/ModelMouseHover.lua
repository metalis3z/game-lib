-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local CollisionGroups = require(ReplicatedStorage.Library.Types.CollisionGroups)
local v1 = RaycastParams.new()

v1.IgnoreWater = true
v1.CollisionGroup = CollisionGroups.PLAYER_COLLISION_GROUP

local t = {}

local function getRaycastHit(p1, p2) --[[ getRaycastHit | Line: 22 | Upvalues: v1 (copy) ]]
	local CurrentCamera = workspace.CurrentCamera

	if CurrentCamera == nil then
		return nil
	end

	local v12 = CurrentCamera:ViewportPointToRay(p1.X, p1.Y)
	local v2 = workspace:Raycast(v12.Origin, v12.Direction * p2, v1)

	if v2 == nil then
		return nil
	end

	return v2.Instance
end

function t.GetHoveredKey(p1, p2, p3) --[[ GetHoveredKey | Line: 37 | Upvalues: Asserts (copy), v1 (copy) ]]
	Asserts.table(p1)
	Asserts.Vector2(p2)
	Asserts.number(p3)
	assert(p3 > 0, "maxDistance must be greater than 0")

	local CurrentCamera = workspace.CurrentCamera
	local v2

	if CurrentCamera == nil then
		v2 = nil
	else
		local v3 = CurrentCamera:ViewportPointToRay(p2.X, p2.Y)
		local v4 = workspace:Raycast(v3.Origin, v3.Direction * p3, v1)

		v2 = if v4 == nil then nil else v4.Instance
	end

	if v2 == nil then
		return nil
	end

	for k, v in pairs(p1) do
		Asserts.string(k)
		Asserts.Model(v)

		if v.Parent ~= nil and v2:IsDescendantOf(v) then
			return k
		end
	end

	return nil
end

return t