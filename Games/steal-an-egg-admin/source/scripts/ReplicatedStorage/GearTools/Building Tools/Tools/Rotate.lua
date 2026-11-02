-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

Tool = script.Parent.Parent
Core = require(Tool.Core)
SnapTracking = require(Tool.Core.Snapping)
BoundingBox = require(Tool.Core.BoundingBox)
game:GetService("ContextActionService")
game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Libraries = Tool:WaitForChild("Libraries")
local v1 = require(Libraries:WaitForChild("Make"))
local v2 = require(Tool.Core:WaitForChild("ListenForManualWindowTrigger"))

Selection = Core.Selection
Support = Core.Support
Security = Core.Security
Support.ImportServices()
local v3 = {
    Name = "Rotate Tool",
    Increment = 15,
    Pivot = "Center",
    Color = BrickColor.new("Bright green")
}

v3.ManualText = "<font face=\"GothamBlack\" size=\"16\">Rotate Tool  \240\159\155\160</font>\nAllows you to rotate parts.<font size=\"12\"><br /></font>\n<font size=\"12\" color=\"rgb(150, 150, 150)\"><b>Pivot</b></font>\nThis option lets you choose what to rotate the parts around.<font size=\"6\"><br /></font>\n <font color=\"rgb(150, 150, 150)\">\226\128\162</font>  <b>CENTER</b> <font color=\"rgb(150, 150, 150)\">\226\128\148</font> Relative to the <b>center of the selection</b>\n <font color=\"rgb(150, 150, 150)\">\226\128\162</font>  <b>LOCAL</b> <font color=\"rgb(150, 150, 150)\">\226\128\148</font> Each part around its <b>own center</b>\n <font color=\"rgb(150, 150, 150)\">\226\128\162</font>  <b>LAST</b> <font color=\"rgb(150, 150, 150)\">\226\128\148</font> Relative to the <b>center of the last part clicked</b><font size=\"6\"><br /></font>\n\n<b>TIP:</b> Click on any part to focus the handles on it.<font size=\"6\"><br /></font>\n<b>TIP: </b>Hit the <b>Enter</b> key to switch between Pivot modes quickly.<font size=\"12\"><br /></font>\n\n<font size=\"12\" color=\"rgb(150, 150, 150)\"><b>Increment</b></font>\nLets you choose how many degrees to rotate by.<font size=\"6\"><br /></font>\n\n<b>TIP: </b>Hit the \226\128\147 key to quickly type increments.<font size=\"6\"><br /></font>\n\n<b>TIP: </b>Use your number pad to rotate exactly by the current increment. Holding <b>Shift</b> reverses the increment.<font size=\"4\"><br /></font>\n   <font color=\"rgb(150, 150, 150)\">\226\128\162</font>  4 & 6 \226\128\148 Y axis (green)\n   <font color=\"rgb(150, 150, 150)\">\226\128\162</font>  1 & 9 \226\128\148 Z axis (blue)\n   <font color=\"rgb(150, 150, 150)\">\226\128\162</font>  2 & 8 \226\128\148 X axis (red)<font size=\"12\"><br /></font>\n\n<font size=\"12\" color=\"rgb(150, 150, 150)\"><b>Snapping</b></font>\nPress <b><i>R</i></b> and click on a part's <b>snap point</b> to rotate around it.\n"

local v4 = {}

function v3.Equip() -- line 60 | captures: v3
    SetPivot(v3.Pivot)
    ShowUI()
    BindShortcutKeys()
end

local function Unequip() -- line 72
    HideUI()
    HideHandles()
    ClearConnections()
    BoundingBox.ClearBoundingBox()
    SnapTracking.StopTracking()
end

v3.Unequip = Unequip

function ClearConnections() -- line 84 | captures: v4
    for v5, v6 in pairs(v4) do
        v6:Disconnect()
        v4[v5] = nil
    end
end

function ClearConnection(v7) -- line 94 | captures: v4
    local v8 = v4[v7]
    if v4[v7] then
        v8:Disconnect()
        v4[v7] = nil
    end
end

