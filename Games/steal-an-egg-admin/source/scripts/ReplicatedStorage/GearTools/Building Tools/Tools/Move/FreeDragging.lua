-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local Workspace = game:GetService("Workspace")
local Core = require(Parent.Core)
local Selection = Core.Selection
local Security = Core.Security
local Snapping = require(Parent.Core.Snapping)
local BoundingBox = require(Parent.Core.BoundingBox)
local Libraries = Parent:WaitForChild("Libraries")
local v1 = require(Libraries:WaitForChild("SupportLibrary"))
local v2 = require(script.Parent:WaitForChild("Util"))
local v3 = {}

v3.__index = v3

function v3.new(v4) -- line 22 | captures: v3
    local v5 = {
        IsDragging = false,
        StartScreenPoint = nil,
        StartTarget = nil,
        CrossthroughCorrection = nil,
        LastSelection = nil,
        LastBasePartOffset = nil,
        Target = nil,
        TargetPoint = nil,
        TargetNormal = nil,
        LastTargetNormal = nil,
        CornerOffsets = nil,
        TriggerAlignment = nil,
        SurfaceAlignment = nil,
        LastSurfaceAlignment = nil,
        Tool = v4
    }
    setmetatable(v5, v3)
    v5:InstallDragEndListener()
    return v5
end

function v3.EnableDragging(v6) -- line 54 | captures: UserInputService, ContextActionService, Core, Selection, Snapping, BoundingBox
    local function HandleDragStart(v7, v8, v9) -- line 57 | captures: v6, UserInputService, ContextActionService, Core, Selection, Snapping, BoundingBox
        if v8.Name == "Begin" then
            local Target = Core.Mouse.Target
            local v10, v11
            if Target then
                if Selection.Multiselecting then
                    v11 = true
                else
                    v10 = UserInputService:IsKeyDown(Enum.KeyCode.R) and #Selection.Items > 0
                    v11 = false
                end
            else
                v11 = true
            end
            if v11 then
                return Enum.ContextActionResult.Pass
            end
            if Core.IsSelectable({ Target }) or v10 then
                v6.StartTarget = Target
                v6.StartScreenPoint = Vector2.new(Core.Mouse.X, Core.Mouse.Y)
                local v12, v13 = Core.Targeting:UpdateTarget()
                if not Selection.IsSelected(v13) and not v10 then
                    Core.Targeting.SelectTarget(true)
                    Core.Targeting.CancelSelecting()
                end

                local function HandlePotentialDragStart(v14, v15, v16) -- line 85 | captures: v6, ContextActionService, Core, Snapping, BoundingBox
                    if v15.Name == "Change" then
                        if (v6.StartScreenPoint and (Vector2.new(Core.Mouse.X, Core.Mouse.Y) - v6.StartScreenPoint).Magnitude) >= 2 then
                            BoundingBox.ClearBoundingBox()
                            local StartTarget = v6.StartTarget
                            local v17 = Snapping.Enabled and v6.Tool.SnappedPoint or nil
                            v6:SetUpDragging(StartTarget, v17)
                            ContextActionService:UnbindAction("BT: Watch for dragging")
                        end
                        if v16.UserInputType.Name == "Touch" then
                            return
                        end
                    end
                    return Enum.ContextActionResult.Pass
                end

                local MouseMovement = Enum.UserInputType.MouseMovement
                local Touch = Enum.UserInputType.Touch
                ContextActionService:BindAction("BT: Watch for dragging", HandlePotentialDragStart, false, MouseMovement, Touch)
                return
            end
        end
        return Enum.ContextActionResult.Pass
    end

    local MouseButton1 = Enum.UserInputType.MouseButton1
    local Touch = Enum.UserInputType.Touch
    ContextActionService:BindAction("BT: Start dragging", HandleDragStart, false, MouseButton1, Touch)
end

function v3.SetUpDragging(v18, v19, v20) -- line 125 | captures: Core
    Core.Targeting.CancelSelecting()
    local v21, v22 = v18.Tool:PrepareSelectionForDragging()
    v18.InitialPartStates = v21
    v18.InitialModelStates = v22
    v18:StartDragging(v19, v18.InitialPartStates, v18.InitialModelStates, v20)
end

