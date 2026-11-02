-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

Tool = script.Parent.Parent
Core = require(Tool.Core)
SnapTracking = require(Tool.Core.Snapping)
game:GetService("ContextActionService")
local Workspace = game:GetService("Workspace")
local Libraries = Tool:WaitForChild("Libraries")
local v1 = require(Libraries:WaitForChild("Signal"))
require(Libraries:WaitForChild("Make"))
local v2 = require(Tool.Core:WaitForChild("ListenForManualWindowTrigger"))

Selection = Core.Selection
Support = Core.Support
Security = Core.Security
Support.ImportServices()
local v3 = {
    Name = "Resize Tool",
    Increment = 1,
    Directions = "Normal",
    Color = BrickColor.new("Cyan")
}

v3.ManualText = "<font face=\"GothamBlack\" size=\"16\">Resize Tool  \240\159\155\160</font>\nAllows you to resize parts.<font size=\"12\"><br /></font>\n<font size=\"12\" color=\"rgb(150, 150, 150)\"><b>Directions</b></font>\nLets you choose in which directions to resize the part.<font size=\"6\"><br /></font>\n\n<b>TIP: </b>Click on a part to focus the handles on it.<font size=\"6\"><br /></font>\n\n<b>TIP: </b>Hit <b>Enter</b> to switch between directions quickly.<font size=\"12\"><br /></font>\n\n<font size=\"12\" color=\"rgb(150, 150, 150)\"><b>Increment</b></font>\nLets you choose how many studs to resize by.<font size=\"6\"><br /></font>\n\n<b>TIP: </b>Hit the \226\128\147 key to quickly type increments.<font size=\"6\"><br /></font>\n\n<b>TIP: </b>Use your number pad to resize exactly by the current increment. Holding <b>Shift</b> reverses the increment.<font size=\"4\"><br /></font>\n   <font color=\"rgb(150, 150, 150)\">\226\128\162</font>  8 & 2 \226\128\148 up & down\n   <font color=\"rgb(150, 150, 150)\">\226\128\162</font>  1 & 9 \226\128\148 back & forth\n   <font color=\"rgb(150, 150, 150)\">\226\128\162</font>  4 & 6 \226\128\148 left & right<font size=\"12\"><br /></font>\n\n<font size=\"12\" color=\"rgb(150, 150, 150)\"><b>Snapping</b></font>\nHold the <b><i>R</i></b> key, and <b>click and drag the snap point</b> of a part (in the direction you want to resize) towards the snap point of another part, to resize up to that point.\n"

local v4 = {}

local function Equip() -- line 57
    ShowUI()
    ShowHandles()
    BindShortcutKeys()
end

v3.Equip = Equip

local function Unequip() -- line 67
    HideUI()
    HideHandles()
    ClearConnections()
    SnapTracking.StopTracking()
    FinishSnapping()
end

v3.Unequip = Unequip

function ClearConnections() -- line 79 | captures: v4
    for v5, v6 in pairs(v4) do
        v6:Disconnect()
        v4[v5] = nil
    end
end

function ClearConnection(v7) -- line 89 | captures: v4
    local v8 = v4[v7]
    if v8 then
        v8:Disconnect()
        v4[v7] = nil
    end
end