function ShowUI() -- line 107 | captures: v2, v3
    if v3.UI then
        v3.UI.Visible = true
    else
        v3.UI = Core.Tool.Interfaces.BTRotateToolGUI:Clone()
        v3.UI.Parent = Core.UI
        v3.UI.Visible = true
        local PivotOption = v3.UI.PivotOption
        PivotOption.Center.Button.MouseButton1Down:Connect(function() -- line 131
            SetPivot("Center")
        end)
        PivotOption.Local.Button.MouseButton1Down:Connect(function() -- line 134
            SetPivot("Local")
        end)
        PivotOption.Last.Button.MouseButton1Down:Connect(function() -- line 137
            SetPivot("Last")
        end)
        local TextBox = v3.UI.IncrementOption.Increment.TextBox
        TextBox.FocusLost:Connect(function(v9) -- line 143 | captures: TextBox, v3
            local Text = TextBox.Text
            v3.Increment = tonumber(Text) or v3.Increment
            TextBox.Text = Support.Round(v3.Increment, 4)
        end)
        local TextBox_2 = v3.UI.Info.RotationInfo.X.TextBox
        local TextBox_3 = v3.UI.Info.RotationInfo.Y.TextBox
        local TextBox_4 = v3.UI.Info.RotationInfo.Z.TextBox
        TextBox_2.FocusLost:Connect(function(v10) -- line 152 | captures: TextBox_2
            local Text = TextBox_2.Text
            local v11 = tonumber(Text)
            if v11 then
                SetAxisAngle("X", v11)
            end
        end)
        TextBox_3.FocusLost:Connect(function(v12) -- line 158 | captures: TextBox_3
            local Text = TextBox_3.Text
            local v13 = tonumber(Text)
            if v13 then
                SetAxisAngle("Y", v13)
            end
        end)
        TextBox_4.FocusLost:Connect(function(v14) -- line 164 | captures: TextBox_4
            local Text = TextBox_4.Text
            local v15 = tonumber(Text)
            if v15 then
                SetAxisAngle("Z", v15)
            end
        end)
        local Signature = v3.UI:WaitForChild("Title"):WaitForChild("Signature")
        v2(v3.ManualText, v3.Color.Color, Signature)
    end
    UIUpdater = Support.ScheduleRecurringTask(UpdateUI, 0.1)
end

function HideUI() -- line 180 | captures: v3
    if v3.UI then
        v3.UI.Visible = false
        UIUpdater:Stop()
    end
end

function UpdateUI() -- line 196 | captures: v3
    local function v16(v17, ...)
        table.insert(v17, ...)
    end

    local function v18(v19, ...)
        table.insert(v19, ...)
    end

    local function v20(v21, ...)
        table.insert(v21, ...)
    end

    if v3.UI then
        if #Selection.Parts == 0 then
            v3.UI.Info.Visible = false
            v3.UI.Size = UDim2.new(0, 245, 0, 90)
        else
            v3.UI.Info.Visible = true
            v3.UI.Size = UDim2.new(0, 245, 0, 150)
            local v22 = {}
            local v23 = {}
            local v24 = {}
            for v25, v26 in pairs(Selection.Parts) do
                v16(v22, Support.Round(v26.Orientation.X, 3))
                v18(v23, Support.Round(v26.Orientation.Y, 3))
                v20(v24, Support.Round(v26.Orientation.Z, 3))
            end
            local v27 = Support.IdentifyCommonItem(v22)
            local v28 = Support.IdentifyCommonItem(v23)
            local v29 = Support.IdentifyCommonItem(v24)
            local TextBox = v3.UI.Info.RotationInfo.X.TextBox
            local TextBox_2 = v3.UI.Info.RotationInfo.Y.TextBox
            local TextBox_3 = v3.UI.Info.RotationInfo.Z.TextBox
            if not TextBox:IsFocused() then
                TextBox.Text = v27 or "*"
            end
            if not TextBox_2:IsFocused() then
                TextBox_2.Text = v28 or "*"
            end
            if not TextBox_3:IsFocused() then
                TextBox_3.Text = v29 or "*"
            end
        end
    end
end

