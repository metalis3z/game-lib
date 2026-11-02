-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local ButtonHintStrip = require(ReplicatedStorage.Client.ButtonHintStrip)
local ClientGlobals = require(ReplicatedStorage.Client.ClientGlobals)
local GUI = require(ReplicatedStorage.Client.GUI)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local Log = require(ReplicatedStorage.Packages.Log)
local PlatformSignals = require(ReplicatedStorage.Client.PlatformSignals)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local v1 = table.freeze({ "Message", "ActivePets", "GrowingEggs" })
local v2 = table.freeze({ Message = true })
local v3 = table.freeze({
    BackpackGui = true,
    Treadmill = true,
    TreadmillScreenButtonSwapLeft = true,
    TreadmillScreenButtonSwapRight = true,
    TreadmillScreenComments = true,
    TreadmillUI = true
})
local ButtonL3 = Enum.KeyCode.ButtonL3
local ButtonB = Enum.KeyCode.ButtonB
local v4 = table.freeze({
    BackpackGui = true,
    TopbarCentered = true,
    TopbarCenteredClipped = true,
    TopbarStandard = true,
    TopbarStandardClipped = true
})
local v5 = Log.new()
local v6 = GUI.PlayerGui()
local v7 = {}
local v8 = {}
local v9 = {}
local v10 = {}
local v11
local v12 = false
local v13 = false

local function isVisible(v14) -- line 45 | captures: GamepadBindings
    return GamepadBindings.IsOnScreen(v14)
end

local function priorityScreen() -- line 48 | captures: v13, GUI, Tabs, v1
    for v15, v16 in v1 do
        local v17 = GUI.Get(v16)
        local ScreenGui = v17:IsA("ScreenGui")
        local v18 = ("%* must be a ScreenGui"):format(v16)
        assert(ScreenGui, v18)
        if v17.Enabled then
            return v17
        end
    end
    local v19 = Tabs.Current()
    if v19 == nil then
        if v13 then
            local v20 = GUI.HUD()
            local ScreenGui = v20:IsA("ScreenGui")
            assert(ScreenGui, "HUD must be a ScreenGui")
            if v20.Enabled then
                return v20
            end
        end
    else
        local v21 = GUI.Get(v19)
        local ScreenGui = v21:IsA("ScreenGui")
        local v22 = ("Tab %* must be a ScreenGui"):format(v19)
        assert(ScreenGui, v22)
        if v21.Enabled then
            return v21
        end
        if v13 then
            local v23 = GUI.HUD()
            local ScreenGui = v23:IsA("ScreenGui")
            assert(ScreenGui, "HUD must be a ScreenGui")
            if v23.Enabled then
                return v23
            end
        end
    end
    return nil
end

local function setHudNavigation(v24, v25) -- line 91 | captures: v13, GamepadBindings, ButtonL3, v5
    if v13 == v24 then
        return
    end
    v13 = v24
    GamepadBindings.EnableMarkers(not v24)
    local v26 = v5:AtDebug()
    local v27 = if v24 then "ON" else "OFF"
    v26:Log((("HUD navigation %* (%*); toggle key is %*"):format(v27, v25, ButtonL3.Name)))
end

local function restoreSelectableButtons() -- line 106 | captures: v7, v8
    for v28 in v8 do
        if v28.Parent ~= nil then
            v28.Selectable = v7[v28]
        end
        v8[v28] = nil
    end
end

local function precedes(v29, v30) -- line 117
    local v31 = v29:GetAttribute("InitialSelection") == true
    if v31 == (v30:GetAttribute("InitialSelection") == true) then
        if v29.Name == "Close" or v30.Name == "Close" then
            return v30.Name == "Close"
        end
        if v29.LayoutOrder == v30.LayoutOrder then
            if v29.AbsolutePosition.Y == v30.AbsolutePosition.Y then
                return v29.AbsolutePosition.X < v30.AbsolutePosition.X
            end
            return v29.AbsolutePosition.Y < v30.AbsolutePosition.Y
        end
        return v29.LayoutOrder < v30.LayoutOrder
    end
    return v31
end

