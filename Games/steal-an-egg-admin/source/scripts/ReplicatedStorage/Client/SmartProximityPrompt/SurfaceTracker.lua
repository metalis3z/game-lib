-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}

v1.__index = v1
v1.__class = "SurfaceTracker"

local function clampToBox(v2, v3) -- line 9
    local CFrame = v2.CFrame
    local v4 = v2.Size * 0.5
    return CFrame:PointToWorldSpace(CFrame:PointToObjectSpace(v3):Max(-v4):Min(v4))
end

function v1.new(v5, v6) -- line 16 | captures: v1
    local v7 = {}
    local v8 = setmetatable(v7, v1)
    v8.model = v5
    v8.skip = v6
    v8.solids = {}
    v8.links = {}
    v8.disposed = false
    v8:Rescan()

    local function onPartChurn(v9) -- line 24 | captures: v8
        if v9:IsA("BasePart") then
            v8:Rescan()
        end
    end

    local v11 = {}
    v11[1] = v5.DescendantAdded:Connect(onPartChurn)
    v11[2] = v5.DescendantRemoving:Connect(onPartChurn)
    v8.links = v11
    return v8
end

local function Destroy(v12) -- line 36
    if v12.disposed then
        return
    end
    v12.disposed = true
    for v13, v14 in v12.links do
        v14:Disconnect()
    end
    table.clear(v12.links)
    table.clear(v12.solids)
end

v1.Destroy = Destroy

local function Rescan(v15) -- line 49
    local solids = v15.solids
    table.clear(solids)
    for v16, v17 in v15.model:GetDescendants() do
        local BasePart = v17:IsA("BasePart")
        if BasePart then
            if v17 == v15.skip then
                BasePart = false
            else
                BasePart = v17.Parent ~= nil
            end
        end
        if BasePart then
            solids[#solids + 1] = v17
        end
    end
end

v1.Rescan = Rescan

local function GetClosestSurfacePoint(v18, v19, v20) -- line 64
    local v21
    local v22 = (1/0)
    for v23, v24 in v18.solids do
        local v25
        if v24.Parent then
            local CFrame = v24.CFrame
            local v26 = v24.Size * 0.5
            v25 = CFrame:PointToWorldSpace(CFrame:PointToObjectSpace(v19):Max(-v26):Min(v26))
        end
        local v27 = if v25 then (v19 - v25).Magnitude else (1/0)
        if v27 < v22 then
            v21 = v25
            v22 = v27
        end
    end
    local v28
    if v21 then
        v28 = v19 - v21
    else
        v28 = Vector3.new(0, 0, 0)
    end
    local v29
    if v28.Magnitude >= 0.0001 then
        v29 = v28.Unit
    else
        v29 = Vector3.new(0, 1, 0)
    end
    local v30 = if v21 then v21 + v29 * (v10 or 0) else nil
    return v30, v30 and v22
end

v1.GetClosestSurfacePoint = GetClosestSurfacePoint
return v1
