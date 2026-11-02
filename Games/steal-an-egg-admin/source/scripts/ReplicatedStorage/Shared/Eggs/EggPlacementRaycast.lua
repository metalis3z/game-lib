-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Input = require(ReplicatedStorage.Packages.Input)
local PlacedEggRenderer = require(script.Parent.PlacedEggRenderer)
local t = require(ReplicatedStorage.Packages.t)
local v1 = Input.Mouse.new()
local v2 = {}

local function placementRaycastParams(v3, v4) -- line 12 | captures: PlacedEggRenderer
    local v5 = { v3 }
    PlacedEggRenderer.AppendRaycastTargets(v5, v4)
    local v6 = RaycastParams.new()
    v6.FilterType = Enum.RaycastFilterType.Include
    v6.FilterDescendantsInstances = v5
    v6.IgnoreWater = true
    return v6
end

function v2.Raycast(v7, v8) -- line 21 | captures: t, v1, placementRaycastParams
    t.strict(t.instanceIsA("BasePart"))(v7)
    t.strict(t.number)(v8)
    local v9 = placementRaycastParams(v7, v8)
    return v1:Raycast(v9, 500)
end

return v2
