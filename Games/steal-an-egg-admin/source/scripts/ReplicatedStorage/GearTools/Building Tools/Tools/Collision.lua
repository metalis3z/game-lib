-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

Tool = script.Parent.Parent
Core = require(Tool.Core)

local v1 = require(Tool.Core:WaitForChild("ListenForManualWindowTrigger"))

Selection = Core.Selection
Support = Core.Support
Security = Core.Security
Support.ImportServices()
local v2 = {
    Name = "Collision Tool",
    Color = BrickColor.new("Really black")
}

v2.ManualText = "<font face=\"GothamBlack\" size=\"16\">Collision Tool  \240\159\155\160</font>\nLets you change whether parts collide with one another.<font size=\"6\"><br /></font>\n\n<b>TIP:</b> Press <b>Enter</b> to toggle collision quickly."

local v3 = {}

local function Equip() -- line 27
    ShowUI()
    BindShortcutKeys()
end

v2.Equip = Equip

local function Unequip() -- line 36
    HideUI()
    ClearConnections()
end

v2.Unequip = Unequip

function ClearConnections() -- line 45 | captures: v3
    for v4, v5 in pairs(v3) do
        v5:Disconnect()
        v3[v4] = nil
    end
end

function ShowUI() -- line 55 | captures: v1, v2
    if UI then
        UI.Visible = true
    else
        UI = Core.Tool.Interfaces.BTCollisionToolGUI:Clone()
        UI.Parent = Core.UI
        UI.Visible = true
        local Button = UI.Status.On.Button
        local Button_2 = UI.Status.Off.Button
        Button.MouseButton1Click:Connect(function() -- line 82
            SetProperty("CanCollide", true)
        end)
        Button_2.MouseButton1Click:Connect(function() -- line 85
            SetProperty("CanCollide", false)
        end)
        local Signature = UI:WaitForChild("Title"):WaitForChild("Signature")
        v1(v2.ManualText, v2.Color.Color, Signature)
    end
    UIUpdater = Support.ScheduleRecurringTask(UpdateUI, 0.1)
end

function UpdateUI() -- line 98
    if UI then
        local CanCollide = Support.IdentifyCommonProperty(Selection.Parts, "CanCollide")
        if CanCollide == true then
            Core.ToggleSwitch("On", UI.Status)
        elseif CanCollide == false then
            Core.ToggleSwitch("Off", UI.Status)
        elseif CanCollide == nil then
            Core.ToggleSwitch(nil, UI.Status)
        end
    end
end

function HideUI() -- line 124
    if UI then
        UI.Visible = false
        UIUpdater:Stop()
    end
end

function SetProperty(v6, v7) -- line 140
    if v7 == nil then
        return
    end
    TrackChange()
    for v8, v9 in pairs(Selection.Parts) do
        local Before = HistoryRecord.Before
        local v10 = { Part = v9 }
        v10[v6] = v9[v6]
        table.insert(Before, v10)
        local After = HistoryRecord.After
        local v11 = { Part = v9 }
        v11[v6] = v7
        table.insert(After, v11)
    end
    RegisterChange()
end

function BindShortcutKeys() -- line 166 | captures: v3
    local function v12(v13, ...)
        table.insert(v13, ...)
    end

    v12(v3, UserInputService.InputBegan:Connect(function(v14, v15) -- line 170
        if not v15 and v14.UserInputType == Enum.UserInputType.Keyboard and not UserInputService:GetFocusedTextBox() and (v14.KeyCode == Enum.KeyCode.Return or v14.KeyCode == Enum.KeyCode.KeypadEnter) then
            ToggleCollision()
        end
    end))
end

function ToggleCollision() -- line 199
    SetProperty("CanCollide", not Support.IdentifyCommonProperty(Selection.Parts, "CanCollide"))
end

function TrackChange() -- line 207
    HistoryRecord = {
        Before = {},
        After = {},
        Selection = Selection.Items,
        Unapply = function(v16) -- Unapply | line 215
            Selection.Replace(v16.Selection)
            Core.SyncAPI:Invoke("SyncCollision", v16.Before)
        end,
        Apply = function(v17) -- Apply | line 226
            Selection.Replace(v17.Selection)
            Core.SyncAPI:Invoke("SyncCollision", v17.After)
        end
    }
end

function RegisterChange() -- line 241
    if not HistoryRecord then
        return
    end
    Core.SyncAPI:Invoke("SyncCollision", HistoryRecord.After)
    Core.History.Add(HistoryRecord)
    HistoryRecord = nil
end

return v2
