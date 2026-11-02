-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

Core = require(script.Parent)
Support = Core.Support
SnapTracking = {}
SnapTracking.Enabled = false
SnapTracking.TrackCorners = true
SnapTracking.TrackFaceCentroids = true
SnapTracking.TrackEdgeMidpoints = true

local function StartTracking(v1) -- line 11
    if SnapTracking.Enabled then
        SnapTracking.StopTracking()
    end
    SnapTracking.Enabled = true
    Core.Targeting.CancelSelecting()
    SnapTracking.StartUI()
    SnapTracking.SetCallback(v1)

    function UpdateTrackingTarget(v2) -- line 32
        local ConcatTable = Support.ConcatTable
        local v3 = {}
        v3[1] = Player and Player.Character
        local v4 = ConcatTable(v3, SnapTracking.TargetBlacklist or {})
        local v5 = Workspace.CurrentCamera:ScreenPointToRay(v2.Position.X, v2.Position.Y)
        local v6, v7 = Workspace:FindPartOnRayWithIgnoreList(Ray.new(v5.Origin, v5.Direction * 5000), v4)
        if v6 and (not SnapTracking.TargetFilter or SnapTracking.TargetFilter(v6)) then
            SnapTracking.MousePoint = v7
            SnapTracking.SetTrackingTarget(v6)
        end
    end

    if SnapTracking.CustomMouseTracking then
        return
    end
    SnapTracking.MouseTracking = Support.AddUserInputListener("Changed", "MouseMovement", false, UpdateTrackingTarget)
    UpdateTrackingTarget({ Position = Vector2.new(Core.Mouse.X, Core.Mouse.Y) })
    SnapTracking.Update()
end

SnapTracking.StartTracking = StartTracking

local function SetCallback(v8) -- line 72
    SnapTracking.Callback = v8
end

SnapTracking.SetCallback = SetCallback

local function StartUI() -- line 77
    SnapTracking.PointMarker = Core.Tool.Interfaces.PointMarker:Clone()
    SnapTracking.PointMarker.Parent = Core.UI
end

SnapTracking.StartUI = StartUI

local function ClearUI() -- line 83
    if SnapTracking.Enabled then
        SnapTracking.PointMarker:Destroy()
        SnapTracking.PointMarker = nil
    end
end

SnapTracking.ClearUI = ClearUI

local function Update() -- line 97
    if not SnapTracking.Enabled then
        return
    end
    local v9 = SnapTracking.GetClosestPoint()
    SnapTracking.Callback(v9)
    SnapTracking.UpdateUI(v9)
end

SnapTracking.Update = Update

local function UpdateUI(v10) -- line 116
    if SnapTracking.Enabled and SnapTracking.PointMarker then
        if v10 then
            local v11, v12 = Workspace.CurrentCamera:WorldToScreenPoint(v10.p)
            SnapTracking.PointMarker.Visible = v12
            SnapTracking.PointMarker.Position = UDim2.new(0, v11.X, 0, v11.Y)
        else
            SnapTracking.PointMarker.Visible = false
        end
    end
end

SnapTracking.UpdateUI = UpdateUI

local function SetTrackingTarget(v13) -- line 139
    SnapTracking.Target = v13
    SnapTracking.Update()
end

SnapTracking.SetTrackingTarget = SetTrackingTarget

