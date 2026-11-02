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
    Name = "Anchor Tool",
    Color = BrickColor.new("Really black")
}

v2.ManualText = "<font face=\"GothamBlack\" size=\"16\">Anchor Tool  \240\159\155\160</font>\nLets you anchor and unanchor parts.<font size=\"6\"><br /></font>\n\n<b>TIP:</b> Press <b>Enter</b> to toggle anchor quickly."

local v3 = {}

local function Equip() -- line 29
    ShowUI()
    BindShortcutKeys()
end

v2.Equip = Equip

local function Unequip() -- line 38
    HideUI()
    ClearConnections()
end

v2.Unequip = Unequip

function ClearConnections() -- line 47 | captures: v3
    for v4, v5 in pairs(v3) do
        v5:Disconnect()
        v3[v4] = nil
    end
end

function ShowUI() -- line 57 | captures: v1, v2
    if UI then
        UI.Visible = true
    else
        UI = Core.Tool.Interfaces.BTAnchorToolGUI:Clone()
        UI.Parent = Core.UI
        UI.Visible = true
        local Button = UI.Status.Anchored.Button
        local Button_2 = UI.Status.Unanchored.Button
        Button.MouseButton1Click:Connect(function() -- line 84
            SetProperty("Anchored", true)
        end)
        Button_2.MouseButton1Click:Connect(function() -- line 87
            SetProperty("Anchored", false)
        end)
        local Signature = UI:WaitForChild("Title"):WaitForChild("Signature")
        v1(v2.ManualText, v2.Color.Color, Signature)
    end
    UIUpdater = Support.ScheduleRecurringTask(UpdateUI, 0.1)
end

function UpdateUI() -- line 100
    if UI then
        local Anchored = Support.IdentifyCommonProperty(Selection.Parts, "Anchored")
        if Anchored == true then
            Core.ToggleSwitch("Anchored", UI.Status)
        elseif Anchored == false then
            Core.ToggleSwitch("Unanchored", UI.Status)
        elseif Anchored == nil then
            Core.ToggleSwitch(nil, UI.Status)
        end
    end
end

function HideUI() -- line 126
    if UI then
        UI.Visible = false
        UIUpdater:Stop()
    end
end

function SetProperty(v6, v7) -- line 142
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

function BindShortcutKeys() -- line 168 | captures: v3
    local function v12(v13, ...)
        table.insert(v13, ...)
    end

    v12(v3, UserInputService.InputBegan:Connect(function(v14, v15) -- line 172
        if not v15 and v14.UserInputType == Enum.UserInputType.Keyboard and not UserInputService:GetFocusedTextBox() and (v14.KeyCode == Enum.KeyCode.Return or v14.KeyCode == Enum.KeyCode.KeypadEnter) then
            ToggleAnchors()
        end
    end))
end

function ToggleAnchors() -- line 201
    SetProperty("Anchored", not Support.IdentifyCommonProperty(Selection.Parts, "Anchored"))
end

function TrackChange() -- line 209
    HistoryRecord = {
        Before = {},
        After = {},
        Selection = Selection.Items,
        Unapply = function(v16) -- Unapply | line 217
            Selection.Replace(v16.Selection)
            Core.SyncAPI:Invoke("SyncAnchor", v16.Before)
        end,
        Apply = function(v17) -- Apply | line 228
            Selection.Replace(v17.Selection)
            Core.SyncAPI:Invoke("SyncAnchor", v17.After)
        end
    }
end

function RegisterChange() -- line 243
    if not HistoryRecord then
        return
    end
    Core.SyncAPI:Invoke("SyncAnchor", HistoryRecord.After)
    Core.History.Add(HistoryRecord)
    HistoryRecord = nil
end

return v2