function v3.StartDragging(v23, v24, v25, v26, v27) -- line 137 | captures: ContextActionService, Core, Selection, Security, Snapping, BoundingBox, v2
    local v28 = v24
    if v23.IsDragging then
        return
    end
    v23.IsDragging = true
    v23.Tool:TrackChange()
    BoundingBox.ClearBoundingBox()
    local v29
    if Core.Mode == "Tool" then
        v29 = Security.GetPermissions(Security.GetSelectionAreas(Selection.Parts), Core.Player)
    end
    local v30
    if v25[v24] then
        v30 = v24
    else
        v30 = next(v25)
        v28 = v30
        if not v30 then
            return
        end
    end
    local v31 = -v30.CFrame:pointToObjectSpace(Core.Mouse.Hit.p)
    local v32 = v2.GetIncrementMultiple(v31.X, v23.Tool.Increment)
    local v33 = -v30.Size.X / 2
    local v34 = v30.Size.X / 2
    local v35 = math.clamp(v32, v33, v34)
    local v36 = v2.GetIncrementMultiple(v31.Y, v23.Tool.Increment)
    local v37 = -v30.Size.Y / 2
    local v38 = v30.Size.Y / 2
    local v39 = math.clamp(v36, v37, v38)
    local v40 = v2.GetIncrementMultiple(v31.Z, v23.Tool.Increment)
    local v41 = -v30.Size.Z / 2
    local v42 = v30.Size.Z / 2
    local v43 = math.clamp(v40, v41, v42)
    local v44 = Vector3.new(v35, v39, v43)
    if v27 then
        v44 = -v30.CFrame:pointToObjectSpace(v27)
    end
    Snapping.TargetBlacklist = Selection.Items
    v23.Tool.Maid.DragSnapping = v23.Tool.PointSnapped:Connect(function(v45) -- line 185 | captures: v28, v29, v44, v23, v25, v26, Core, Selection, Security, v2
        local v46 = v23.SurfaceAlignment or v25[v28].CFrame - v25[v28].CFrame.p
        v28.CFrame = CFrame.new(v45) * v46 * CFrame.new(v44)
        v2.TranslatePartsRelativeToPart(v28, v25, v26)
        if Core.Mode == "Tool" and Security.ArePartsViolatingAreas(Selection.Parts, Core.Player, false, v29) then
            v28.CFrame = v25[v28].CFrame
            v2.TranslatePartsRelativeToPart(v28, v25, v26)
        end
    end)
    v23.CornerOffsets = GetCornerOffsets(v25[v28].CFrame, v25)

    function v23.TriggerAlignment() -- line 204 | captures: v28, v29, v44, v23, v25, v26, Snapping
        v23:DragToMouse(v28, v44, v25, v26, v29)
        if Snapping.Enabled then
            v23.Tool.PointSnapped:Fire(v23.Tool.SnappedPoint)
        end
    end

    local function HandleDragChange(v47, v48, v49) -- line 216 | captures: v28, v29, v44, v23, v25, v26
        if v48.Name == "Change" then
            v23:DragToMouse(v28, v44, v25, v26, v29)
        end
        return Enum.ContextActionResult.Pass
    end

    local MouseMovement = Enum.UserInputType.MouseMovement
    local Touch = Enum.UserInputType.Touch
    ContextActionService:BindAction("BT: Dragging", HandleDragChange, false, MouseMovement, Touch)
end

function v3.DragToMouse(v50, v51, v52, v53, v54, v55) -- line 231 | captures: Workspace, Core, Selection, Security, Snapping, v1, v2
    local v56 = v1.CloneTable(Selection.Items)
    local v57 = Core.Player and Core.Player.Character
    table.insert(v56, v57)
    local v58, v59, v60 = Workspace:FindPartOnRayWithIgnoreList(Ray.new(Core.Mouse.UnitRay.Origin, Core.Mouse.UnitRay.Direction * 5000), v56)
    v50.Target = v58
    v50.TargetPoint = v59
    v50.TargetNormal = v60
    if v50.LastTargetNormal ~= v50.TargetNormal then
        v50.SurfaceAlignment = nil
        v50.CrossthroughCorrection = nil
    end
    if not (v50.LastSelection == Selection.Items and v50.LastBasePartOffset == v52 and v50.LastSurfaceAlignment == v50.SurfaceAlignment) then
        v50.CrossthroughCorrection = nil
    end
    v50.LastSelection = Selection.Items
    v50.LastBasePartOffset = v52
    v50.LastSurfaceAlignment = v50.SurfaceAlignment
    v50.LastTargetNormal = v50.TargetNormal
    if Snapping.Enabled then
        return
    end
    v50.TargetPoint = v50:GetAlignedTargetPoint(v50.Target, v50.TargetPoint, v50.TargetNormal, v50.Tool.Increment)
    local v61 = v50.SurfaceAlignment or v53[v51].CFrame - v53[v51].CFrame.p
    local v62 = CFrame.new(v50.TargetPoint) * v61 * CFrame.new(v52)
    if not v50.CrossthroughCorrection then
        v50.CrossthroughCorrection = 0
        for v63, v64 in pairs(v50.CornerOffsets) do
            local v65 = v62 * v64
            local v66 = -(v50.TargetPoint - v65):Dot(v50.TargetNormal)
            if v66 < v50.CrossthroughCorrection then
                v50.CrossthroughCorrection = v66
            end
        end
    end
    v51.CFrame = v62 - v50.TargetNormal * v50.CrossthroughCorrection
    v2.TranslatePartsRelativeToPart(v51, v53, v54)
    if Core.Mode == "Tool" and Security.ArePartsViolatingAreas(Selection.Parts, Core.Player, false, v55) then
        v51.CFrame = v53[v51].CFrame
        v2.TranslatePartsRelativeToPart(v51, v53, v54)
    end
