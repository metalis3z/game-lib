-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent
local Core = require(Parent.Core)
local Snapping = require(Parent.Core.Snapping)
local BoundingBox = require(Parent.Core.BoundingBox)
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local Libraries = Parent:WaitForChild("Libraries")
local v1 = require(Libraries:WaitForChild("Signal"))
local v2 = require(Libraries:WaitForChild("Maid"))
local Selection = Core.Selection
local Support = Core.Support
local Security = Core.Security
local v3 = {
    Name = "Move Tool",
    Increment = 1,
    Axes = "Global",
    InitialState = nil,
    InitialFocusCFrame = nil,
    InitialExtentsSize = nil,
    InitialExtentsCFrame = nil,
    SnappedPoint = nil,
    Color = BrickColor.new("Deep orange"),
    PointSnapped = v1.new(),
    Maid = v2.new(),
    DragChanged = v1.new(),
    AxesChanged = v1.new()
}

v3.ManualText = "<font face=\"GothamBlack\" size=\"16\">Move Tool  \240\159\155\160</font>\nAllows you to move parts.<font size=\"12\"><br /></font>\n<font size=\"12\" color=\"rgb(150, 150, 150)\"><b>Axes</b></font>\nThis option lets you choose in which direction to move each part.<font size=\"6\"><br /></font>\n <font color=\"rgb(150, 150, 150)\">\226\128\162</font>  <b>GLOBAL</b> <font color=\"rgb(150, 150, 150)\">\226\128\148</font> Relative to the <b>world</b>\n <font color=\"rgb(150, 150, 150)\">\226\128\162</font>  <b>LOCAL</b> <font color=\"rgb(150, 150, 150)\">\226\128\148</font> Relative to each <b>individual part</b>\n <font color=\"rgb(150, 150, 150)\">\226\128\162</font>  <b>LAST</b> <font color=\"rgb(150, 150, 150)\">\226\128\148</font> Relative to the <b>last part clicked</b><font size=\"6\"><br /></font>\n\n<b>TIP:</b> Click on any part to focus the handles on it.<font size=\"6\"><br /></font>\n<b>TIP: </b>Hit the <b>Enter</b> key to switch between Axes modes quickly.<font size=\"12\"><br /></font>\n\n<font size=\"12\" color=\"rgb(150, 150, 150)\"><b>Increment</b></font>\nLets you choose how many studs to move parts by.<font size=\"6\"><br /></font>\n\n<b>TIP: </b>Hit the \226\128\147 key to quickly type increments.<font size=\"6\"><br /></font>\n\n<b>TIP: </b>Use your number pad to move exactly by the current increment. Holding <b>Shift</b> reverses the increment.<font size=\"4\"><br /></font>\n   <font color=\"rgb(150, 150, 150)\">\226\128\162</font>  8 & 2 \226\128\148 up & down\n   <font color=\"rgb(150, 150, 150)\">\226\128\162</font>  1 & 9 \226\128\148 back & forth\n   <font color=\"rgb(150, 150, 150)\">\226\128\162</font>  4 & 6 \226\128\148 left & right<font size=\"12\"><br /></font>\n\n<font size=\"12\" color=\"rgb(150, 150, 150)\"><b>Snapping</b></font>\nYou can place parts perfectly together by holding the <b><i>R</i></b> key, and dragging parts by their <b>snap points</b>.<font size=\"12\"><br /></font>\n\n<font size=\"12\" color=\"rgb(150, 150, 150)\"><b>Alignment</b></font>\nPress <b><i>T</i></b> while dragging to <b>align</b> the bottom surface of your base part to the current target surface.\n"
v3.HandleDragging = require(script:WaitForChild("HandleDragging")).new(v3)
v3.FreeDragging = require(script:WaitForChild("FreeDragging")).new(v3)
v3.UIController = require(script:WaitForChild("UIController")).new(v3)

function v3.Equip(v4) -- line 83
    v4:SetAxes(v4.Axes)
    v4.UIController:ShowUI()
    v4:BindShortcutKeys()
    v4.FreeDragging:EnableDragging()