function SetPivot(v30) -- line 247 | captures: v3
    v3.Pivot = v30
    if v3.UI then
        Core.ToggleSwitch(v30, v3.UI.PivotOption)
    end
    BoundingBox.ClearBoundingBox()
    if v30 == "Center" then
        BoundingBox.StartBoundingBox(AttachHandles)
    elseif v30 == "Local" then
        AttachHandles(Selection.Focus, true)
    elseif v30 == "Last" then
        AttachHandles(CustomPivotPoint and v3.Handles and v3.Handles.Adornee or Selection.Focus, true)
    end
end

function AttachHandles(v31, v32) -- line 276 | captures: Libraries, v3, v4
    if not v32 or v4.AutofocusHandle then
        if not v32 and v4.AutofocusHandle then
            ClearConnection("AutofocusHandle")
        end
    else
        v4.AutofocusHandle = Selection.FocusChanged:Connect(function() -- line 281
            AttachHandles(Selection.Focus, true)
        end)
    end
    CustomPivotPoint = nil
    if v3.Handles then
        v3.Handles:BlacklistObstacle(BoundingBox.GetBoundingBox())
        v3.Handles:SetAdornee(v31)
    else
        local v33

        local function OnHandleDragStart() -- line 301 | captures: v33, v3
            Core.Targeting.CancelSelecting()
            HandleRotating = true
            if BoundingBox.GetBoundingBox() then
                local v34, v35 = BoundingBox.CalculateExtents(Selection.Parts, BoundingBox.StaticExtents)
                InitialExtentsSize = v34
                InitialExtentsCFrame = v35
                BoundingBox.PauseMonitoring()
            end
            local v36, v37 = PrepareSelectionForRotating()
            InitialPartStates = v36
            InitialModelStates = v37
            TrackChange()
            if Core.Mode == "Tool" then
                v33 = Security.GetPermissions(Security.GetSelectionAreas(Selection.Parts), Core.Player)
            end
            if v3.Pivot == "Center" then
                PivotPoint = BoundingBox.GetBoundingBox().CFrame
            elseif v3.Pivot == "Last" and not CustomPivotPoint then
                if Selection.Focus:IsA("BasePart") then
                    PivotPoint = Selection.Focus.CFrame
                elseif Selection.Focus:IsA("Model") then
                    PivotPoint = Selection.Focus:GetModelCFrame()
                    pcall(function() -- line 337
                        PivotPoint = Selection.Focus:GetPivot()
                    end)
                end
            end
        end

        local function OnHandleDrag(v38, v39) -- line 345 | captures: v33, v3
            if not HandleRotating then
                return
            end
            local v40 = math.deg(v39)
            local v41 = GetIncrementMultiple(v40, v3.Increment) % 360
            local v42 = GetHandleDisplayDelta(v41)
            RotateSelectionAroundPivot(v3.Pivot, PivotPoint, v38, v41, InitialPartStates, InitialModelStates)
            if Core.Mode == "Tool" and Security.ArePartsViolatingAreas(Selection.Parts, Core.Player, false, v33) then
                for v43, v44 in pairs(InitialPartStates) do
                    v43.CFrame = v44.CFrame
                end
                for v45, v46 in pairs(InitialModelStates) do
                    v45.WorldPivot = v46.Pivot
                end
                v42 = 0
            end
            if v3.UI then
                v3.UI.Changes.Text.Text = "rotated " .. v42 .. " degrees"
            end
        end

        local function OnHandleDragEnd() -- line 385
            if not HandleRotating then
                return
            end
            Core.Targeting.CancelSelecting()
            HandleRotating = false
            ClearConnection("HandleRelease")
            HandleDirection = nil
            HandleFirstAngle = nil
            LastDisplayedRotation = nil
            for v47, v48 in pairs(InitialPartStates) do
                v47:MakeJoints()
                Core.RestoreJoints(v48.Joints)
                v47.CanCollide = v48.CanCollide
                v47.Anchored = v48.Anchored
            end
            RegisterChange()
            BoundingBox.RecalculateStaticExtents()
            BoundingBox.ResumeMonitoring()
        end

        local v49 = require(Libraries:WaitForChild("ArcHandles"))
        v3.Handles = v49.new({
            Color = v3.Color.Color,
            Parent = Core.UIContainer,
            Adornee = v31,
            ObstacleBlacklist = { BoundingBox.GetBoundingBox() },
            OnDragStart = OnHandleDragStart,
            OnDrag = OnHandleDrag,
            OnDragEnd = OnHandleDragEnd
        })
    end