function ShowUI() -- line 102 | captures: v2, v3
    if v3.UI then
        v3.UI.Visible = true
    else
        v3.UI = Core.Tool.Interfaces.BTResizeToolGUI:Clone()
        v3.UI.Parent = Core.UI
        v3.UI.Visible = true
        local DirectionsOption = v3.UI.DirectionsOption
        DirectionsOption.Normal.Button.MouseButton1Down:Connect(function() -- line 126
            SetDirections("Normal")
        end)
        DirectionsOption.Both.Button.MouseButton1Down:Connect(function() -- line 129
            SetDirections("Both")
        end)
        local TextBox = v3.UI.IncrementOption.Increment.TextBox
        TextBox.FocusLost:Connect(function(v9) -- line 135 | captures: TextBox, v3
            local Text = TextBox.Text
            v3.Increment = tonumber(Text) or v3.Increment
            TextBox.Text = Support.Round(v3.Increment, 4)
        end)
        local TextBox_2 = v3.UI.Info.SizeInfo.X.TextBox
        local TextBox_3 = v3.UI.Info.SizeInfo.Y.TextBox
        local TextBox_4 = v3.UI.Info.SizeInfo.Z.TextBox
        TextBox_2.FocusLost:Connect(function(v10) -- line 144 | captures: TextBox_2
            local Text = TextBox_2.Text
            local v11 = tonumber(Text)
            if v11 then
                SetAxisSize("X", v11)
            end
        end)
        TextBox_3.FocusLost:Connect(function(v12) -- line 150 | captures: TextBox_3
            local Text = TextBox_3.Text
            local v13 = tonumber(Text)
            if v13 then
                SetAxisSize("Y", v13)
            end
        end)
        TextBox_4.FocusLost:Connect(function(v14) -- line 156 | captures: TextBox_4
            local Text = TextBox_4.Text
            local v15 = tonumber(Text)
            if v15 then
                SetAxisSize("Z", v15)
            end
        end)
        local Signature = v3.UI:WaitForChild("Title"):WaitForChild("Signature")
        v2(v3.ManualText, v3.Color.Color, Signature)
    end
    UIUpdater = Support.ScheduleRecurringTask(UpdateUI, 0.1)
end

function HideUI() -- line 172 | captures: v3
    if v3.UI then
        v3.UI.Visible = false
        UIUpdater:Stop()
    end
end

function UpdateUI() -- line 188 | captures: v3
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
                v16(v22, Support.Round(v26.Size.X, 3))
                v18(v23, Support.Round(v26.Size.Y, 3))
                v20(v24, Support.Round(v26.Size.Z, 3))
            end
            local v27 = Support.IdentifyCommonItem(v22)
            local v28 = Support.IdentifyCommonItem(v23)
            local v29 = Support.IdentifyCommonItem(v24)
            local TextBox = v3.UI.Info.SizeInfo.X.TextBox
            local TextBox_2 = v3.UI.Info.SizeInfo.Y.TextBox
            local TextBox_3 = v3.UI.Info.SizeInfo.Z.TextBox
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

function SetDirections(v30) -- line 239 | captures: v3
    v3.Directions = v30
    if v3.UI then
        Core.ToggleSwitch(v30, v3.UI.DirectionsOption)
    end
end

local v31 = {}

v31[Enum.NormalId.Top] = Vector3.new(0, 1, 0)
v31[Enum.NormalId.Bottom] = Vector3.new(0, 1, 0)
v31[Enum.NormalId.Front] = Vector3.new(0, 0, 1)
v31[Enum.NormalId.Back] = Vector3.new(0, 0, 1)
v31[Enum.NormalId.Left] = Vector3.new(1, 0, 0)
v31[Enum.NormalId.Right] = Vector3.new(1, 0, 0)

local v32 = {}

v32[Enum.NormalId.Top] = Vector3.new(0, 1, 0)
v32[Enum.NormalId.Bottom] = Vector3.new(0, -1, 0)
v32[Enum.NormalId.Front] = Vector3.new(0, 0, -1)
v32[Enum.NormalId.Back] = Vector3.new(0, 0, 1)
v32[Enum.NormalId.Left] = Vector3.new(-1, 0, 0)
v32[Enum.NormalId.Right] = Vector3.new(1, 0, 0)

local v33 = {}

v33[Enum.NormalId.Top] = "Y"
v33[Enum.NormalId.Bottom] = "Y"
v33[Enum.NormalId.Front] = "Z"
v33[Enum.NormalId.Back] = "Z"
v33[Enum.NormalId.Left] = "X"
v33[Enum.NormalId.Right] = "X"

