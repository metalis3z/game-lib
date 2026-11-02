-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Parent = script.Parent.Parent.Parent
local Libraries = Parent:WaitForChild("Libraries")
local Core = require(Parent.Core)
local Selection = Core.Selection
local v1 = require(Libraries:WaitForChild("SupportLibrary"))
local v2 = require(Libraries:WaitForChild("Maid"))
local v3 = require(Parent.Core:WaitForChild("ListenForManualWindowTrigger"))
local v4 = {}

v4.__index = v4

function v4.new(v5) -- line 17 | captures: v2, v4
    local v6 = {
        UI = nil,
        Tool = v5,
        Maid = v2.new()
    }
    return (setmetatable(v6, v4))
end

function v4.ShowUI(v7) -- line 29 | captures: Core, v1, v3
    if v7.UI then
        v7.UI.Visible = true
    else
        v7.UI = Core.Tool.Interfaces.BTMoveToolGUI:Clone()
        v7.UI.Parent = Core.UI
        v7.UI.Visible = true
        local AxesOption = v7.UI.AxesOption
        AxesOption.Global.Button.MouseButton1Down:Connect(function() -- line 48 | captures: v7
            v7.Tool:SetAxes("Global")
        end)
        AxesOption.Local.Button.MouseButton1Down:Connect(function() -- line 51 | captures: v7
            v7.Tool:SetAxes("Local")
        end)
        AxesOption.Last.Button.MouseButton1Down:Connect(function() -- line 54 | captures: v7
            v7.Tool:SetAxes("Last")
        end)
        local TextBox = v7.UI.IncrementOption.Increment.TextBox
        TextBox.FocusLost:Connect(function(v8) -- line 60 | captures: v7, TextBox, v1
            local Tool = v7.Tool
            local Text = TextBox.Text
            Tool.Increment = tonumber(Text) or v7.Tool.Increment
            TextBox.Text = v1.Round(v7.Tool.Increment, 4)
        end)
        local TextBox_2 = v7.UI.Info.Center.X.TextBox
        local TextBox_3 = v7.UI.Info.Center.Y.TextBox
        local TextBox_4 = v7.UI.Info.Center.Z.TextBox
        TextBox_2.FocusLost:Connect(function(v9) -- line 69 | captures: v7, TextBox_2
            local Text = TextBox_2.Text
            local v10 = tonumber(Text)
            if v10 then
                v7.Tool:SetAxisPosition("X", v10)
            end
        end)
        TextBox_3.FocusLost:Connect(function(v11) -- line 75 | captures: v7, TextBox_3
            local Text = TextBox_3.Text
            local v12 = tonumber(Text)
            if v12 then
                v7.Tool:SetAxisPosition("Y", v12)
            end
        end)
        TextBox_4.FocusLost:Connect(function(v13) -- line 81 | captures: v7, TextBox_4
            local Text = TextBox_4.Text
            local v14 = tonumber(Text)
            if v14 then
                v7.Tool:SetAxisPosition("Z", v14)
            end
        end)
        local Signature = v7.UI:WaitForChild("Title"):WaitForChild("Signature")
        v3(v7.Tool.ManualText, v7.Tool.Color.Color, Signature)
    end
    v7.Maid.UIUpdater = v1.Loop(0.1, v7.UpdateUI, v7)
    v7:AttachDragListener()
    v7:AttachAxesListener()
end

local function AttachDragListener(v15) -- line 101
    v15.Maid.DragListener = v15.Tool.DragChanged:Connect(function(v16) -- line 102 | captures: v15
        v15.UI.Changes.Text.Text = "moved " .. math.abs(v16) .. " studs"
    end)
end

v4.AttachDragListener = AttachDragListener

function v4.AttachAxesListener(v17) -- line 110 | captures: Core
    v17.Maid.AxesListener = v17.Tool.AxesChanged:Connect(function(v18) -- line 111 | captures: v17, Core
        Core.ToggleSwitch(v18, v17.UI.AxesOption)
    end)
end

local function HideUI(v19) -- line 119
    if v19.UI then
        v19.UI.Visible = false
        v19.Maid:Destroy()
    end
end

v4.HideUI = HideUI

function v4.UpdateUI(v20) -- line 135 | captures: Selection, v1
    local function v21(v22, ...)
        table.insert(v22, ...)
    end

    local function v23(v24, ...)
        table.insert(v24, ...)
    end

    local function v25(v26, ...)
        table.insert(v26, ...)
    end

    if v20.UI then
        if #Selection.Parts == 0 then
            v20.UI.Info.Visible = false
            v20.UI.Size = UDim2.new(0, 245, 0, 90)
        else
            v20.UI.Info.Visible = true
            v20.UI.Size = UDim2.new(0, 245, 0, 150)
            local v27 = {}
            local v28 = {}
            local v29 = {}
            for v30, v31 in pairs(Selection.Parts) do
                v21(v27, v1.Round(v31.Position.X, 3))
                v23(v28, v1.Round(v31.Position.Y, 3))
                v25(v29, v1.Round(v31.Position.Z, 3))
            end
            local v32 = v1.IdentifyCommonItem(v27)
            local v33 = v1.IdentifyCommonItem(v28)
            local v34 = v1.IdentifyCommonItem(v29)
            local TextBox = v20.UI.Info.Center.X.TextBox
            local TextBox_2 = v20.UI.Info.Center.Y.TextBox
            local TextBox_3 = v20.UI.Info.Center.Z.TextBox
            if not TextBox:IsFocused() then
                TextBox.Text = v32 or "*"
            end
            if not TextBox_2:IsFocused() then
                TextBox_2.Text = v33 or "*"
            end
            if not TextBox_3:IsFocused() then
                TextBox_3.Text = v34 or "*"
            end
        end
    end
end

local function FocusIncrementInput(v35) -- line 186
    v35.UI.IncrementOption.Increment.TextBox:CaptureFocus()
end

v4.FocusIncrementInput = FocusIncrementInput
return v4
