-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

Tool = script.Parent.Parent
Core = require(Tool.Core)

local Vendor = Tool:WaitForChild("Vendor")
local UI = Tool:WaitForChild("UI")
local v1 = require(Tool.Core:WaitForChild("ListenForManualWindowTrigger"))
local v2 = require(Vendor:WaitForChild("Roact"))
local v3 = require(UI:WaitForChild("ColorPicker"))

Selection = Core.Selection
Support = Core.Support
Security = Core.Security
Support.ImportServices()
local v4 = {
    Name = "Decorate Tool",
    Color = BrickColor.new("Really black")
}

v4.ManualText = "<font face=\"GothamBlack\" size=\"16\">Decorate Tool  \240\159\155\160</font>\nAllows you to add smoke, fire, and sparkles to parts."

local v5 = {}

local function Equip() -- line 29
    ShowUI()
end

v4.Equip = Equip

local function Unequip() -- line 37
    HideUI()
    ClearConnections()
end

v4.Unequip = Unequip

function ClearConnections() -- line 46 | captures: v5
    for v6, v7 in pairs(v5) do
        v7:Disconnect()
        v5[v6] = nil
    end
end

function ShowUI() -- line 56 | captures: v1, v4
    if v4.UI then
        v4.UI.Visible = true
    else
        v4.UI = Core.Tool.Interfaces.BTDecorateToolGUI:Clone()
        v4.UI.Parent = Core.UI
        v4.UI.Visible = true
        EnableOptionsUI(v4.UI.Smoke)
        EnableOptionsUI(v4.UI.Fire)
        EnableOptionsUI(v4.UI.Sparkles)
        local Signature = v4.UI:WaitForChild("Title"):WaitForChild("Signature")
        v1(v4.ManualText, v4.Color.Color, Signature)
    end
    UIUpdater = Support.ScheduleRecurringTask(UpdateUI, 0.1)
end

local v8 = { "Smoke", "Fire", "Sparkles" }

function UpdateUI() -- line 95 | captures: v4, v8
    if v4.UI then
        for v9, v10 in pairs(v8) do
            local v11 = GetDecorations(v10)
            local v12 = v4.UI[v10]
            local Options = v12.Options
            local AddButton = v12.AddButton
            local RemoveButton = v12.RemoveButton
            if #v11 == 0 and not v12.ClipsDescendants then
                CloseOptions()
            end
            if #v11 == 0 then
                AddButton.Visible = true
                AddButton.Position = UDim2.new(1, -AddButton.AbsoluteSize.X - 5, 0, 3)
                RemoveButton.Visible = false
            elseif #v11 < #Selection.Parts then
                AddButton.Visible = true
                AddButton.Position = UDim2.new(1, -AddButton.AbsoluteSize.X - 5, 0, 3)
                RemoveButton.Visible = true
                RemoveButton.Position = UDim2.new(1, -AddButton.AbsoluteSize.X - 5 - RemoveButton.AbsoluteSize.X - 2, 0, 3)
            elseif #v11 == #Selection.Parts then
                RemoveButton.Visible = true
                RemoveButton.Position = UDim2.new(1, -RemoveButton.AbsoluteSize.X - 5, 0, 3)
                AddButton.Visible = false
            end
            if v10 == "Smoke" then
                local TextBox = Options.SizeOption.Input.TextBox
                local TextBox_2 = Options.VelocityOption.Input.TextBox
                local TextBox_3 = Options.OpacityOption.Input.TextBox
                local Indicator = Options.ColorOption.Indicator
                local v13 = UpdateDataInputs
                local v14 = {}
                v14[TextBox] = Support.Round(Support.IdentifyCommonProperty(v11, "Size"), 2) or "*"
                v14[TextBox_2] = Support.Round(Support.IdentifyCommonProperty(v11, "RiseVelocity"), 2) or "*"
                v14[TextBox_3] = Support.Round(Support.IdentifyCommonProperty(v11, "Opacity"), 2) or "*"
                v13(v14)
                UpdateColorIndicator(Indicator, Support.IdentifyCommonProperty(v11, "Color"))
            elseif v10 == "Fire" then
                local TextBox = Options.SizeOption.Input.TextBox
                local TextBox_2 = Options.HeatOption.Input.TextBox
                local Indicator = Options.SecondaryColorOption.Indicator
                local Indicator_2 = Options.ColorOption.Indicator
                UpdateColorIndicator(Indicator_2, Support.IdentifyCommonProperty(v11, "Color"))
                UpdateColorIndicator(Indicator, Support.IdentifyCommonProperty(v11, "SecondaryColor"))
                local v15 = UpdateDataInputs
                local v16 = {}
                v16[TextBox_2] = Support.Round(Support.IdentifyCommonProperty(v11, "Heat"), 2) or "*"
                v16[TextBox] = Support.Round(Support.IdentifyCommonProperty(v11, "Size"), 2) or "*"
                v15(v16)
            elseif v10 == "Sparkles" then
                local Indicator = Options.ColorOption.Indicator
                UpdateColorIndicator(Indicator, Support.IdentifyCommonProperty(v11, "SparkleColor"))
            end
        end
    end
