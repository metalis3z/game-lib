-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollisionGroups = require(ReplicatedStorage.Shared.Types.CollisionGroups)
local t = require(ReplicatedStorage.Packages.t)
local v1 = t.strict(t.table)
local v2 = t.strict(t.Vector2)
local v3 = t.strict(t.number)
local v4 = t.strict(t.string)
local v5 = t.strict(t.instanceIsA("Model"))
local v6 = RaycastParams.new()

v6.CollisionGroup = CollisionGroups.PLAYER_COLLISION_GROUP
v6.IgnoreWater = true

local v7 = {}

function v7.KeyUnderCursor(v8, v9, v10) -- line 18 | captures: v1, v2, v3, v4, v5, v6
    v1(v8)
    v2(v9)
    v3(v10)
    local v11 = v10 > 0
    assert(v11, "a hover probe with no reach can never touch anything")
    local CurrentCamera = workspace.CurrentCamera
    local v12 = CurrentCamera and CurrentCamera:ViewportPointToRay(v9.X, v9.Y)
    local v13 = v12 and workspace:Raycast(v12.Origin, v12.Direction * v10, v6)
    if v13 then
        for v14, v15 in pairs(v8) do
            v4(v14)
            v5(v15)
            if v15.Parent and v13.Instance:IsDescendantOf(v15) then
                return v14
            end
        end
    end
    return nil
end

return v7
