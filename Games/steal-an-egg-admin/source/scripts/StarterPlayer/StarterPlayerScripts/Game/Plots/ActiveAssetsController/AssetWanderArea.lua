-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {
    HalfExtents = function(v2) -- HalfExtents | line 7
        local Size = v2.Size
        local v3 = Size.X * 0.5 - 1.75
        local v4 = math.max(v3, 0)
        local v5 = Size.Z * 0.5 - 1.75
        return v4, (math.max(v5, 0))
    end
}

function v1.ClampedPointToward(v6, v7) -- line 14 | captures: v1
    local v8, v9 = v1.HalfExtents(v6)
    local v10 = v6.CFrame:PointToObjectSpace(v7)
    local X = v10.X
    local v11 = -v8
    local v12 = math.clamp(X, v11, v8)
    local Z = v10.Z
    local v13 = -v9
    local v14 = math.clamp(Z, v13, v9)
    return (v6.CFrame * CFrame.new(v12, 0, v14)).Position
end

function v1.RandomPoint(v15, v16) -- line 22 | captures: v1
    local v17, v18 = v1.HalfExtents(v15)
    local v19 = v16:NextNumber(-v17, v17)
    local v20 = v16:NextNumber(-v18, v18)
    return (v15.CFrame * CFrame.new(v19, 0, v20)).Position
end

function v1.IsPositionInside(v21, v22) -- line 29 | captures: v1
    local v23, v24 = v1.HalfExtents(v21)
    local v25 = v21.CFrame:PointToObjectSpace(v22)
    local X = v25.X
    if math.abs(X) <= v23 then
        local Z = v25.Z
        return math.abs(Z) <= v24
    end
    return false
end

function v1.PointNearOwner(v26, v27, v28) -- line 36 | captures: v1
    return v1.ClampedPointToward(v26, v27 + v28)
end

return v1
