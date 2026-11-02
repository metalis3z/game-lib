-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local v1 = {}
local v2 = {}

local function cframeInFrontOfRootClampedToArea(v3, v4) -- line 10
    local LookVector = v3.LookVector
    local X = LookVector.X
    local Z = LookVector.Z
    local v5 = Vector3.new(X, 0, Z)
    local v6 = v5.Magnitude > 0
    assert(v6, "Asset front placement requires a horizontal root facing direction")
    local Unit = v5.Unit
    local Size = v4.Size
    local v7 = Size.X * 0.5 - 1.75
    local v8 = math.max(v7, 0)
    local v9 = Size.Z * 0.5 - 1.75
    local v10 = math.max(v9, 0)
    local v11 = v4.CFrame:PointToObjectSpace(v3.Position + Unit * 6)
    local X_2 = v11.X
    local v12 = -v8
    local v13 = math.clamp(X_2, v12, v8)
    local Z_2 = v11.Z
    local v14 = -v10
    local v15 = math.clamp(Z_2, v14, v10)
    local v16 = Vector3.new(v13, 0, v15)
    local Position = (v4.CFrame * CFrame.new(v16)).Position
    return CFrame.lookAt(Position, Position + Unit)
end

function v2.SetFrontPlacement(v17, v18) -- line 25 | captures: t, v1
    t.strict(t.string)(v17)
    t.strict(t.CFrame)(v18)
    v1[v17] = {
        RootCFrame = v18,
        ExpiresAt = os.clock() + 10
    }
end

function v2.ConsumeFrontPlacement(v19, v20) -- line 32 | captures: t, v1, cframeInFrontOfRootClampedToArea
    t.strict(t.string)(v19)
    t.strict(t.instanceIsA("BasePart"))(v20)
    local v21 = v1[v19]
    v1[v19] = nil
    if v21 == nil or v21.ExpiresAt < os.clock() then
        return nil
    end
    return cframeInFrontOfRootClampedToArea(v21.RootCFrame, v20)
end

function v2.ClearFrontPlacement(v22) -- line 44 | captures: t, v1
    t.strict(t.string)(v22)
    v1[v22] = nil
end

return v2