end

function v3.Unequip(v5) -- line 96 | captures: Snapping, BoundingBox, ContextActionService
    if v5.FreeDragging.IsDragging then
        v5.FreeDragging:FinishDragging()
    end
    ContextActionService:UnbindAction("BT: Start dragging")
    v5.UIController:HideUI()
    v5.HandleDragging:HideHandles()
    v5.Maid:Destroy()
    BoundingBox.ClearBoundingBox()
    Snapping.StopTracking()
end

function v3.SetAxes(v6, v7) -- line 116 | captures: BoundingBox, Selection
    v6.Axes = v7
    v6.AxesChanged:Fire(v6.Axes)
    BoundingBox.ClearBoundingBox()
    if v7 == "Global" then
        BoundingBox.StartBoundingBox(function(v8) -- line 128 | captures: v6
            v6.HandleDragging:AttachHandles(v8)
        end)
    elseif v7 == "Local" or v7 == "Last" then
        v6.HandleDragging:AttachHandles(Selection.Focus, true)
    end
end

function v3.MovePartsAlongAxesByFace(v9, v10, v11, v12, v13, v14) -- line 144
    local v15 = Vector3.FromNormalId(v10) * v11
    if v9.Axes == "Global" then
        for v16, v17 in pairs(v12) do
            v16.CFrame = v17.CFrame + v15
        end
        for v18, v19 in pairs(v13) do
            v18.WorldPivot = v19.Pivot + v15
        end
    elseif v9.Axes == "Local" then
        for v20, v21 in pairs(v12) do
            v20.CFrame = v21.CFrame * CFrame.new(v15)
        end
    elseif v9.Axes == "Last" then
        local v22 = v14 * CFrame.new(v15)
        for v23, v24 in pairs(v12) do
            v23.CFrame = v22 * v14:toObjectSpace(v24.CFrame)
        end
        for v25, v26 in pairs(v13) do
            v25.WorldPivot = v22 * v14:ToObjectSpace(v26.Pivot)
        end
    end
end

function v3.BindShortcutKeys(v27) -- line 187 | captures: Snapping, UserInputService, Selection
    v27.Maid.HotkeyStart = UserInputService.InputBegan:Connect(function(v28, v29) -- line 191 | captures: v27, UserInputService, Selection
        if not v29 and v28.UserInputType == Enum.UserInputType.Keyboard and not UserInputService:GetFocusedTextBox() then
            if v28.KeyCode == Enum.KeyCode.Return or v28.KeyCode == Enum.KeyCode.KeypadEnter then
                if v27.Axes == "Global" then
                    v27:SetAxes("Local")
                elseif v27.Axes == "Local" then
                    v27:SetAxes("Last")
                elseif v27.Axes == "Last" then
                    v27:SetAxes("Global")
                end
            elseif v28.KeyCode ~= Enum.KeyCode.R or Selection.Multiselecting then
                if v28.KeyCode == Enum.KeyCode.KeypadEight then
                    v27:NudgeSelectionByFace(Enum.NormalId.Top)
                    return
                end
                if v28.KeyCode == Enum.KeyCode.KeypadTwo then
                    v27:NudgeSelectionByFace(Enum.NormalId.Bottom)
                    return
                end
                if v28.KeyCode == Enum.KeyCode.KeypadNine then
                    v27:NudgeSelectionByFace(Enum.NormalId.Front)
                elseif v28.KeyCode == Enum.KeyCode.KeypadOne then
                    v27:NudgeSelectionByFace(Enum.NormalId.Back)
                elseif v28.KeyCode == Enum.KeyCode.KeypadFour then
                    v27:NudgeSelectionByFace(Enum.NormalId.Left)
                elseif v28.KeyCode == Enum.KeyCode.KeypadSix then
                    v27:NudgeSelectionByFace(Enum.NormalId.Right)
                elseif v28.KeyCode == Enum.KeyCode.T and not Selection.Multiselecting then
                    v27.FreeDragging:AlignSelectionToTarget()
                end
            else
                v27:StartSnapping()
            end
        end
    end)
    v27.Maid.HotkeyRelease = UserInputService.InputEnded:Connect(function(v30, v31) -- line 255 | captures: v27, Snapping, UserInputService
        if not v31 and v30.UserInputType == Enum.UserInputType.Keyboard then
            if v30.KeyCode == Enum.KeyCode.R then
                if not UserInputService:GetFocusedTextBox() then
                    if not v27.FreeDragging.IsDragging then
                        v27:SetAxes(v27.Axes)
                    end
                    Snapping.StopTracking()
                end
            elseif v30.KeyCode.Name == "Minus" or v30.KeyCode.Name == "KeypadMinus" then
                v27.UIController:FocusIncrementInput()
            end
        end
    end)