end

function HideHandles() -- line 434 | captures: v3
    if v3.Handles then
        v3.Handles = v3.Handles:Destroy()
        ClearConnection("AutofocusHandle")
    end
end

function RotateSelectionAroundPivot(v50, v51, v52, v53, v54, v55) -- line 450 | captures: v3
    local v56 = CFrame.fromAxisAngle(Vector3.FromAxis(v52), (math.rad(v53)))
    for v57, v58 in pairs(v54) do
        if v50 == "Center" or v50 == "Last" then
            v57.CFrame = v51 * v56 * v51:toObjectSpace(v58.CFrame)
        elseif v3.Pivot == "Local" then
            v57.CFrame = v58.CFrame * v56
        end
    end
    for v59, v60 in pairs(v55) do
        if v50 == "Center" or v50 == "Last" then
            v59.WorldPivot = v51 * v56 * v51:ToObjectSpace(v60.Pivot)
        end
    end
end

function GetHandleDisplayDelta(v61) -- line 498
    if HandleFirstAngle == nil then
        HandleFirstAngle = true
        HandleDirection = true
    elseif HandleFirstAngle == true then
        if math.abs(v61) > 180 then
            HandleDirection = false
        else
            HandleDirection = true
        end
        HandleFirstAngle = false
    end
    local v62 = if HandleDirection == true then (360 - v61) % 360 else v61 % 360
    if LastDisplayedRotation and (LastDisplayedRotation <= 120 and v62 >= 240 or LastDisplayedRotation >= 240 and v62 <= 120) then
        HandleDirection = not HandleDirection
    end
    local v63 = if HandleDirection == true then (360 - v61) % 360 else v61 % 360
    LastDisplayedRotation = v63
    return v63
end

function BindShortcutKeys() -- line 551 | captures: UserInputService, v3, v4
    local function v64(v65, ...)
        table.insert(v65, ...)
    end

    v64(v4, UserInputService.InputBegan:Connect(function(v66, v67) -- line 555 | captures: UserInputService, v3
        if not v67 and v66.UserInputType == Enum.UserInputType.Keyboard and not UserInputService:GetFocusedTextBox() then
            if v66.KeyCode == Enum.KeyCode.Return or v66.KeyCode == Enum.KeyCode.KeypadEnter then
                if v3.Pivot == "Center" then
                    SetPivot("Local")
                elseif v3.Pivot == "Local" then
                    SetPivot("Last")
                elseif v3.Pivot == "Last" then
                    SetPivot("Center")
                end
            else
                if v66.KeyCode == Enum.KeyCode.KeypadEight then
                    NudgeSelectionByAxis(Enum.Axis.X, 1)
                    return
                end
                if v66.KeyCode == Enum.KeyCode.KeypadTwo then
                    NudgeSelectionByAxis(Enum.Axis.X, -1)
                    return
                end
                if v66.KeyCode == Enum.KeyCode.KeypadNine then
                    NudgeSelectionByAxis(Enum.Axis.Z, 1)
                elseif v66.KeyCode == Enum.KeyCode.KeypadOne then
                    NudgeSelectionByAxis(Enum.Axis.Z, -1)
                elseif v66.KeyCode == Enum.KeyCode.KeypadFour then
                    NudgeSelectionByAxis(Enum.Axis.Y, -1)
                elseif v66.KeyCode == Enum.KeyCode.KeypadSix then
                    NudgeSelectionByAxis(Enum.Axis.Y, 1)
                elseif v66.KeyCode ~= Enum.KeyCode.R or Selection.Multiselecting then
                    if v66.KeyCode == Enum.KeyCode.T and not Selection.Multiselecting then
                        StartSnapping()
                    end
                else
                    StartSnapping()
                end
            end
        end
    end))
    v4.HotkeyRelease = UserInputService.InputEnded:Connect(function(v68, v69) -- line 623 | captures: v3
        if not v69 and v68.UserInputType == Enum.UserInputType.Keyboard and (v68.KeyCode.Name == "Minus" or v68.KeyCode.Name == "KeypadMinus") and v3.UI then
            v3.UI.IncrementOption.Increment.TextBox:CaptureFocus()
        end
    end)
