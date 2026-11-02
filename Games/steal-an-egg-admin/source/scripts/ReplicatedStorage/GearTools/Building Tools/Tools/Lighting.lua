-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

Tool = script.Parent.Parent
Core = require(Tool.Core)

local Vendor = Tool:WaitForChild("Vendor")
local UI = Tool:WaitForChild("UI")
local Libraries = Tool:WaitForChild("Libraries")
local v1 = require(Tool.Core:WaitForChild("ListenForManualWindowTrigger"))
local v2 = require(Vendor:WaitForChild("Roact"))
local v3 = require(UI:WaitForChild("ColorPicker"))
local v4 = require(UI:WaitForChild("Dropdown"))
local v5 = require(Libraries:WaitForChild("Signal"))

Selection = Core.Selection
Support = Core.Support
Security = Core.Security
Support.ImportServices()
local v6 = {
    Name = "Lighting Tool",
    Color = BrickColor.new("Really black"),
    OnSideChanged = v5.new()
}

v6.ManualText = "<font face=\"GothamBlack\" size=\"16\">Lighting Tool  \240\159\155\160</font>\nLets you add point lights, surface lights, and spotlights to parts.<font size=\"6\"><br /></font>\n\n<b>TIP:</b> Click on the surface of any part to change a light's side quickly."

local v7 = {}

local function Equip() -- line 37
    ShowUI()
    EnableSurfaceClickSelection()
end

v6.Equip = Equip

local function Unequip() -- line 46
    HideUI()
    ClearConnections()
end

v6.Unequip = Unequip

function ClearConnections() -- line 55 | captures: v7
    for v8, v9 in pairs(v7) do
        v9:Disconnect()
        v7[v8] = nil
    end
end

function ShowUI() -- line 65 | captures: v1, v6
    if v6.UI then
        v6.UI.Visible = true
    else
        v6.UI = Core.Tool.Interfaces.BTLightingToolGUI:Clone()
        v6.UI.Parent = Core.UI
        v6.UI.Visible = true
        EnableLightSettingsUI(v6.UI.PointLight)
        EnableLightSettingsUI(v6.UI.SpotLight)
        EnableLightSettingsUI(v6.UI.SurfaceLight)
        local Signature = v6.UI:WaitForChild("Title"):WaitForChild("Signature")
        v1(v6.ManualText, v6.Color.Color, Signature)
    end
    UIUpdater = Support.ScheduleRecurringTask(UpdateUI, 0.1)
end

function EnableSurfaceClickSelection(v10) -- line 100 | captures: v7
    if v7.SurfaceClickSelection then
        v7.SurfaceClickSelection:Disconnect()
        v7.SurfaceClickSelection = nil
    end
    local Button1Down = Core.Mouse.Button1Down
    v7.SurfaceClickSelection = Button1Down:Connect(function() -- line 110 | captures: v10
        local v11, v12 = Core.Targeting:UpdateTarget()
        if Selection.IsSelected(v12) then
            SetSurface(v10, Core.Mouse.TargetSurface)
        end
    end)
end