local function projectSelectableButtons(v32) -- line 139 | captures: GamepadBindings, v7, v8, precedes
    local v33
    for v34, v35 in v32:GetDescendants() do
        if v35:IsA("GuiButton") and v35.Active and GamepadBindings.IsOnScreen(v35) and v35:GetAttribute("ConsoleNavigationDisabled") ~= true then
            if v7[v35] == nil then
                v7[v35] = v35.Selectable
            end
            v35.Selectable = true
            v8[v35] = true
            if v33 == nil then
                v33 = v35
            elseif precedes(v35, v33) then
            end
        end
    end
    return v33
end

local function isEligibleSelection(v36, v37) -- line 156 | captures: GamepadBindings
    if v37 == nil then
        return false
    end
    return v37:IsDescendantOf(v36) and v37:IsA("GuiButton") and v37.Selectable and v37.Active and GamepadBindings.IsOnScreen(v37)
end

local function isExternalNavigationSelection(v38) -- line 175 | captures: v4
    if v38 == nil then
        return false
    end
    local LayerCollector = v38:FindFirstAncestorWhichIsA("LayerCollector")
    if LayerCollector == nil then
        return false
    end
    return v4[LayerCollector.Name] == true
end

local function reconcile() -- line 183 | captures: v11, v12, v13, GuiService, ButtonHintStrip, ClientGlobals, GamepadBindings, v2, ButtonL3, v4, v5, v7, v8, v9, priorityScreen, projectSelectableButtons
    if v12 then
        return
    end
    v12 = true
    for v39 in v8 do
        if v39.Parent ~= nil then
            v39.Selectable = v7[v39]
        end
        v8[v39] = nil
    end
    if ClientGlobals.Console then
        local v40 = priorityScreen()
        if v40 ~= nil and v40.Name ~= "HUD" then
            local v41 = ("%* took focus"):format(v40.Name)
            if v13 ~= false then
                v13 = false
                GamepadBindings.EnableMarkers(true)
                v5:AtDebug():Log((("HUD navigation OFF (%*); toggle key is %*"):format(v41, ButtonL3.Name)))
            end
        end
        if v40 == nil then
            local v42 = if v13 then "Close Menus" else "Menus"
            ButtonHintStrip.Present("HudNavigation", ButtonL3, v42)
        elseif v40.Name ~= "HUD" then
            ButtonHintStrip.Retract("HudNavigation")
        end
        v11 = v40
        GamepadBindings.FocusScreen(v40)
        if v40 == nil then
            local SelectedObject = GuiService.SelectedObject
            local v43
            if SelectedObject == nil then
                v43 = false
            else
                local LayerCollector = SelectedObject:FindFirstAncestorWhichIsA("LayerCollector")
                if LayerCollector == nil then
                    v43 = false
                else
                    v43 = v4[LayerCollector.Name] == true
                end
            end
            if v43 then
                GuiService.GuiNavigationEnabled = true
            else
                GuiService.SelectedObject = nil
                GuiService.GuiNavigationEnabled = false
            end
        elseif v2[v40.Name] then
            GuiService.SelectedObject = nil
            GuiService.GuiNavigationEnabled = false
        else
            local v44 = projectSelectableButtons(v40)
            local SelectedObject = GuiService.SelectedObject
            local v45
            if SelectedObject ~= nil and SelectedObject:IsDescendantOf(v40) and SelectedObject:IsA("GuiButton") and SelectedObject.Selectable and SelectedObject.Active and GamepadBindings.IsOnScreen(SelectedObject) then
                v45 = SelectedObject
            else
                local v46 = v9[v40]
                if v46 ~= nil and v46:IsDescendantOf(v40) and v46:IsA("GuiButton") and v46.Selectable and v46.Active and GamepadBindings.IsOnScreen(v46) then
                    v45 = v46
                else
                    v45 = v44
                end
            end
            GuiService.SelectedObject = v45
            local v47 = v45 ~= nil
            GuiService.GuiNavigationEnabled = v47
        end
    else
        ButtonHintStrip.Retract("HudNavigation")
        if v13 ~= false then
            v13 = false
            GamepadBindings.EnableMarkers(true)
            v5:AtDebug():Log((("HUD navigation OFF (left console platform); toggle key is %*"):format(ButtonL3.Name)))
        end
        v11 = nil
        GamepadBindings.FocusScreen(nil)
        GuiService.SelectedObject = nil
        GuiService.GuiNavigationEnabled = false
    end
    v12 = false
end