end

function v3.StartSnapping(v32) -- line 289 | captures: Snapping, BoundingBox, Selection
    v32.HandleDragging:AttachHandles(nil, true)
    BoundingBox.ClearBoundingBox()
    if v32.FreeDragging.IsDragging then
        Snapping.TargetBlacklist = Selection.Items
    end
    Snapping.StartTracking(function(v33) -- line 302 | captures: v32
        if v33 then
            v32.SnappedPoint = v33.p
            v32.PointSnapped:Fire(v32.SnappedPoint)
        end
    end)
end

function v3.SetAxisPosition(v34, v35, v36) -- line 314 | captures: Core, Selection, Security
    v34:TrackChange()
    local v37 = v34:PrepareSelectionForDragging()
    for v38 in pairs(v37) do
        local new = CFrame.new
        local v39 = if v35 == "X" and v36 then v36 else v38.Position.X
        local v40 = if v35 == "Y" and v36 then v36 else v38.Position.Y
        local v41 = if v35 == "Z" and v36 then v36 else v38.Position.Z
        v38.CFrame = new(v39, v40, v41) * (v38.CFrame - v38.CFrame.p)
    end
    local v42 = Security.GetPermissions(Security.GetSelectionAreas(Selection.Parts), Core.Player)
    if Core.Mode == "Tool" and Security.ArePartsViolatingAreas(Selection.Parts, Core.Player, false, v42) then
        for v43, v44 in pairs(v37) do
            v43.CFrame = v44.CFrame
        end
    end
    for v45, v46 in pairs(v37) do
        v45:MakeJoints()
        Core.RestoreJoints(v46.Joints)
        v45.CanCollide = v46.CanCollide
        v45.Anchored = v46.Anchored
    end
    v34:RegisterChange()
end

function v3.NudgeSelectionByFace(v47, v48) -- line 358 | captures: Core, UserInputService, Selection, Support, Security
    local Increment = v47.Increment
    local v49 = Support.FlipTable(Support.GetListMembers(UserInputService:GetKeysPressed(), "KeyCode"))
    if v49[Enum.KeyCode.LeftShift] or v49[Enum.KeyCode.RightShift] then
        Increment = -Increment
    end
    v47:TrackChange()
    local v50, v51, v52 = v47:PrepareSelectionForDragging()
    v47:MovePartsAlongAxesByFace(v48, Increment, v50, v51, v52)
    v47.DragChanged:Fire(Increment)
    local v53 = Security.GetPermissions(Security.GetSelectionAreas(Selection.Parts), Core.Player)
    if Core.Mode == "Tool" and Security.ArePartsViolatingAreas(Selection.Parts, Core.Player, false, v53) then
        for v54, v55 in pairs(v50) do
            v54.CFrame = v55.CFrame
        end
    end
    for v56, v57 in pairs(v50) do
        v56:MakeJoints()
        Core.RestoreJoints(v57.Joints)
        v56.CanCollide = v57.CanCollide
        v56.Anchored = v57.Anchored
    end
    v47:RegisterChange()
end