function ShowHandles() -- line 282 | captures: Libraries, v3, v4
    if not v4.AutofocusHandle then
        v4.AutofocusHandle = Selection.FocusChanged:Connect(ShowHandles)
    end
    if v3.Handles then
        v3.Handles:SetAdornee(Selection.Focus)
    else
        local v34

        local function OnHandleDragStart() -- line 297 | captures: v34
            Core.Targeting.CancelSelecting()
            HandleResizing = true
            InitialState = PreparePartsForResizing()
            TrackChange()
            if Core.Mode == "Tool" then
                v34 = Security.GetPermissions(Security.GetSelectionAreas(Selection.Parts), Core.Player)
            end
        end

        local function OnHandleDrag(v35, v36) -- line 319 | captures: v34, v3
            if not HandleResizing then
                return
            end
            local v37 = GetIncrementMultiple(v36, v3.Increment)
            local v38, v39 = ResizePartsByFace(v35, v37, v3.Directions, InitialState)
            if not v38 then
                ResizePartsByFace(v35, v39, v3.Directions, InitialState)
            end
            if v3.UI then
                local Text = v3.UI.Changes.Text
                local Round = Support.Round
                local v40 = v39 or v37
                Text.Text = "resized " .. Round(math.abs(v40), 3) .. " studs"
            end
            if Core.Mode == "Tool" and Security.ArePartsViolatingAreas(Selection.Parts, Core.Player, false, v34) then
                for v41, v42 in pairs(InitialState) do
                    v41.Size = v42.Size
                    v41.CFrame = v42.CFrame
                end
            end
        end

        local function OnHandleDragEnd() -- line 353
            if not HandleResizing then
                return
            end
            HandleResizing = false
            Core.Targeting.CancelSelecting()
            for v43, v44 in pairs(InitialState) do
                v43:MakeJoints()
                v43.CanCollide = v44.CanCollide
                v43.Anchored = v44.Anchored
            end
            RegisterChange()
        end

        local v45 = require(Libraries:WaitForChild("Handles"))
        v3.Handles = v45.new({
            Color = v3.Color.Color,
            Parent = Core.UIContainer,
            Adornee = Selection.Focus,
            OnDragStart = OnHandleDragStart,
            OnDrag = OnHandleDrag,
            OnDragEnd = OnHandleDragEnd
        })
    end
end

function HideHandles() -- line 388 | captures: v3
    if v3.Handles then
        v3.Handles = v3.Handles:Destroy()
        ClearConnection("AutofocusHandle")
    end
end

function ResizePartsByFace(v46, v47, v48, v49) -- line 404 | captures: v3, v31, v32, v33
    local v50 = if v48 == "Both" then v47 * 2 else v47
    local v51 = v50 * v31[v46]
    local v52 = v33[v46]
    local v53, v54, v55
    for v56, v57 in pairs(v49) do
        local v58 = v57.Size[v52] + v50
        if v58 < 0.049999 then
            if v53 then
                if v58 < v53 then
                    v53 = v58
                    v54 = v56
                elseif v58 > 2048 then
                    if v55 then
                        if v55 < v58 then
                            v55 = v58
                        end
                    else
                        v55 = v58
                    end
                end
            else
                v53 = v58
                v54 = v56
            end
        elseif v58 > 2048 then
            if v55 then
                if v55 < v58 then
                    v55 = v58
                end
            else
                v55 = v58
            end
        end
    end
    if v53 then
        local v59 = v49[v54].Size[v52]
        local Increment = v3.Increment
        local v60 = (v59 - 0.05) / v3.Increment
        local v61 = tostring(v60):gsub("%..+", "")
        return false, v50 + (v59 - Increment * tonumber(v61)) - v53
    end
    if v55 then
        local Increment = v3.Increment
        local v62 = 2048 / v3.Increment
        local v63 = tostring(v62):gsub("%..+", "")
        return false, v50 + Increment * tonumber(v63) - v55
    end
    for v64, v65 in pairs(v49) do
        if v64:IsA("Part") then
            if v64.Shape == Enum.PartType.Ball then
                v64.Size = v65.Size + Vector3.new(v50, v50, v50)
            elseif v64.Shape == Enum.PartType.Cylinder then
                if v52 == "X" then
                    v64.Size = v65.Size + v51
                else
                    v64.Size = v65.Size + Vector3.new(0, v50, v50)
                end
            else
                v64.Size = v65.Size + v51
            end
        else
            v64.Size = v65.Size + v51
        end
        if v48 == "Normal" then
            v64.CFrame = v65.CFrame * CFrame.new(v32[v46] * v50 / 2)
        elseif v48 == "Both" then
            v64.CFrame = v65.CFrame
        end
    end
    return true