local function requestReconcile() -- line 304 | captures: reconcile
    task.defer(reconcile)
end

local function observe(v48) -- line 307 | captures: GamepadBindings, v3, v7, v8, v9, v10, reconcile, requestReconcile
    if v10[v48] then
        return
    end
    v10[v48] = true
    local v49
    if v48:IsA("ScreenGui") then
        v49 = v48
    else
        v49 = v48:FindFirstAncestorOfClass("ScreenGui")
    end
    if v49 == nil or not v3[v49.Name] then
        GamepadBindings.Inspect(v48)
    end
    if v48:IsA("ScreenGui") then
        v48:GetPropertyChangedSignal("Enabled"):Connect(requestReconcile)
    elseif v48:IsA("GuiObject") then
        v48:GetPropertyChangedSignal("Visible"):Connect(requestReconcile)
        if v48:IsA("GuiButton") then
            v48:GetPropertyChangedSignal("Active"):Connect(requestReconcile)
        end
    end
    v48.Destroying:Once(function() -- line 334 | captures: v48, v7, v8, v9, v10, reconcile
        v10[v48] = nil
        if v48:IsA("ScreenGui") then
            v9[v48] = nil
        elseif v48:IsA("GuiButton") then
            v7[v48] = nil
            v8[v48] = nil
        end
        if v48:IsA("GuiObject") then
            for v50, v51 in v9 do
                if v51 == v48 then
                    v9[v50] = nil
                end
            end
        end
        task.defer(reconcile)
    end)
end

for v52, v53 in v6:GetDescendants() do
    observe(v53)
end
for v54, v55 in v6:GetChildren() do
    observe(v55)
end
v6.DescendantAdded:Connect(function(v56) -- line 361 | captures: reconcile, observe
    observe(v56)
    task.defer(reconcile)
end)
v6.DescendantRemoving:Connect(requestReconcile)
GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(function() -- line 367 | captures: v11, GuiService, ClientGlobals, GamepadBindings, v4, v9
    local v57 = v11
    local SelectedObject = GuiService.SelectedObject
    if v57 == nil then
        if ClientGlobals.Console and v57 == nil then
            local v58
            if SelectedObject == nil then
                v58 = false
            else
                local LayerCollector = SelectedObject:FindFirstAncestorWhichIsA("LayerCollector")
                if LayerCollector == nil then
                    v58 = false
                else
                    v58 = v4[LayerCollector.Name] == true
                end
            end
            GuiService.GuiNavigationEnabled = v58
        end
    elseif SelectedObject ~= nil and SelectedObject:IsDescendantOf(v57) and SelectedObject:IsA("GuiButton") and SelectedObject.Selectable and SelectedObject.Active and GamepadBindings.IsOnScreen(SelectedObject) then
        v9[v57] = SelectedObject
    end
end)
PlatformSignals.Changed:Connect(requestReconcile)
Tabs.Shown:Connect(requestReconcile)
Tabs.Hidden:Connect(requestReconcile)
UserInputService.InputBegan:Connect(function(v59, v60) -- line 408 | captures: v13, ClientGlobals, GamepadBindings, ButtonL3, ButtonB, v5, reconcile
    if ClientGlobals.Console and not v60 then
        if v59.KeyCode == ButtonL3 then
            local v61 = not v13
            local v62 = ("pressed %*"):format(v59.KeyCode.Name)
            if v13 ~= v61 then
                v13 = v61
                GamepadBindings.EnableMarkers(not v61)
                local v63 = v5:AtDebug()
                local v64 = if v61 then "ON" else "OFF"
                v63:Log((("HUD navigation %* (%*); toggle key is %*"):format(v64, v62, ButtonL3.Name)))
            end
            task.defer(reconcile)
        elseif v59.KeyCode == ButtonB and v13 then
            local v65 = ("pressed %*"):format(v59.KeyCode.Name)
            if v13 ~= false then
                v13 = false
                GamepadBindings.EnableMarkers(true)
                v5:AtDebug():Log((("HUD navigation OFF (%*); toggle key is %*"):format(v65, ButtonL3.Name)))
            end
            task.defer(reconcile)
        end
    end
end)
GuiService.AutoSelectGuiEnabled = false
GamepadBindings.Rescan(ClientGlobals.Platform)
reconcile()
v5:AtInfo():Log("Console navigation initialized")
