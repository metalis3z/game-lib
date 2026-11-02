-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = require(script.Parent)
local Support = Parent.Support
local v1 = {}
local v2 = {}
local v3 = {}
local v4 = {}
local v5 = true
local v6 = {}
local v7 = {}

function v1.StartBoundingBox(v8) -- line 16 | captures: v5, Parent, Support, v1
    if BoundingBoxEnabled then
        return
    end
    BoundingBoxEnabled = true
    BoundingBox = Parent.Make("Part")({
        Name = "BTBoundingBox",
        CanCollide = false,
        Transparency = 1,
        Anchored = true,
        Locked = true,
        Parent = Parent.UI
    })
    Parent.Mouse.TargetFilter = BoundingBox
    v5 = true
    StartAggregatingStaticParts()
    BoundingBoxHandleCallback = v8
    v1.UpdateBoundingBox()
    BoundingBoxUpdater = Support.ScheduleRecurringTask(v1.UpdateBoundingBox, 0.05)
    if BoundingBoxHandleCallback then
        BoundingBoxHandleCallback(BoundingBox)
    end
end

local function GetBoundingBox() -- line 58
    return BoundingBox
end

v1.GetBoundingBox = GetBoundingBox

function IsPhysicsStatic() -- line 66 | captures: Parent
    if _IsPhysicsStatic == nil then
        if Parent.Mode == "Plugin" then
            _IsPhysicsStatic = Workspace.DistributedGameTime == 0
        else
            _IsPhysicsStatic = false
        end
    end
    return _IsPhysicsStatic
end