end

function BindShortcutKeys() -- line 490 | captures: v3, v4
    local function v66(v67, ...)
        table.insert(v67, ...)
    end

    local function v68(v69, ...)
        table.insert(v69, ...)
    end

    v66(v4, UserInputService.InputBegan:Connect(function(v70, v71) -- line 494 | captures: v3
        if not v71 and v70.UserInputType == Enum.UserInputType.Keyboard and not UserInputService:GetFocusedTextBox() then
            if v70.KeyCode == Enum.KeyCode.Return or v70.KeyCode == Enum.KeyCode.KeypadEnter then
                if v3.Directions == "Normal" then
                    SetDirections("Both")
                elseif v3.Directions == "Both" then
                    SetDirections("Normal")
                end
            else
                if v70.KeyCode == Enum.KeyCode.KeypadEight then
                    NudgeSelectionByFace(Enum.NormalId.Top)
                    return
                end
                if v70.KeyCode == Enum.KeyCode.KeypadTwo then
                    NudgeSelectionByFace(Enum.NormalId.Bottom)
                    return
                end
                if v70.KeyCode == Enum.KeyCode.KeypadNine then
                    NudgeSelectionByFace(Enum.NormalId.Front)
                elseif v70.KeyCode == Enum.KeyCode.KeypadOne then
                    NudgeSelectionByFace(Enum.NormalId.Back)
                elseif v70.KeyCode == Enum.KeyCode.KeypadFour then
                    NudgeSelectionByFace(Enum.NormalId.Left)
                elseif v70.KeyCode == Enum.KeyCode.KeypadSix then
                    NudgeSelectionByFace(Enum.NormalId.Right)
                elseif v70.KeyCode == Enum.KeyCode.R and not Selection.Multiselecting then
                    StartSnapping()
                end
            end
        end
    end))
    v68(v4, UserInputService.InputEnded:Connect(function(v72, v73) -- line 555 | captures: v3
        if not v73 and v72.UserInputType == Enum.UserInputType.Keyboard and not UserInputService:GetFocusedTextBox() then
            if v72.KeyCode ~= Enum.KeyCode.R or Selection.Multiselecting then
                if (v72.KeyCode.Name == "Minus" or v72.KeyCode.Name == "KeypadMinus") and v3.UI then
                    v3.UI.IncrementOption.Increment.TextBox:CaptureFocus()
                end
            else
                FinishSnapping()
            end
        end
    end))
end

function SetAxisSize(v74, v75) -- line 587
    TrackChange()
    local v76 = PreparePartsForResizing()
    for v77, v78 in pairs(v76) do
        local v79 = if v74 == "X" and v75 then v75 else v77.Size.X
        local v80 = if v74 == "Y" and v75 then v75 else v77.Size.Y
        local v81 = if v74 == "Z" and v75 then v75 else v77.Size.Z
        v77.Size = Vector3.new(v79, v80, v81)
        v77.CFrame = v78.CFrame
    end
    local v82 = Security.GetPermissions(Security.GetSelectionAreas(Selection.Parts), Core.Player)
    if Core.Mode == "Tool" and Security.ArePartsViolatingAreas(Selection.Parts, Core.Player, false, v82) then
        for v83, v84 in pairs(v76) do
            v83.Size = v84.Size
            v83.CFrame = v84.CFrame
        end
    end
    for v85, v86 in pairs(v76) do
        v85:MakeJoints()
        v85.CanCollide = v86.CanCollide
        v85.Anchored = v86.Anchored
    end
    RegisterChange()
end