function EnableLightSettingsUI(v13) -- line 119 | captures: v2, v3, v4, v6
    local Name = v13.Name
    local Options = v13.Options
    local TextBox = Options.RangeOption.Input.TextBox
    local TextBox_2 = Options.BrightnessOption.Input.TextBox
    local HSVPicker = Options.ColorOption.HSVPicker
    local Checkbox = Options.ShadowsOption.Checkbox
    local AddButton = v13.AddButton
    local RemoveButton = v13.RemoveButton
    local ArrowButton = v13.ArrowButton
    TextBox.FocusLost:Connect(function() -- line 138 | captures: Name, TextBox
        local v14 = SetRange
        local Text = TextBox.Text
        v14(Name, (tonumber(Text)))
    end)
    TextBox_2.FocusLost:Connect(function() -- line 143 | captures: Name, TextBox_2
        local v15 = SetBrightness
        local Text = TextBox_2.Text
        v15(Name, (tonumber(Text)))
    end)
    local v16
    HSVPicker.MouseButton1Click:Connect(function() -- line 149 | captures: v16, Name, v2, v3
        local Color = Support.IdentifyCommonProperty(GetLights(Name), "Color")
        local createElement = v2.createElement
        local v17 = {}
        v17.InitialColor = Color or Color3.fromRGB(255, 255, 255)

        function v17.SetPreviewColor(v18) -- line 153 | captures: Name
            PreviewColor(Name, v18)
        end

        function v17.OnConfirm(v19) -- line 156 | captures: v16, Name, v2
            SetColor(Name, v19)
            v16 = v2.unmount(v16)
        end

        function v17.OnCancel() -- line 160 | captures: v16, v2
            v16 = v2.unmount(v16)
        end

        local v20 = createElement(v3, v17)
        v16 = v16 and v2.update(v16, v20) or v2.mount(v20, Core.UI, "ColorPicker")
    end)
    Checkbox.MouseButton1Click:Connect(function() -- line 170 | captures: Name
        ToggleShadows(Name)
    end)
    AddButton.MouseButton1Click:Connect(function() -- line 175 | captures: Name
        AddLights(Name)
    end)
    RemoveButton.MouseButton1Click:Connect(function() -- line 180 | captures: Name
        RemoveLights(Name)
    end)
    ArrowButton.MouseButton1Click:Connect(function() -- line 185 | captures: Name
        OpenLightOptions(Name)
    end)
    if Name ~= "SpotLight" and Name ~= "SurfaceLight" then
        return
    end
    local v21 = { "Top", "Bottom", "Front", "Back", "Left", "Right" }
    local v22 = "Current" .. Name .. "Side"

    local function BuildDropdown() -- line 202 | captures: Name, v21, v22, v2, v4, v6
        local createElement = v2.createElement
        local v23 = {
            MaxRows = 3,
            Position = UDim2.new(0, 30, 0, 0),
            Size = UDim2.new(0, 72, 0, 25),
            Options = v21
        }
        v23.CurrentOption = v6[v22] and v6[v22].Name

        function v23.OnOptionSelected(v24) -- line 209 | captures: Name
            SetSurface(Name, Enum.NormalId[v24])
        end

        return createElement(v4, v23)
    end

    local Dropdown = v2.mount(BuildDropdown(), Options.SideOption, "Dropdown")
    v6.OnSideChanged:Connect(function() -- line 217 | captures: BuildDropdown, Dropdown, v2
        v2.update(Dropdown, BuildDropdown())
    end)
    local TextBox_3 = Options.AngleOption.Input.TextBox
    TextBox_3.FocusLost:Connect(function() -- line 223 | captures: Name, TextBox_3
        local v25 = SetAngle
        local Text = TextBox_3.Text
        v25(Name, (tonumber(Text)))
    end)
end

function HideUI() -- line 231 | captures: v6
    if v6.UI then
        v6.UI.Visible = false
        UIUpdater:Stop()
    end
end

function GetLights(v26) -- line 247
    local function v27(v28, ...)
        table.insert(v28, ...)
    end

    local v29 = {}
    for v30, v31 in pairs(Selection.Parts) do
        v27(v29, Support.GetChildOfClass(v31, v26))
    end
    return v29
end

local v32 = { "SpotLight", "PointLight", "SurfaceLight" }

