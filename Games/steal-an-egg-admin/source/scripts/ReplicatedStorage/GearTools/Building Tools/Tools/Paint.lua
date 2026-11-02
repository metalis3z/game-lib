-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

Tool = script.Parent.Parent
Core = require(Tool.Core)

local Vendor = Tool:WaitForChild("Vendor")
local UI = Tool:WaitForChild("UI")
local Libraries = Tool:WaitForChild("Libraries")
local v1 = require(Libraries:WaitForChild("Maid"))
local v2 = require(script:WaitForChild("PaintHistoryRecord"))
local v3 = require(Tool.Core:WaitForChild("ListenForManualWindowTrigger"))
local v4 = require(Vendor:WaitForChild("Roact"))
local v5 = require(UI:WaitForChild("ColorPicker"))

Selection = Core.Selection
Support = Core.Support
Security = Core.Security
Support.ImportServices()
local v6 = {
    Name = "Paint Tool",
    BrickColor = nil,
    Color = BrickColor.new("Really red")
}

v6.ManualText = "<font face=\"GothamBlack\" size=\"16\">Paint Tool  \240\159\155\160</font>\nLets you paint parts in different colors.<font size=\"6\"><br /></font>\n\n<b>TIP:</b> Press <b><i>R</i></b> while hovering over a part to copy its color."

function v6.Equip(v7) -- line 35 | captures: v1
    v7.Maid = v1.new()
    ShowUI()
    v7:BindShortcutKeys()
    v7:EnableClickPainting()
end

local function Unequip(v8) -- line 48
    HideUI()
    v8.Maid = v8.Maid:Destroy()
end

v6.Unequip = Unequip

function ShowUI() -- line 59 | captures: v3, v4, v5, v6
    if v6.UI then
        v6.UI.Visible = true
    else
        v6.UI = Core.Tool.Interfaces.BTPaintToolGUI:Clone()
        v6.UI.Parent = Core.UI
        v6.UI.Visible = true
        PaletteButtons = {}
        for v9, v10 in pairs(v6.UI.Palette:GetChildren()) do
            for v11, v12 in pairs(v10:GetChildren()) do
                if v12.ClassName == "TextButton" then
                    local MouseButton1Click = v12.MouseButton1Click
                    local v13 = v12
                    MouseButton1Click:Connect(function() -- line 90 | captures: v13
                        SetColor(BrickColor.new(v13.Name).Color)
                    end)
                    PaletteButtons[v12.Name] = v12
                end
            end
        end
        v6.UI.Controls.LastColorButton.MouseButton1Click:Connect(PaintParts)
        local v14
        v6.UI.Controls.ColorPickerButton.MouseButton1Click:Connect(function() -- line 106 | captures: v14, v4, v5
            local Color = Support.IdentifyCommonProperty(Selection.Parts, "Color")
            local createElement = v4.createElement
            local v15 = {}
            v15.InitialColor = Color or Color3.fromRGB(255, 255, 255)
            v15.SetPreviewColor = PreviewColor

            function v15.OnConfirm(v16) -- line 111 | captures: v14, v4
                SetColor(v16)
                v14 = v4.unmount(v14)
            end

            function v15.OnCancel() -- line 115 | captures: v14, v4
                v14 = v4.unmount(v14)
            end

            local v17 = createElement(v5, v15)
            v14 = v14 and v4.update(v14, v17) or v4.mount(v17, Core.UI, "ColorPicker")
        end)
        local Signature = v6.UI:WaitForChild("Title"):WaitForChild("Signature")
        v3(v6.ManualText, v6.Color.Color, Signature)
    end
    UIUpdater = Support.ScheduleRecurringTask(UpdateUI, 0.1)
end

function HideUI() -- line 133 | captures: v6
    if v6.UI then
        v6.UI.Visible = false
        UIUpdater:Stop()
    end
end

function UpdateUI() -- line 149 | captures: v6
    if not v6.UI then
        return
    end
    for v18, v19 in pairs(PaletteButtons) do
        v19.Text = ""
    end
    for v20, v21 in pairs(Selection.Parts) do
        if PaletteButtons[v21.BrickColor.Name] and v21.Color == v21.BrickColor.Color then
            PaletteButtons[v21.BrickColor.Name].Text = "+"
        end
    end
    local Color = Support.IdentifyCommonProperty(Selection.Parts, "Color")
    v6.UI.Controls.ColorPickerButton.ImageColor3 = Color or v6.BrickColor or Color3.new(1, 0, 0)
end

function SetColor(v22) -- line 179 | captures: v6
    v6.BrickColor = v22
    local v23 = BrickColor.new(v22)
    local v24 = ("(%d, %d, %d)"):format(v22.r * 255, v22.g * 255, v22.b * 255)
    v24 = v23.Color == v22 and v23.Name or v24
    local ColorName = v6.UI.Controls.LastColorButton.ColorName
    local ColorSquare = ColorName.ColorSquare
    ColorName.Visible = true
    ColorName.Text = v24
    ColorSquare.BackgroundColor3 = v22
    ColorSquare.Position = UDim2.new(1, -ColorName.TextBounds.X - 18, 0.2, 1)
    PaintParts()
end

function PaintParts() -- line 205 | captures: v2, v6
    if not v6.BrickColor or #Selection.Parts == 0 then
        return
    end
    local v25 = v2.new()
    v25.TargetColor = v6.BrickColor
    v25:Apply(true)
    Core.History.Add(v25)
end

function PreviewColor(v26) -- line 225
    if v26 or not InitialState then
        if v26 then
            if not InitialState then
                InitialState = {}
                for v27, v28 in pairs(Selection.Parts) do
                    local v29 = InitialState
                    local v30 = { Color = v28.Color }
                    v30.UsePartColor = v28.ClassName == "UnionOperation" and v28.UsePartColor or nil
                    v29[v28] = v30
                end
            end
            for v31, v32 in pairs(Selection.Parts) do
                v32.Color = v26
                if v32.ClassName == "UnionOperation" then
                    v32.UsePartColor = true
                end
            end
        end
    else
        for v33, v34 in pairs(InitialState) do
            v33.Color = v34.Color
            if v33.ClassName == "UnionOperation" then
                v33.UsePartColor = v34.UsePartColor
            end
        end
        InitialState = nil
    end
end

local function BindShortcutKeys(v35) -- line 271
    v35.Maid.Hotkeys = Support.AddUserInputListener("Began", "Keyboard", false, function(v36) -- line 275
        if v36.KeyCode.Name == "Return" or v36.KeyCode.Name == "KeypadEnter" then
            return PaintParts()
        end
        if v36.KeyCode.Name == "R" and not Selection.Multiselecting and Core.Mouse.Target then
            SetColor(Core.Mouse.Target.Color)
        end
    end)
end

v6.BindShortcutKeys = BindShortcutKeys

local function EnableClickPainting(v37) -- line 296
    v37.Maid.ClickPainting = Selection.FocusChanged:Connect(function(v38) -- line 300
        local v39, v40 = Core.Targeting:UpdateTarget()
        if Selection.IsSelected(v40) then
            PaintParts()
        end
    end)
end

v6.EnableClickPainting = EnableClickPainting
return v6