function v3.TrackChange(v58) -- line 405 | captures: Core, Selection, Support
    v58.HistoryRecord = {
        Parts = Support.CloneTable(Selection.Parts),
        Models = Support.CloneTable(Selection.Models),
        BeforeCFrame = {},
        AfterCFrame = {},
        Selection = Selection.Items,
        Unapply = function(v59) -- Unapply | line 415 | captures: Core, Selection
            Selection.Replace(v59.Selection)
            local v60 = {}
            for v61, v62 in ipairs(v59.Parts) do
                local v63 = {
                    Part = v62,
                    CFrame = v59.BeforeCFrame[v62]
                }
                table.insert(v60, v63)
            end
            for v64, v65 in ipairs(v59.Models) do
                local v66 = {
                    Model = v65,
                    Pivot = v59.BeforeCFrame[v65]
                }
                table.insert(v60, v66)
            end
            Core.SyncAPI:Invoke("SyncMove", v60)
        end,
        Apply = function(v67) -- Apply | line 441 | captures: Core, Selection
            Selection.Replace(v67.Selection)
            local v68 = {}
            for v69, v70 in ipairs(v67.Parts) do
                local v71 = {
                    Part = v70,
                    CFrame = v67.AfterCFrame[v70]
                }
                table.insert(v68, v71)
            end
            for v72, v73 in ipairs(v67.Models) do
                local v74 = {
                    Model = v73,
                    Pivot = v67.AfterCFrame[v73]
                }
                table.insert(v68, v74)
            end
            Core.SyncAPI:Invoke("SyncMove", v68)
        end
    }
    for v75, v76 in pairs(v58.HistoryRecord.Parts) do
        v58.HistoryRecord.BeforeCFrame[v76] = v76.CFrame
    end
    pcall(function() -- line 473 | captures: v58
        for v77, v78 in ipairs(v58.HistoryRecord.Models) do
            v58.HistoryRecord.BeforeCFrame[v78] = v78:GetPivot()
        end
    end)
end

function v3.RegisterChange(v79) -- line 481 | captures: Core
    if not v79.HistoryRecord then
        return
    end
    local v80 = {}
    for v81, v82 in pairs(v79.HistoryRecord.Parts) do
        v79.HistoryRecord.AfterCFrame[v82] = v82.CFrame
        local v83 = {
            Part = v82,
            CFrame = v82.CFrame
        }
        table.insert(v80, v83)
    end
    pcall(function() -- line 498 | captures: v79, v80
        for v84, v85 in pairs(v79.HistoryRecord.Models) do
            v79.HistoryRecord.AfterCFrame[v85] = v85:GetPivot()
            local v86 = {
                Model = v85,
                Pivot = v85:GetPivot()
            }
            table.insert(v80, v86)
        end
    end)
    Core.SyncAPI:Invoke("SyncMove", v80)
    Core.History.Add(v79.HistoryRecord)
    v79.HistoryRecord = nil
end

function v3.PrepareSelectionForDragging(v87) -- line 518 | captures: Core, Selection, Support
    local v88 = {}
    local v89 = {}
    local v90 = Support.FlipTable(Selection.Parts)
    for v91, v92 in pairs(Selection.Parts) do
        v88[v92] = {
            Anchored = v92.Anchored,
            CanCollide = v92.CanCollide,
            CFrame = v92.CFrame
        }
        v92.Anchored = true
        v92.CanCollide = false
        v88[v92].Joints = Core.PreserveJoints(v92, v90)
        v92:BreakJoints()
        v92.Velocity = Vector3.new()
        v92.RotVelocity = Vector3.new()
    end
    pcall(function() -- line 541 | captures: v89, Selection
        for v93, v94 in ipairs(Selection.Models) do
            v89[v94] = { Pivot = v94:GetPivot() }
        end
    end)
    local v95
    local Focus = Selection.Focus
    if Focus then
        if Focus:IsA("BasePart") then
            v95 = Focus.CFrame
        elseif Focus:IsA("Model") then
            v95 = Focus:GetModelCFrame()
            pcall(function() -- line 558 | captures: v95, Focus
                v95 = Focus:GetPivot()
            end)
        end
    else
        v95 = nil
    end
    return v88, v89, v95
end

return v3
