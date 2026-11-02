-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Input = require(ReplicatedStorage.Library.Modules.Packages.Input)
local PlacedEggRenderer = require(script.Parent.PlacedEggRenderer)
local v1 = Input.Mouse.new()
local t = {}

local function placementRaycastParams(p1, p2) --[[ placementRaycastParams | Line: 24 | Upvalues: PlacedEggRenderer (copy) ]]
	local t = { p1 }

	PlacedEggRenderer.AppendRaycastTargets(t, p2)

	local v1 = RaycastParams.new()

	v1.FilterType = Enum.RaycastFilterType.Include
	v1.FilterDescendantsInstances = t
	v1.IgnoreWater = true

	return v1
end

function t.Raycast(p1, p2) --[[ Raycast | Line: 39 | Upvalues: Asserts (copy), v1 (copy), placementRaycastParams (copy) ]]
	Asserts.BasePart(p1)
	Asserts.number(p2)

	return v1:Raycast(placementRaycastParams(p1, p2), 500)
end

return t