function v1.UpdateBoundingBox() -- line 79 | captures: v2, v5, Parent, v1
    if not BoundingBoxEnabled then
        return
    end
    if not (InactiveBoundingBox and #Parent.Selection.Parts > 0) then
        if not (BoundingBox and #Parent.Selection.Parts == 0) then
            if #Parent.Selection.Parts == 0 then
                return
            end
        else
            InactiveBoundingBox = BoundingBox
            BoundingBox = nil
            BoundingBoxHandleCallback(BoundingBox)
            return
        end
    else
        BoundingBox = InactiveBoundingBox
        InactiveBoundingBox = nil
        BoundingBoxHandleCallback(BoundingBox)
    end
    if v5 then
        v1.StaticExtents = v1.CalculateExtents(v2, nil, true)
        v5 = false
    end
    local v9, v10 = v1.CalculateExtents(Parent.Selection.Parts, v1.StaticExtents)
    BoundingBox.Size = v9
    BoundingBox.CFrame = v10
end

local function ClearBoundingBox() -- line 118
    if not BoundingBoxEnabled then
        return
    end
    if BoundingBoxUpdater then
        BoundingBoxUpdater:Stop()
        BoundingBoxUpdater = nil
    end
    StopAggregatingStaticParts()
    if BoundingBox then
        BoundingBox:Destroy()
        BoundingBox = nil
    elseif InactiveBoundingBox then
        InactiveBoundingBox:Destroy()
        InactiveBoundingBox = nil
    end
    BoundingBoxEnabled = false
    BoundingBoxHandleCallback(nil)
    BoundingBoxHandleCallback = nil
end

v1.ClearBoundingBox = ClearBoundingBox

function AddStaticParts(v11) -- line 153 | captures: v2, v3, v5, Support
    for v12, v13 in pairs(v11) do
        if not v3[v13] and (IsPhysicsStatic() or v13.Anchored) then
            v3[v13] = true
            AddStaticPartMonitor(v13)
        end
    end
    v2 = Support.Keys(v3)
    v5 = true
end

function AddStaticPartMonitor(v14) -- line 180 | captures: v3, v5, v4
    if v3[v14] and not v4[v14] then
        local Changed = v14.Changed
        v4[v14] = Changed:Connect(function(v15) -- line 189 | captures: v14, v5
            if v15 ~= "CFrame" and v15 ~= "Size" then
                if v15 == "Anchored" and not IsPhysicsStatic() and not v14.Anchored then
                    RemoveStaticParts({ v14 })
                end
            else
                v5 = true
            end
        end)
    end
end

function RemoveStaticParts(v16) -- line 204 | captures: v2, v3, v5, Support, v4
    for v17, v18 in pairs(v16) do
        v3[v18] = nil
        if v4[v18] then
            v4[v18]:Disconnect()
            v4[v18] = nil
        end
    end
    v2 = Support.Keys(v3)
    v5 = true
end

function StartAggregatingStaticParts() -- line 229 | captures: Parent, v6, v7
    local function v19(v20, ...)
        table.insert(v20, ...)
    end

    local function v21(v22, ...)
        table.insert(v22, ...)
    end

    AddStaticParts(Parent.Selection.Parts)
    for v23, v24 in ipairs(Parent.Selection.Parts) do
        AddPotentialPartMonitor(v24)
    end
    v19(v6, Parent.Selection.PartsAdded:Connect(function(v25) -- line 241
        AddStaticParts(v25)
        for v26, v27 in pairs(v25) do
            AddPotentialPartMonitor(v27)
        end
    end))
    v21(v6, Parent.Selection.PartsRemoved:Connect(function(v28) -- line 254 | captures: v7
        RemoveStaticParts(v28)
        for v29, v30 in pairs(v28) do
            if v7[v30] then
                v7[v30]:Disconnect()
                v7[v30] = nil
            end
        end
    end))
end

function v1.RecalculateStaticExtents() -- line 266 | captures: v5
    v5 = true
end

function AddPotentialPartMonitor(v31) -- line 274 | captures: v7
    if not v7[v31] then
        local Changed = v31.Changed
        v7[v31] = Changed:Connect(function(v32) -- line 283 | captures: v31
            if v32 == "Anchored" and v31.Anchored then
                AddStaticParts({ v31 })
            end
        end)
    end
end

function v1.PauseMonitoring() -- line 291 | captures: v4, v7
    for v33, v34 in pairs(v7) do
        v34:Disconnect()
        v7[v33] = nil
    end
    for v35, v36 in pairs(v4) do
        v36:Disconnect()
        v4[v35] = nil
    end
    if BoundingBoxUpdater then
        BoundingBoxUpdater:Stop()
        BoundingBoxUpdater = nil
    end
end

function v1.ResumeMonitoring() -- line 314 | captures: v3, Parent, Support, v1
    if not BoundingBoxEnabled then
        return
    end
    for v37 in pairs(v3) do
        AddStaticPartMonitor(v37)
    end
    for v38, v39 in ipairs(Parent.Selection.Parts) do
        AddPotentialPartMonitor(v39)
    end
    if not BoundingBoxUpdater then
        BoundingBoxUpdater = Support.ScheduleRecurringTask(v1.UpdateBoundingBox, 0.05)
    end
end

function StopAggregatingStaticParts() -- line 339 | captures: v2, v3, v1, v4, v6, v7
    for v40, v41 in pairs(v6) do
        v41:Disconnect()
        v6[v40] = nil
    end
    for v42, v43 in pairs(v4) do
        v43:Disconnect()
        v4[v42] = nil
    end
    for v44, v45 in pairs(v7) do
        v45:Disconnect()
        v7[v44] = nil
    end
    v2 = {}
    v3 = {}
    v1.StaticExtents = nil
end

local new = CFrame.new
local insert = table.insert
local toWorldSpace = CFrame.new().toWorldSpace
local min = math.min
local max = math.max
local unpack_2 = unpack

function v1.CalculateExtents(v46, v47, v48) -- line 375 | captures: new, insert, min, max, unpack_2
    if #v46 == 0 then
        return
    end
    local Min, Max
    if v47 then
        Min = v47.Min or v46[1].Position
        Max = v47.Max or v46[1].Position
    else
        Min = v46[1].Position
        Max = v46[1].Position
    end
    local v49, v50, v51, v52, v53, v54 = Min.X, Min.Y, Min.Z, Max.X, Max.Y, Max.Z
    for v55, v56 in pairs(v46) do
        local v57 = IsPhysicsStatic()
        local Anchored = if not v57 then v56.Anchored else nil
        if v57 and not v47 or not v57 and not Anchored or not (v57 or v47) then
            local CFrame = v56.CFrame
            local v58 = v56.Size / 2
            local X = v58.X
            local Y = v58.Y
            local Z = v58.Z
            local v59 = {}
            local v60 = {}
            local v61 = {}
            local v62 = CFrame * new(X, Y, Z)
            local x = v62.x
            insert(v59, x)
            local y = v62.y
            insert(v60, y)
            local z = v62.z
            insert(v61, z)
            local v63 = CFrame * new(-X, Y, Z)
            local x_2 = v63.x
            insert(v59, x_2)
            local y_2 = v63.y
            insert(v60, y_2)
            local z_2 = v63.z
            insert(v61, z_2)
            local v64 = CFrame * new(X, -Y, Z)
            local x_3 = v64.x
            insert(v59, x_3)
            local y_3 = v64.y
            insert(v60, y_3)
            local z_3 = v64.z
            insert(v61, z_3)
            local v65 = CFrame * new(X, Y, -Z)
            local x_4 = v65.x
            insert(v59, x_4)
            local y_4 = v65.y
            insert(v60, y_4)
            local z_4 = v65.z
            insert(v61, z_4)
            local v66 = CFrame * new(-X, Y, -Z)
            local x_5 = v66.x
            insert(v59, x_5)
            local y_5 = v66.y
            insert(v60, y_5)
            local z_5 = v66.z
            insert(v61, z_5)
            local v67 = CFrame * new(-X, -Y, Z)
            local x_6 = v67.x
            insert(v59, x_6)
            local y_6 = v67.y
            insert(v60, y_6)
            local z_6 = v67.z
            insert(v61, z_6)
            local v68 = CFrame * new(X, -Y, -Z)
            local x_7 = v68.x
            insert(v59, x_7)
            local y_7 = v68.y
            insert(v60, y_7)
            local z_7 = v68.z
            insert(v61, z_7)
            local v69 = CFrame * new(-X, -Y, -Z)
            local x_8 = v69.x
            insert(v59, x_8)
            local y_8 = v69.y
            insert(v60, y_8)
            local z_8 = v69.z
            insert(v61, z_8)
            v49 = min(v49, unpack_2(v59))
            v50 = min(v50, unpack_2(v60))
            v51 = min(v51, unpack_2(v61))
            v52 = max(v52, unpack_2(v59))
            v53 = max(v53, unpack_2(v60))
            v54 = max(v54, unpack_2(v61))
        end
    end
    local v70 = {
        Min = Vector3.new(v49, v50, v51),
        Max = Vector3.new(v52, v53, v54)
    }
    if v48 then
        return v70
    end
    local v71 = v52 - v49
    local v72 = v53 - v50
    local v73 = v54 - v51
    return Vector3.new(v71, v72, v73), (CFrame.new(v49 + (v52 - v49) / 2, v50 + (v53 - v50) / 2, v51 + (v54 - v51) / 2))
end

return v1