function NudgeSelectionByFace(v87) -- line 634 | captures: v3
    local Increment = v3.Increment
    local v88 = Support.FlipTable(Support.GetListMembers(UserInputService:GetKeysPressed(), "KeyCode"))
    if v88[Enum.KeyCode.LeftShift] or v88[Enum.KeyCode.RightShift] then
        Increment = -Increment
    end
    TrackChange()
    local v89 = PreparePartsForResizing()
    local v90, v91 = ResizePartsByFace(v87, Increment, v3.Directions, v89)
    if not v90 then
        ResizePartsByFace(v87, v91, v3.Directions, v89)
    end
    if v3.UI then
        v3.UI.Changes.Text.Text = "resized " .. Support.Round(v91 or Increment, 3) .. " studs"
    end
    local v92 = Security.GetPermissions(Security.GetSelectionAreas(Selection.Parts), Core.Player)
    if Core.Mode == "Tool" and Security.ArePartsViolatingAreas(Selection.Parts, Core.Player, false, v92) then
        for v93, v94 in pairs(v89) do
            v93.Size = v94.Size
            v93.CFrame = v94.CFrame
        end
    end
    for v95, v96 in pairs(v89) do
        v95:MakeJoints()
        v95.CanCollide = v96.CanCollide
        v95.Anchored = v96.Anchored
    end
    RegisterChange()
end

function TrackChange() -- line 688
    HistoryRecord = {
        Parts = Support.CloneTable(Selection.Parts),
        BeforeSize = {},
        AfterSize = {},
        BeforeCFrame = {},
        AfterCFrame = {},
        Selection = Selection.Items,
        Unapply = function(v97) -- Unapply | line 699
            Selection.Replace(v97.Selection)
            local v98 = {}
            for v99, v100 in pairs(v97.Parts) do
                local v101 = {
                    Part = v100,
                    Size = v97.BeforeSize[v100],
                    CFrame = v97.BeforeCFrame[v100]
                }
                table.insert(v98, v101)
            end
            Core.SyncAPI:Invoke("SyncResize", v98)
        end,
        Apply = function(v102) -- Apply | line 716
            Selection.Replace(v102.Selection)
            local v103 = {}
            for v104, v105 in pairs(v102.Parts) do
                local v106 = {
                    Part = v105,
                    Size = v102.AfterSize[v105],
                    CFrame = v102.AfterCFrame[v105]
                }
                table.insert(v103, v106)
            end
            Core.SyncAPI:Invoke("SyncResize", v103)
        end
    }
    for v107, v108 in pairs(HistoryRecord.Parts) do
        HistoryRecord.BeforeSize[v108] = v108.Size
        HistoryRecord.BeforeCFrame[v108] = v108.CFrame
    end
end

function RegisterChange() -- line 743
    if not HistoryRecord then
        return
    end
    local v109 = {}
    for v110, v111 in pairs(HistoryRecord.Parts) do
        HistoryRecord.AfterSize[v111] = v111.Size
        HistoryRecord.AfterCFrame[v111] = v111.CFrame
        local v112 = {
            Part = v111,
            Size = v111.Size,
            CFrame = v111.CFrame
        }
        table.insert(v109, v112)
    end
    Core.SyncAPI:Invoke("SyncResize", v109)
    Core.History.Add(HistoryRecord)
    HistoryRecord = nil
end

function PreparePartsForResizing() -- line 768
    local v113 = {}
    for v114, v115 in pairs(Selection.Parts) do
        v113[v115] = {
            Anchored = v115.Anchored,
            CanCollide = v115.CanCollide,
            Size = v115.Size,
            CFrame = v115.CFrame
        }
        v115.Anchored = true
        v115.CanCollide = false
        v115:BreakJoints()
        v115.Velocity = Vector3.new()
        v115.RotVelocity = Vector3.new()
    end
    return v113
end

function GetIncrementMultiple(v116, v117) -- line 786
    local v118 = v116 % v117
    local v119 = v116 - v118
    local v120 = v116 - v118 + v117
    local v121 = v116 - v119
    local v122 = math.abs(v121)
    local v123 = v116 - v120
    if v122 <= math.abs(v123) then
        return v119
    end
    return v120
end

PointSnapped = v1.new()