end

function HideUI() -- line 205 | captures: v4
    if v4.UI then
        v4.UI.Visible = false
        UIUpdater:Stop()
    end
end

function GetDecorations(v17) -- line 221
    local function v18(v19, ...)
        table.insert(v19, ...)
    end

    local v20 = {}
    for v21, v22 in pairs(Selection.Parts) do
        v18(v20, Support.GetChildOfClass(v22, v17))
    end
    return v20
end

function UpdateColorIndicator(v23, v24) -- line 236
    if v24 then
        v23.BackgroundColor3 = v24
        v23.Varies.Text = ""
    else
        v23.BackgroundColor3 = Color3.new(0.8705882352941177, 0.8705882352941177, 0.8705882352941177)
        v23.Varies.Text = "*"
    end
end

function UpdateDataInputs(v25) -- line 252
    for v26, v27 in pairs(v25) do
        if not v26:IsFocused() then
            v26.Text = tostring(v27)
        end
    end
end

function TrackChange() -- line 270
    HistoryRecord = {
        Before = {},
        After = {},
        Selection = Selection.Items,
        Unapply = function(v28) -- Unapply | line 278
            Selection.Replace(v28.Selection)
            Core.SyncAPI:Invoke("SyncDecorate", v28.Before)
        end,
        Apply = function(v29) -- Apply | line 289
            Selection.Replace(v29.Selection)
            Core.SyncAPI:Invoke("SyncDecorate", v29.After)
        end
    }
end

function RegisterChange() -- line 304
    if not HistoryRecord then
        return
    end
    Core.SyncAPI:Invoke("SyncDecorate", HistoryRecord.After)
    Core.History.Add(HistoryRecord)
    HistoryRecord = nil
end

function EnableOptionsUI(v30) -- line 321
    local Name = v30.Name
    local Options = v30.Options
    local AddButton = v30.AddButton
    local RemoveButton = v30.RemoveButton
    local ArrowButton = v30.ArrowButton
    if Name == "Smoke" then
        SyncInputToProperty("Color", Name, "Color", Options.ColorOption.HSVPicker)
        SyncInputToProperty("Size", Name, "Number", Options.SizeOption.Input.TextBox)
        SyncInputToProperty("RiseVelocity", Name, "Number", Options.VelocityOption.Input.TextBox)
        SyncInputToProperty("Opacity", Name, "Number", Options.OpacityOption.Input.TextBox)
    elseif Name == "Fire" then
        SyncInputToProperty("Color", Name, "Color", Options.ColorOption.HSVPicker)
        SyncInputToProperty("SecondaryColor", Name, "Color", Options.SecondaryColorOption.HSVPicker)
        SyncInputToProperty("Size", Name, "Number", Options.SizeOption.Input.TextBox)
        SyncInputToProperty("Heat", Name, "Number", Options.HeatOption.Input.TextBox)
    elseif Name == "Sparkles" then
        SyncInputToProperty("SparkleColor", Name, "Color", Options.ColorOption.HSVPicker)
    end
    AddButton.MouseButton1Click:Connect(function() -- line 356 | captures: Name
        AddDecorations(Name)
    end)
    RemoveButton.MouseButton1Click:Connect(function() -- line 361 | captures: Name
        RemoveDecorations(Name)
    end)
    ArrowButton.MouseButton1Click:Connect(function() -- line 366 | captures: Name
        OpenOptions(Name)
    end)