function OpenLightOptions(v33) -- line 265 | captures: v6, v32
    local v34 = v6.UI[v33]
    local v35 = Core.Tool.Interfaces.BTLightingToolGUI[v33]
    CloseLightOptions(v33)
    local v36 = UDim2.new(0, 0, 0, v35.Options.Size.Y.Offset)
    v34.Options.Size = UDim2.new(v34.Options.Size.X.Scale, v34.Options.Size.X.Offset, v34.Options.Size.Y.Scale, 0)
    v34.ClipsDescendants = false
    v34.Options:TweenSize(v35.Options.Size + v36, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true, function() -- line 288 | captures: v34
        v34.Options.ClipsDescendants = false
    end)
    v6.UI:TweenSize(Core.Tool.Interfaces.BTLightingToolGUI.Size + v36, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
    local v37 = Support.FindTableOccurrence(v32, v33) + 1
    local v38 = #v32
    for v39 = v37, v38 do
        local v40 = v32[v39]
        local v41 = v6.UI[v40]
        v41:TweenPosition(UDim2.new(v41.Position.X.Scale, v41.Position.X.Offset, v41.Position.Y.Scale, (v39 - 1) * 30 + 30 + v36.Y.Offset), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
    end
    EnableSurfaceClickSelection(v33)
end

function CloseLightOptions(v42) -- line 328 | captures: v6, v32
    local v43, Size
    for v44, v45 in pairs(v32) do
        local v46 = v6.UI[v45]
        local Size_2 = Core.Tool.Interfaces.BTLightingToolGUI[v45].Options.Size
        v46:TweenPosition(UDim2.new(v46.Position.X.Scale, v46.Position.X.Offset, v46.Position.Y.Scale, 30 + 30 * (v44 - 1)), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
        if v42 then
            if v45 ~= v42 then
                v46.Options.ClipsDescendants = true
                local Options = v46.Options
                local v47 = UDim2.new(v46.Options.Size.X.Scale, v46.Options.Size.X.Offset, v46.Options.Size.Y.Scale, 0)
                local Out = Enum.EasingDirection.Out
                local Quad = Enum.EasingStyle.Quad
                v43 = v46
                Size = Size_2
                Options:TweenSize(v47, Out, Quad, 0.5, true, function() -- line 362 | captures: v43, Size
                    v43.ClipsDescendants = true
                    v43.Options.Size = Size
                end)
            end
        else
            v46.Options.ClipsDescendants = true
            local Options = v46.Options
            local v48 = UDim2.new(v46.Options.Size.X.Scale, v46.Options.Size.X.Offset, v46.Options.Size.Y.Scale, 0)
            local Out = Enum.EasingDirection.Out
            local Quad = Enum.EasingStyle.Quad
            v43 = v46
            Size = Size_2
            Options:TweenSize(v48, Out, Quad, 0.5, true, function() -- line 362 | captures: v43, Size
                v43.ClipsDescendants = true
                v43.Options.Size = Size
            end)
        end
    end
    if not v42 then
        v6.UI:TweenSize(Core.Tool.Interfaces.BTLightingToolGUI.Size, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
    end
end

function UpdateUI() -- line 387 | captures: v6, v32
    if v6.UI then
        for v49, v50 in pairs(v32) do
            local v51 = GetLights(v50)
            local v52 = v6.UI[v50]
            local Options = v52.Options
            local TextBox = Options.RangeOption.Input.TextBox
            local TextBox_2 = Options.BrightnessOption.Input.TextBox
            local Indicator = Options.ColorOption.Indicator
            local Checkbox = Options.ShadowsOption.Checkbox
            local AddButton = v52.AddButton
            local RemoveButton = v52.RemoveButton
            if #v51 == 0 and not v52.ClipsDescendants then
                CloseLightOptions()
            end
            if #v51 == 0 then
                AddButton.Visible = true
                AddButton.Position = UDim2.new(1, -AddButton.AbsoluteSize.X - 5, 0, 3)
                RemoveButton.Visible = false
            elseif #v51 < #Selection.Parts then
                AddButton.Visible = true
                AddButton.Position = UDim2.new(1, -AddButton.AbsoluteSize.X - 5, 0, 3)
                RemoveButton.Visible = true
                RemoveButton.Position = UDim2.new(1, -AddButton.AbsoluteSize.X - 5 - RemoveButton.AbsoluteSize.X - 2, 0, 3)
            elseif #v51 == #Selection.Parts then
                RemoveButton.Visible = true
                RemoveButton.Position = UDim2.new(1, -RemoveButton.AbsoluteSize.X - 5, 0, 3)
                AddButton.Visible = false
            end
            local v53 = UpdateDataInputs
            local v54 = {}
            v54[TextBox] = Support.Round(Support.IdentifyCommonProperty(v51, "Range"), 2) or "*"
            v54[TextBox_2] = Support.Round(Support.IdentifyCommonProperty(v51, "Brightness"), 2) or "*"
            v53(v54)
            if v50 == "SpotLight" or v50 == "SurfaceLight" then
                local TextBox = Options.AngleOption.Input.TextBox
                local v55 = UpdateDataInputs
                local v56 = {}
                v56[TextBox] = Support.Round(Support.IdentifyCommonProperty(v51, "Angle"), 2) or "*"
                v55(v56)
                local Face = Support.IdentifyCommonProperty(v51, "Face")
                local v57 = "Current" .. v50 .. "Side"
                if v6[v57] ~= Face then
                    v6[v57] = Face
                    v6.OnSideChanged:Fire()
                end
            end
            local Color = Support.IdentifyCommonProperty(v51, "Color")
            if Color then
                Indicator.BackgroundColor3 = Color
                Indicator.Varies.Text = ""
            else
                Indicator.BackgroundColor3 = Color3.new(0.8705882352941177, 0.8705882352941177, 0.8705882352941177)
                Indicator.Varies.Text = "*"
            end
            local Shadows = Support.IdentifyCommonProperty(v51, "Shadows")
            if Shadows == true then
                Checkbox.Image = Core.Assets.CheckedCheckbox
            elseif Shadows == false then
                Checkbox.Image = Core.Assets.UncheckedCheckbox
            elseif Shadows == nil then
                Checkbox.Image = Core.Assets.SemicheckedCheckbox
            end
        end
    end
end

function UpdateDataInputs(v58) -- line 500
    for v59, v60 in pairs(v58) do
        if not v59:IsFocused() then
            v59.Text = tostring(v60)
        end
    end
end

function AddLights(v61) -- line 518
    local v62 = {}
    for v63, v64 in pairs(Selection.Parts) do
        if not Support.GetChildOfClass(v64, v61) then
            local v65 = {
                Part = v64,
                LightType = v61
            }
            table.insert(v62, v65)
        end
    end
    local v66 = {
        Lights = Core.SyncAPI:Invoke("CreateLights", v62),
        Selection = Selection.Items,
        Unapply = function(v67) -- Unapply | line 544
            Selection.Replace(v67.Selection)
            Core.SyncAPI:Invoke("Remove", v67.Lights)
        end,
        Apply = function(v68) -- Apply | line 555
            Core.SyncAPI:Invoke("UndoRemove", v68.Lights)
            Selection.Replace(v68.Selection)
        end
    }
    Core.History.Add(v66)
    OpenLightOptions(v61)
end

function RemoveLights(v69) -- line 576
    local v70 = GetLights(v69)
    local v71 = {
        Lights = v70,
        Selection = Selection.Items,
        Unapply = function(v72) -- Unapply | line 586
            Core.SyncAPI:Invoke("UndoRemove", v72.Lights)
            Selection.Replace(v72.Selection)
        end,
        Apply = function(v73) -- Apply | line 597
            Selection.Replace(v73.Selection)
            Core.SyncAPI:Invoke("Remove", v73.Lights)
        end
    }
    Core.SyncAPI:Invoke("Remove", v70)
    Core.History.Add(v71)
end

function TrackChange() -- line 618
    HistoryRecord = {
        Before = {},
        After = {},
        Selection = Selection.Items,
        Unapply = function(v74) -- Unapply | line 626
            Selection.Replace(v74.Selection)
            Core.SyncAPI:Invoke("SyncLighting", v74.Before)
        end,
        Apply = function(v75) -- Apply | line 637
            Selection.Replace(v75.Selection)
            Core.SyncAPI:Invoke("SyncLighting", v75.After)
        end
    }
end

function RegisterChange() -- line 652
    if not HistoryRecord then
        return
    end
    Core.SyncAPI:Invoke("SyncLighting", HistoryRecord.After)
    Core.History.Add(HistoryRecord)
    HistoryRecord = nil
end

function SetRange(v76, v77) -- line 669
    if not v77 then
        return
    end
    TrackChange()
    for v78, v79 in pairs(GetLights(v76)) do
        local Before = HistoryRecord.Before
        local v80 = {
            Part = v79.Parent,
            LightType = v76,
            Range = v79.Range
        }
        table.insert(Before, v80)
        local After = HistoryRecord.After
        local v81 = {
            Part = v79.Parent,
            LightType = v76,
            Range = v77
        }
        table.insert(After, v81)
    end
    RegisterChange()
end

function SetBrightness(v82, v83) -- line 695
    if not v83 then
        return
    end
    TrackChange()
    for v84, v85 in pairs(GetLights(v82)) do
        local Before = HistoryRecord.Before
        local v86 = {
            Part = v85.Parent,
            LightType = v82,
            Brightness = v85.Brightness
        }
        table.insert(Before, v86)
        local After = HistoryRecord.After
        local v87 = {
            Part = v85.Parent,
            LightType = v82,
            Brightness = v83
        }
        table.insert(After, v87)
    end
    RegisterChange()
end

function SetColor(v88, v89) -- line 721
    if not v89 then
        return
    end
    TrackChange()
    for v90, v91 in pairs(GetLights(v88)) do
        local Before = HistoryRecord.Before
        local v92 = {
            Part = v91.Parent,
            LightType = v88,
            Color = v91.Color
        }
        table.insert(Before, v92)
        local After = HistoryRecord.After
        local v93 = {
            Part = v91.Parent,
            LightType = v88,
            Color = v89
        }
        table.insert(After, v93)
    end
    RegisterChange()
end

local v94

function PreviewColor(v95, v96) -- line 749 | captures: v94
    if v96 or not v94 then
        if v96 then
            if not v94 then
                v94 = {}
                for v97, v98 in pairs(GetLights(v95)) do
                    v94[v98] = { Color = v98.Color }
                end
            end
            for v99 in pairs(v94) do
                v99.Color = v96
            end
        end
    else
        for v100, v101 in pairs(v94) do
            v100.Color = v101.Color
        end
        v94 = nil
    end
end

function ToggleShadows(v102) -- line 782
    local v103 = not Support.IdentifyCommonProperty(GetLights(v102), "Shadows")
    TrackChange()
    for v104, v105 in pairs(GetLights(v102)) do
        local Before = HistoryRecord.Before
        local v106 = {
            Part = v105.Parent,
            LightType = v102,
            Shadows = v105.Shadows
        }
        table.insert(Before, v106)
        local After = HistoryRecord.After
        local v107 = {
            Part = v105.Parent,
            LightType = v102,
            Shadows = v103
        }
        table.insert(After, v107)
    end
    RegisterChange()
end

function SetSurface(v108, v109) -- line 806 | captures: v6
    if not v109 or v108 ~= "SurfaceLight" and v108 ~= "SpotLight" then
        return
    end
    v6["Current" .. v108 .. "Side"] = v109
    TrackChange()
    for v110, v111 in pairs(GetLights(v108)) do
        local Before = HistoryRecord.Before
        local v112 = {
            Part = v111.Parent,
            LightType = v108,
            Face = v111.Face
        }
        table.insert(Before, v112)
        local After = HistoryRecord.After
        local v113 = {
            Part = v111.Parent,
            LightType = v108,
            Face = v109
        }
        table.insert(After, v113)
    end
    RegisterChange()
end

function SetAngle(v114, v115) -- line 834
    if not v115 then
        return
    end
    TrackChange()
    for v116, v117 in pairs(GetLights(v114)) do
        local Before = HistoryRecord.Before
        local v118 = {
            Part = v117.Parent,
            LightType = v114,
            Angle = v117.Angle
        }
        table.insert(Before, v118)
        local After = HistoryRecord.After
        local v119 = {
            Part = v117.Parent,
            LightType = v114,
            Angle = v115
        }
        table.insert(After, v119)
    end
    RegisterChange()
end

return v6