function StartSnapping() -- line 812 | captures: Workspace, v3, v4
    if SnappingStage or SnapTracking.Enabled then
        return
    end
    SnappingStage = "Starting"
    SnapTracking.TrackEdgeMidpoints = false
    SnapTracking.TrackFaceCentroids = false

    function SnapTracking.TargetFilter(v124) -- line 825
        return Selection.PartIndex[v124]
    end

    SnapTracking.StartTracking(function(v125) -- line 830
        if v125 and v125.p ~= SnappedPoint then
            SnappedPoint = v125.p
            PointSnapped:Fire(v125.p)
        end
    end)
    v4.SnapDragStart = Support.AddUserInputListener("Began", "MouseButton1", false, function(v126) -- line 838 | captures: Workspace, v3, v4
        SnappingStage = "Direction"
        SnappingStartAim = Vector2.new(v126.Position.X, v126.Position.Y)
        SnappingStartPoint = SnappedPoint
        SnappingStartTarget = SnapTracking.Target
        SnappingStartDirections = GetFaceOffsetsFromCorner(SnappingStartTarget, SnappingStartPoint)
        SnappingStartSelectionState = PreparePartsForResizing()
        AreaPermissions = Security.GetPermissions(Security.GetSelectionAreas(Selection.Parts), Core.Player)
        SnapTracking.StopTracking()
        DirectionLine = Core.Tool.Interfaces.SnapLine:Clone()
        DirectionLine.Parent = Core.UI
        DirectionLine.Visible = false
        TrackChange()
        v4.SnapDrag = Support.AddUserInputListener("Changed", "MouseMovement", true, function(v127) -- line 861 | captures: Workspace
            SnappingEndAim = Vector2.new(v127.Position.X, v127.Position.Y)
            ScreenSnappedPoint = Workspace.CurrentCamera:WorldToScreenPoint(SnappingStartPoint)
            ScreenSnappedPoint = Vector2.new(ScreenSnappedPoint.X, ScreenSnappedPoint.Y)
            local v128 = (SnappingStartAim - ScreenSnappedPoint).magnitude * 1.5
            local v129 = math.max(50, v128)
            local v130 = math.min(50, v129)
            if SnappingStage ~= "Direction" then
                return
            end
            local v131 = SnappingEndAim.Y - ScreenSnappedPoint.Y
            local v132 = SnappingEndAim.X - ScreenSnappedPoint.X
            local v133 = math.atan2(v131, v132)
            local v134 = math.deg(v133)
            if v134 > 0 then
                v134 = v134 - 360 or v134
            end
            local v135 = {}
            for v136, v137 in pairs(SnappingStartDirections) do
                local v138 = Workspace.CurrentCamera:WorldToScreenPoint(v137.Offset)
                local v139 = v138.Y - ScreenSnappedPoint.Y
                local v140 = v138.X - ScreenSnappedPoint.X
                local v141 = math.atan2(v139, v140)
                local v142 = math.deg(v141)
                if v142 > 0 then
                    v142 = v142 - 360 or v142
                end
                local v143 = v134 - v142
                local v144 = math.abs(v143) % 180
                if v144 > 90 then
                    v144 = 180 - v144 or v144
                end
                local v145 = {
                    Face = v137.Face,
                    AngleDelta = v144,
                    DirectionAngle = v142,
                    Offset = v137.Offset
                }
                table.insert(v135, v145)
            end
            table.sort(v135, function(v146, v147) -- line 904
                return v146.AngleDelta < v147.AngleDelta
            end)
            DirectionLine.Position = UDim2.new(0, ScreenSnappedPoint.X, 0, ScreenSnappedPoint.Y)
            local v148 = v134 - v135[1].DirectionAngle
            if math.abs(v148) <= 90 then
                DirectionLine.Rotation = v135[1].DirectionAngle
            else
                DirectionLine.Rotation = 180 + v135[1].DirectionAngle
            end
            DirectionLine.PointMarker.Rotation = -DirectionLine.Rotation
            DirectionLine.SnapProgress.Size = UDim2.new(0, v130, 2, 0)
            DirectionLine.Visible = true
            if (SnappingEndAim - ScreenSnappedPoint).magnitude < v130 then
                return
            end
            DirectionLine:Destroy()
            SnappingDirection = v135[1].Face
            SnappingDirectionOffset = v135[1].Offset
            SnappingStage = "Destination"
            SnapTracking.TrackEdgeMidpoints = true
            SnapTracking.TrackFaceCentroids = true

            function SnapTracking.TargetFilter(v149) -- line 942
                return not v149.Locked
            end

            SnapTracking.TargetBlacklist = Selection.Items
            AlignmentLine = Core.Tool.Interfaces.SnapLineSegment:Clone()
            AlignmentLine.Visible = false
            AlignmentLine.Parent = Core.UI
            SnapTracking.StartTracking(function(v150) -- line 951
                if v150 and v150.p ~= SnappedPoint then
                    SnappedPoint = v150.p
                    PointSnapped:Fire(v150.p)
                end
            end)
        end)
        v4.Snap = PointSnapped:Connect(function(v151) -- line 963 | captures: Workspace, v3
            if SnappingStage ~= "Destination" then
                return
            end
            local unit = (SnappingDirectionOffset - SnappingStartPoint).unit
            local v152 = (v151 - SnappingStartPoint):Dot(unit)
            if ResizePartsByFace(SnappingDirection, v152, "Normal", SnappingStartSelectionState) then
                if v3.UI then
                    v3.UI.Changes.Text.Text = "resized " .. Support.Round(v152, 3) .. " studs"
                end
                local v153 = Workspace.CurrentCamera:WorldToScreenPoint(SnappingStartPoint + unit * v152)
                local v154 = Vector2.new(v153.X, v153.Y)
                local v155 = Workspace.CurrentCamera:WorldToScreenPoint(v151)
                local v156 = Vector2.new(v155.X, v155.Y)
                local v157 = v156.Y - v154.Y
                local v158 = v156.X - v154.X
                local v159 = math.atan2(v157, v158)
                local v160 = math.deg(v159)
                local v161 = v154:Lerp(v156, 0.5)
                AlignmentLine.Position = UDim2.new(0, v161.X, 0, v161.Y)
                AlignmentLine.Rotation = v160
                AlignmentLine.Size = UDim2.new(0, (v156 - v154).magnitude, 0, 1)
                AlignmentLine.PointMarkerA.Rotation = -v160
                AlignmentLine.Visible = true
            end
            if Core.Mode == "Tool" and Security.ArePartsViolatingAreas(Selection.Parts, Core.Player, false, AreaPermissions) then
                for v162, v163 in pairs(SnappingStartSelectionState) do
                    v162.Size = v163.Size
                    v162.CFrame = v163.CFrame
                end
            end
        end)
    end)