local function GetClosestPoint() -- line 145
    local v14, v15, CFrame_2, X, Y, Z
    if SnapTracking.Target and SnapTracking.MousePoint then
        v14 = {}
        v15 = {}
        CFrame_2 = SnapTracking.Target.CFrame
        local v16 = SnapTracking.Target.Size / 2
        X = v16.X
        Y = v16.Y
        Z = v16.Z
        if SnapTracking.TrackCorners then
            local v17 = CFrame_2 * CFrame.new(X, Y, Z)
            table.insert(v14, v17)
            local v18 = CFrame_2 * CFrame.new(-X, Y, Z)
            table.insert(v14, v18)
            local v19 = CFrame_2 * CFrame.new(X, -Y, Z)
            table.insert(v14, v19)
            local v20 = CFrame_2 * CFrame.new(X, Y, -Z)
            table.insert(v14, v20)
            local v21 = CFrame_2 * CFrame.new(-X, Y, -Z)
            table.insert(v14, v21)
            local v22 = CFrame_2 * CFrame.new(-X, -Y, Z)
            table.insert(v14, v22)
            local v23 = CFrame_2 * CFrame.new(X, -Y, -Z)
            table.insert(v14, v23)
            local v24 = CFrame_2 * CFrame.new(-X, -Y, -Z)
            table.insert(v14, v24)
        end
    else
        return nil
    end
    if SnapTracking.TrackEdgeMidpoints then
        local v25 = CFrame_2 * CFrame.new(X, Y, 0)
        table.insert(v14, v25)
        local v26 = CFrame_2 * CFrame.new(X, 0, Z)
        table.insert(v14, v26)
        local v27 = CFrame_2 * CFrame.new(0, Y, Z)
        table.insert(v14, v27)
        local v28 = CFrame_2 * CFrame.new(-X, Y, 0)
        table.insert(v14, v28)
        local v29 = CFrame_2 * CFrame.new(-X, 0, Z)
        table.insert(v14, v29)
        local v30 = CFrame_2 * CFrame.new(0, -Y, Z)
        table.insert(v14, v30)
        local v31 = CFrame_2 * CFrame.new(X, -Y, 0)
        table.insert(v14, v31)
        local v32 = CFrame_2 * CFrame.new(X, 0, -Z)
        table.insert(v14, v32)
        local v33 = CFrame_2 * CFrame.new(0, Y, -Z)
        table.insert(v14, v33)
        local v34 = CFrame_2 * CFrame.new(-X, -Y, 0)
        table.insert(v14, v34)
        local v35 = CFrame_2 * CFrame.new(-X, 0, -Z)
        table.insert(v14, v35)
        local v36 = CFrame_2 * CFrame.new(0, -Y, -Z)
        table.insert(v14, v36)
    end
    if SnapTracking.TrackFaceCentroids then
        local v37 = CFrame_2 * CFrame.new(X, 0, 0)
        table.insert(v14, v37)
        local v38 = CFrame_2 * CFrame.new(0, 0, Z)
        table.insert(v14, v38)
        local v39 = CFrame_2 * CFrame.new(0, Y, 0)
        table.insert(v14, v39)
        local v40 = CFrame_2 * CFrame.new(-X, 0, 0)
        table.insert(v14, v40)
        local v41 = CFrame_2 * CFrame.new(0, -Y, 0)
        table.insert(v14, v41)
        local v42 = CFrame_2 * CFrame.new(0, 0, -Z)
        table.insert(v14, v42)
    end
    for v43, v44 in ipairs(v14) do
        v15[v43] = (SnapTracking.MousePoint - v44.p).magnitude
    end
    local v45 = 1
    for v46, v47 in pairs(v15) do
        if v47 < v15[v45] then
            v45 = v46
        end
    end
    return v14[v45]
end

SnapTracking.GetClosestPoint = GetClosestPoint

local function StopTracking() -- line 212
    SnapTracking.Target = nil
    SnapTracking.Callback = nil
    SnapTracking.TrackFaceCentroids = true
    SnapTracking.TrackEdgeMidpoints = true
    SnapTracking.TrackCorners = true
    SnapTracking.TargetFilter = nil
    SnapTracking.TargetBlacklist = {}
    if not SnapTracking.Enabled then
        return
    end
    SnapTracking.MouseTracking:Disconnect()
    SnapTracking.MouseTracking = nil
    SnapTracking.ClearUI()
    SnapTracking.Enabled = false
end

SnapTracking.StopTracking = StopTracking
return SnapTracking