end

local function AlignSelectionToTarget(v67) -- line 329
    if v67.IsDragging and v67.TargetNormal then
        local v68 = CFrame.new(Vector3.new(), v67.TargetNormal)
        if v67.Target then
            local TargetNormal = v67.TargetNormal
            local Target = v67.Target
            local TargetNormal_2 = v67.TargetNormal
            local unit, unit_2
            if TargetNormal_2:isClose(Target.CFrame.lookVector, 0.000001) or TargetNormal_2:isClose(-Target.CFrame.lookVector, 0.000001) then
                unit = TargetNormal_2:Cross(Target.CFrame.rightVector).unit
                unit_2 = unit:Cross(TargetNormal_2).unit
            else
                unit_2 = Target.CFrame.lookVector:Cross(TargetNormal_2).unit
                unit = TargetNormal_2:Cross(unit_2).unit
            end
            v67.SurfaceAlignment = CFrame.new(0, 0, 0, unit_2.X, TargetNormal.X, -unit.X, unit_2.Y, TargetNormal.Y, -unit.Y, unit_2.Z, TargetNormal.Z, -unit.Z)
        else
            v67.SurfaceAlignment = v68 * CFrame.Angles(-1.5707963267948966, 0, 0)
        end
    else
        return
    end
    v67:TriggerAlignment()
end

v3.AlignSelectionToTarget = AlignSelectionToTarget

function v3.GetAlignedTargetPoint(v69, v70, v71, v72, v73) -- line 377 | captures: v2
    local function v74(v75, v76, ...)
        return (Vector3.new(v75, v76, ...))
    end

    local v77 = CFrame.new()
    local v78 = Vector3.new(1, 1, 1)
    if v70 and v70:IsA("BasePart") and v70.ClassName ~= "Terrain" then
        local v79 = v70.Size / 2
        local v80 = v70.CFrame - v70.CFrame.p
        local fromAxisAngle = CFrame.fromAxisAngle
        local v81 = Vector3.FromAxis(Enum.Axis.X)
        local v82 = v70.Size.Z / v70.Size.Y
        local v83 = v80 * fromAxisAngle(v81, (math.atan(v82)))
        local v84 = v70.CFrame - v70.CFrame.p
        local fromAxisAngle_2 = CFrame.fromAxisAngle
        local v85 = Vector3.FromAxis(Enum.Axis.X)
        local v86 = v70.Size.Z / v70.Size.Y
        local v87 = v84 * fromAxisAngle_2(v85, 3.141592653589793 - math.atan(v86))
        local v88 = v70.CFrame - v70.CFrame.p
        local fromAxisAngle_3 = CFrame.fromAxisAngle
        local v89 = Vector3.FromAxis(Enum.Axis.Z)
        local v90 = v70.Size.Y / v70.Size.X
        local v91 = v88 * fromAxisAngle_3(v89, (math.atan(v90))) * CFrame.fromAxisAngle(Vector3.FromAxis(Enum.Axis.X), 1.5707963267948966) * CFrame.fromAxisAngle(Vector3.FromAxis(Enum.Axis.Z), -1.5707963267948966)
        if v72:isClose(v70.CFrame.lookVector, 0.000001) then
            v77, v78 = v70.CFrame * CFrame.new(v79.X, v79.Y, -v79.Z), Vector3.new(1, 1, 0)
        elseif v72:isClose(-v70.CFrame.lookVector, 0.000001) then
            v77, v78 = v70.CFrame * CFrame.new(-v79.X, v79.Y, v79.Z), Vector3.new(1, 1, 0)
        elseif v72:isClose(-v70.CFrame.rightVector, 0.000001) then
            v77, v78 = v70.CFrame * CFrame.new(-v79.X, v79.Y, -v79.Z), Vector3.new(0, 1, 1)
        elseif v72:isClose(v70.CFrame.rightVector, 0.000001) then
            v77, v78 = v70.CFrame * CFrame.new(v79.X, v79.Y, v79.Z), Vector3.new(0, 1, 1)
        elseif v72:isClose(v70.CFrame.upVector, 0.000001) then
            v77, v78 = v70.CFrame * CFrame.new(v79.X, v79.Y, v79.Z), Vector3.new(1, 0, 1)
        elseif v72:isClose(-v70.CFrame.upVector, 0.000001) then
            v77, v78 = v70.CFrame * CFrame.new(v79.X, -v79.Y, -v79.Z), Vector3.new(1, 0, 1)
        elseif v72:isClose(v83.lookVector, 0.000001) then
            local v92 = v83 * CFrame.fromAxisAngle(Vector3.FromAxis(Enum.Axis.X), -1.5707963267948966)
            local CFrame_2 = v70.CFrame
            local X = v79.X
            local Y = v79.Y
            local Z = v79.Z
            v77, v78 = v92 + CFrame_2 * Vector3.new(X, Y, Z), Vector3.new(1, 0, 1)
        elseif v72:isClose(v87.lookVector, 0.000001) then
            local v93 = v87 * CFrame.fromAxisAngle(Vector3.FromAxis(Enum.Axis.X), -1.5707963267948966)
            local CFrame_2 = v70.CFrame
            local v94 = -v79.X
            local Y = v79.Y
            local v95 = -v79.Z
            v77, v78 = v93 + CFrame_2 * Vector3.new(v94, Y, v95), Vector3.new(1, 0, 1)
        elseif v72:isClose(v91.lookVector, 0.000001) then
            local v96 = v91 * CFrame.fromAxisAngle(Vector3.FromAxis(Enum.Axis.X), -1.5707963267948966)
            local CFrame_2 = v70.CFrame
            local X = v79.X
            local Y = v79.Y
            local v97 = -v79.Z
            v77, v78 = v96 + CFrame_2 * Vector3.new(X, Y, v97), Vector3.new(1, 0, 1)
        else
            return v71
        end
    end
    local v98 = v77:inverse() * CFrame.new(v71)
    return v77 * (v74(v2.GetIncrementMultiple(v98.X, v73), v2.GetIncrementMultiple(v98.Y, v73), v2.GetIncrementMultiple(v98.Z, v73)) * v78)