end

Support.AddUserInputListener("Ended", "MouseButton1", true, function(v164) -- line 1017
    if SnappingStage then
        FinishSnapping()
    end
end)

function FinishSnapping() -- line 1030
    if not SnappingStage then
        return
    end
    if SnappingStartSelectionState then
        for v165, v166 in pairs(SnappingStartSelectionState) do
            v165:MakeJoints()
            v165.CanCollide = v166.CanCollide
            v165.Anchored = v166.Anchored
        end
    end
    SnappingStage = nil
    SnapTracking.StopTracking()
    if DirectionLine then
        DirectionLine:Destroy()
        DirectionLine = nil
    end
    if AlignmentLine then
        AlignmentLine:Destroy()
        AlignmentLine = nil
    end
    if HistoryRecord then
        RegisterChange()
    end
    ClearConnection("SnapDragStart")
    ClearConnection("SnapDrag")
    ClearConnection("Snap")
    ClearConnection("SnapDragEnd")
end

function GetFaceOffsetsFromCorner(v167, v168) -- line 1077
    local v169 = {}
    local v170 = GetFacesFromCorner(v167, v168)
    for v171, v172 in pairs(v170) do
        local v173 = Vector3.FromNormalId(v172) * v167.Size / 2
        local v174 = {
            Face = v172,
            Offset = CFrame.new(v168) * CFrame.Angles(v167.CFrame:toEulerAnglesXYZ()) * v173
        }
        table.insert(v169, v174)
    end
    return v169
end

function GetFacesFromCorner(v175, v176) -- line 1097
    local v177 = {}
    for v178, v179 in pairs(Enum.NormalId:GetEnumItems()) do
        local v180 = {
            Proximity = (v176 - v175.CFrame * (v175.Size / 2 * Vector3.FromNormalId(v179))).magnitude,
            Face = v179
        }
        table.insert(v177, v180)
    end
    table.sort(v177, function(v181, v182) -- line 1114
        return v181.Proximity < v182.Proximity
    end)
    return {
        v177[1].Face,
        v177[2].Face,
        v177[3].Face
    }
end

return v3