end

function StartSnapping() -- line 642 | captures: v1, v4
    if not SnapTracking.Enabled then
        SnapTracking.StartTracking(function(v70) -- line 650
            SnappedPoint = v70
        end)
        v4.SelectSnappedPivot = Core.Mouse.Button1Down:Connect(function() -- line 655 | captures: v1
            Core.Targeting.CancelSelecting()
            if not SnappedPoint then
                return
            end
            SnapTracking.StopTracking()
            local v71 = v1("Part")({
                Size = Vector3.new(5, 1, 5),
                CFrame = SnappedPoint
            })
            SetPivot("Last")
            AttachHandles(v71, true)
            GCBypass = { v71 }
            PivotPoint = SnappedPoint
            CustomPivotPoint = true
            ClearConnection("SelectSnappedPivot")
        end)
    end
end

function SetAxisAngle(v72, v73) -- line 690
    local v74 = math.rad(v73)
    TrackChange()
    local v75 = PrepareSelectionForRotating()
    for v76, v77 in pairs(v75) do
        local v78 = CFrame.new(v76.Position)
        local fromOrientation = CFrame.fromOrientation
        local v79
        if v72 == "X" and v74 then
            v79 = v74
        else
            local X = v76.Orientation.X
            v79 = math.rad(X)
        end
        local v80
        if v72 == "Y" and v74 then
            v80 = v74
        else
            local Y = v76.Orientation.Y
            v80 = math.rad(Y)
        end
        local v81
        if v72 == "Z" and v74 then
            v81 = v74
        else
            local Z = v76.Orientation.Z
            v81 = math.rad(Z)
        end
        v76.CFrame = v78 * fromOrientation(v79, v80, v81)
    end
    local v82 = Security.GetPermissions(Security.GetSelectionAreas(Selection.Parts), Core.Player)
    if Core.Mode == "Tool" and Security.ArePartsViolatingAreas(Selection.Parts, Core.Player, false, v82) then
        for v83, v84 in pairs(v75) do
            v83.CFrame = v84.CFrame
        end
    end
    for v85, v86 in pairs(v75) do
        v85:MakeJoints()
        Core.RestoreJoints(v86.Joints)
        v85.CanCollide = v86.CanCollide
        v85.Anchored = v86.Anchored
    end
    RegisterChange()
end

function NudgeSelectionByAxis(v87, v88) -- line 737 | captures: UserInputService, v3
    if #Selection.Parts == 0 then
        return
    end
    local Increment = v3.Increment
    local v89 = Support.FlipTable(Support.GetListMembers(UserInputService:GetKeysPressed(), "KeyCode"))
    if v89[Enum.KeyCode.LeftShift] or v89[Enum.KeyCode.RightShift] then
        Increment = -Increment
    end
    TrackChange()
    local v90, v91 = PrepareSelectionForRotating()
    if v3.Pivot == "Center" then
        local v92, v93 = BoundingBox.CalculateExtents(Selection.Parts)
        PivotPoint = v93
    elseif v3.Pivot == "Last" and not CustomPivotPoint then
        if Selection.Focus:IsA("BasePart") then
            PivotPoint = Selection.Focus.CFrame
        elseif Selection.Focus:IsA("Model") then
            PivotPoint = Selection.Focus:GetModelCFrame()
            pcall(function() -- line 771
                PivotPoint = Selection.Focus:GetPivot()
            end)
        end
    end
    RotateSelectionAroundPivot(v3.Pivot, PivotPoint, v87, Increment * (v88 or 1), v90, v91)
    if v3.UI then
        v3.UI.Changes.Text.Text = "rotated " .. Increment * (v88 or 1) .. " degrees"
    end
    local v94 = Security.GetPermissions(Security.GetSelectionAreas(Selection.Parts), Core.Player)
    if Core.Mode == "Tool" and Security.ArePartsViolatingAreas(Selection.Parts, Core.Player, false, v94) then
        for v95, v96 in pairs(v90) do
            v95.CFrame = v96.CFrame
        end
        for v97, v98 in pairs(v91) do
            v97.WorldPivot = v98.Pivot
        end
    end
    for v99, v100 in pairs(v90) do
        v99:MakeJoints()
        Core.RestoreJoints(v100.Joints)
        v99.CanCollide = v100.CanCollide
        v99.Anchored = v100.Anchored
    end
    RegisterChange()