end

function v3.FinishDragging(v99) -- line 495 | captures: ContextActionService, Core, Snapping
    if not v99.IsDragging then
        return
    end
    v99.IsDragging = false
    v99.SurfaceAlignment = nil
    ContextActionService:UnbindAction("BT: Dragging")
    Snapping.StopTracking()
    v99.Tool.Maid.DragSnapping = nil
    for v100, v101 in pairs(v99.InitialPartStates) do
        v100:MakeJoints()
        Core.RestoreJoints(v101.Joints)
        v100.CanCollide = v101.CanCollide
        v100.Anchored = v101.Anchored
    end
    v99.Tool:RegisterChange()
end

local insert = table.insert
local new = Vector3.new

function GetCornerOffsets(v102, v103) -- line 533 | captures: insert, new
    local v104 = {}
    local v105 = v102:inverse()
    for v106, v107 in pairs(v103) do
        local CFrame = v107.CFrame
        local v108 = v106.Size.X / 2
        local v109 = v106.Size.Y / 2
        local v110 = v106.Size.Z / 2
        local v111 = v105 * (CFrame * new(v108, v109, v110))
        insert(v104, v111)
        local v112 = -v108
        local v113 = v105 * (CFrame * new(v112, v109, v110))
        insert(v104, v113)
        local v114 = -v109
        local v115 = v105 * (CFrame * new(v108, v114, v110))
        insert(v104, v115)
        local v116 = -v110
        local v117 = v105 * (CFrame * new(v108, v109, v116))
        insert(v104, v117)
        local v118 = -v108
        local v119 = -v110
        local v120 = v105 * (CFrame * new(v118, v109, v119))
        insert(v104, v120)
        local v121 = -v108
        local v122 = -v109
        local v123 = v105 * (CFrame * new(v121, v122, v110))
        insert(v104, v123)
        local v124 = -v109
        local v125 = -v110
        local v126 = v105 * (CFrame * new(v108, v124, v125))
        insert(v104, v126)
        local v127 = -v108
        local v128 = -v109
        local v129 = -v110
        local v130 = v105 * (CFrame * new(v127, v128, v129))
        insert(v104, v130)
    end
    return v104
end

function v3.InstallDragEndListener(v131) -- line 562 | captures: ContextActionService, v1
    v1.AddUserInputListener("Ended", { "Touch", "MouseButton1" }, true, function(v132) -- line 563 | captures: v131, ContextActionService
        v131.StartScreenPoint = nil
        v131.StartTarget = nil
        ContextActionService:UnbindAction("BT: Watch for dragging")
        if v131.IsDragging then
            v131.Tool:SetAxes(v131.Tool.Axes)
            v131:FinishDragging()
        end
    end)
end

return v3