end

function OpenOptions(v31) -- line 372 | captures: v4, v8
    local v32 = v4.UI[v31]
    local v33 = Core.Tool.Interfaces.BTDecorateToolGUI[v31]
    CloseOptions(v31)
    local v34 = UDim2.new(0, 0, 0, v33.Options.Size.Y.Offset)
    v32.Options.Size = UDim2.new(v32.Options.Size.X.Scale, v32.Options.Size.X.Offset, v32.Options.Size.Y.Scale, 0)
    v32.ClipsDescendants = false
    v32.Options:TweenSize(v33.Options.Size + v34, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true, function() -- line 395 | captures: v32
        v32.Options.ClipsDescendants = false
    end)
    v4.UI:TweenSize(Core.Tool.Interfaces.BTDecorateToolGUI.Size + v34, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
    local v35 = Support.FindTableOccurrence(v8, v31) + 1
    local v36 = #v8
    for v37 = v35, v36 do
        local v38 = v8[v37]
        local v39 = v4.UI[v38]
        v39:TweenPosition(UDim2.new(v39.Position.X.Scale, v39.Position.X.Offset, v39.Position.Y.Scale, (v37 - 1) * 30 + 30 + v34.Y.Offset), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
    end
end

function CloseOptions(v40) -- line 432 | captures: v4, v8
    local v41, Size
    for v42, v43 in pairs(v8) do
        local v44 = v4.UI[v43]
        local Size_2 = Core.Tool.Interfaces.BTDecorateToolGUI[v43].Options.Size
        v44:TweenPosition(UDim2.new(v44.Position.X.Scale, v44.Position.X.Offset, v44.Position.Y.Scale, 30 + 30 * (v42 - 1)), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
        if v40 then
            if v43 ~= v40 then
                v44.Options.ClipsDescendants = true
                local Options = v44.Options
                local v45 = UDim2.new(v44.Options.Size.X.Scale, v44.Options.Size.X.Offset, v44.Options.Size.Y.Scale, 0)
                local Out = Enum.EasingDirection.Out
                local Quad = Enum.EasingStyle.Quad
                v41 = v44
                Size = Size_2
                Options:TweenSize(v45, Out, Quad, 0.5, true, function() -- line 466 | captures: v41, Size
                    v41.ClipsDescendants = true
                    v41.Options.Size = Size
                end)
            end
        else
            v44.Options.ClipsDescendants = true
            local Options = v44.Options
            local v46 = UDim2.new(v44.Options.Size.X.Scale, v44.Options.Size.X.Offset, v44.Options.Size.Y.Scale, 0)
            local Out = Enum.EasingDirection.Out
            local Quad = Enum.EasingStyle.Quad
            v41 = v44
            Size = Size_2
            Options:TweenSize(v46, Out, Quad, 0.5, true, function() -- line 466 | captures: v41, Size
                v41.ClipsDescendants = true
                v41.Options.Size = Size
            end)
        end
    end
    if not v40 then
        v4.UI:TweenSize(Core.Tool.Interfaces.BTDecorateToolGUI.Size, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
    end
end

function SyncInputToProperty(v47, v48, v49, v50) -- line 491 | captures: v2, v3
    if v49 == "Color" then
        local v51
        v50.MouseButton1Click:Connect(function() -- line 497 | captures: v51, v47, v48, v2, v3
            local v52 = Support.IdentifyCommonProperty(GetDecorations(v48), v47)
            local createElement = v2.createElement
            local v53 = {}
            v53.InitialColor = v52 or Color3.fromRGB(255, 255, 255)

            function v53.SetPreviewColor(v54) -- line 501 | captures: v47, v48
                SetPreviewColor(v48, v47, v54)
            end

            function v53.OnConfirm(v55) -- line 504 | captures: v51, v47, v48, v2
                SetProperty(v48, v47, v55)
                v51 = v2.unmount(v51)
            end

            function v53.OnCancel() -- line 508 | captures: v51, v2
                v51 = v2.unmount(v51)
            end

            local v56 = createElement(v3, v53)
            v51 = v51 and v2.update(v51, v56) or v2.mount(v56, Core.UI, "ColorPicker")
        end)
    elseif v49 == "Number" then
        v50.FocusLost:Connect(function() -- line 519 | captures: v47, v48, v50
            local v57 = SetProperty
            local Text = v50.Text
            v57(v48, v47, (tonumber(Text)))
        end)
    end
end

local v58

function SetPreviewColor(v59, v60, v61) -- line 529 | captures: v58
    if v61 or not v58 then
        if v61 then
            if not v58 then
                v58 = {}
                for v62, v63 in pairs(GetDecorations(v59)) do
                    v58[v63] = { [v60] = v63[v60] }
                end
            end
            for v64 in pairs(v58) do
                v64[v60] = v61
            end
        end
    else
        for v65, v66 in pairs(v58) do
            v65[v60] = v66[v60]
        end
        v58 = nil
    end
end

function SetProperty(v67, v68, v69) -- line 562
    if not v69 then
        return
    end
    TrackChange()
    for v70, v71 in pairs(GetDecorations(v67)) do
        local Before = HistoryRecord.Before
        local v72 = {
            Part = v71.Parent,
            DecorationType = v67
        }
        v72[v68] = v71[v68]
        table.insert(Before, v72)
        local After = HistoryRecord.After
        local v73 = {
            Part = v71.Parent,
            DecorationType = v67
        }
        v73[v68] = v69
        table.insert(After, v73)
    end
    RegisterChange()
end

function AddDecorations(v74) -- line 588
    local v75 = {}
    for v76, v77 in pairs(Selection.Parts) do
        if not Support.GetChildOfClass(v77, v74) then
            local v78 = {
                Part = v77,
                DecorationType = v74
            }
            table.insert(v75, v78)
        end
    end
    local v79 = {
        Decorations = Core.SyncAPI:Invoke("CreateDecorations", v75),
        Selection = Selection.Items,
        Unapply = function(v80) -- Unapply | line 614
            Selection.Replace(v80.Selection)
            Core.SyncAPI:Invoke("Remove", v80.Decorations)
        end,
        Apply = function(v81) -- Apply | line 625
            Core.SyncAPI:Invoke("UndoRemove", v81.Decorations)
            Selection.Replace(v81.Selection)
        end
    }
    Core.History.Add(v79)
    OpenOptions(v74)
end

function RemoveDecorations(v82) -- line 646
    local v83 = GetDecorations(v82)
    local v84 = {
        Decorations = v83,
        Selection = Selection.Items,
        Unapply = function(v85) -- Unapply | line 656
            Core.SyncAPI:Invoke("UndoRemove", v85.Decorations)
            Selection.Replace(v85.Selection)
        end,
        Apply = function(v86) -- Apply | line 667
            Selection.Replace(v86.Selection)
            Core.SyncAPI:Invoke("Remove", v86.Decorations)
        end
    }
    Core.SyncAPI:Invoke("Remove", v83)
    Core.History.Add(v84)
end

return v4