end

function TrackChange() -- line 811
    HistoryRecord = {
        Parts = Support.CloneTable(Selection.Parts),
        Models = Support.CloneTable(Selection.Models),
        BeforeCFrame = {},
        AfterCFrame = {},
        Selection = Selection.Items,
        Unapply = function(v101) -- Unapply | line 821
            Selection.Replace(v101.Selection)
            local v102 = {}
            for v103, v104 in pairs(v101.Parts) do
                local v105 = {
                    Part = v104,
                    CFrame = v101.BeforeCFrame[v104]
                }
                table.insert(v102, v105)
            end
            for v106, v107 in pairs(v101.Models) do
                local v108 = {
                    Model = v107,
                    Pivot = v101.BeforeCFrame[v107]
                }
                table.insert(v102, v108)
            end
            Core.SyncAPI:Invoke("SyncRotate", v102)
        end,
        Apply = function(v109) -- Apply | line 847
            Selection.Replace(v109.Selection)
            local v110 = {}
            for v111, v112 in pairs(v109.Parts) do
                local v113 = {
                    Part = v112,
                    CFrame = v109.AfterCFrame[v112]
                }
                table.insert(v110, v113)
            end
            for v114, v115 in pairs(v109.Models) do
                local v116 = {
                    Model = v115,
                    Pivot = v109.AfterCFrame[v115]
                }
                table.insert(v110, v116)
            end
            Core.SyncAPI:Invoke("SyncRotate", v110)
        end
    }
    for v117, v118 in pairs(HistoryRecord.Parts) do
        HistoryRecord.BeforeCFrame[v118] = v118.CFrame
    end
    pcall(function() -- line 879
        for v119, v120 in pairs(HistoryRecord.Models) do
            HistoryRecord.BeforeCFrame[v120] = v120:GetPivot()
        end
    end)
end

function RegisterChange() -- line 886
    if not HistoryRecord then
        return
    end
    local v121 = {}
    for v122, v123 in pairs(HistoryRecord.Parts) do
        HistoryRecord.AfterCFrame[v123] = v123.CFrame
        local v124 = {
            Part = v123,
            CFrame = v123.CFrame
        }
        table.insert(v121, v124)
    end
    pcall(function() -- line 903 | captures: v121
        for v125, v126 in pairs(HistoryRecord.Models) do
            HistoryRecord.AfterCFrame[v126] = v126:GetPivot()
            local v127 = {
                Model = v126,
                Pivot = v126:GetPivot()
            }
            table.insert(v121, v127)
        end
    end)
    Core.SyncAPI:Invoke("SyncRotate", v121)
    Core.History.Add(HistoryRecord)
    HistoryRecord = nil
end

function PrepareSelectionForRotating() -- line 922
    local v128 = {}
    local v129 = {}
    local v130 = Support.FlipTable(Selection.Parts)
    for v131, v132 in pairs(Selection.Parts) do
        v128[v132] = {
            Anchored = v132.Anchored,
            CanCollide = v132.CanCollide,
            CFrame = v132.CFrame
        }
        v132.Anchored = true
        v132.CanCollide = false
        v128[v132].Joints = Core.PreserveJoints(v132, v130)
        v132:BreakJoints()
        v132.Velocity = Vector3.new()
        v132.RotVelocity = Vector3.new()
    end
    pcall(function() -- line 948 | captures: v129
        for v133, v134 in pairs(Selection.Models) do
            v129[v134] = { Pivot = v134:GetPivot() }
        end
    end)
    return v128, v129
end

function GetIncrementMultiple(v135, v136) -- line 959
    local v137 = v135 % v136
    local v138 = v135 - v137
    local v139 = v135 - v137 + v136
    local v140 = v135 - v138
    local v141 = math.abs(v140)
    local v142 = v135 - v139
    if v141 <= math.abs(v142) then
        return v138
    end
    return v139
end

return v3
