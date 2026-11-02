-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local GuiService = game:GetService("GuiService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local ClientGlobals = require(ReplicatedStorage.Client.ClientGlobals)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local GUI = require(ReplicatedStorage.Client.GUI)
local InfoOverlay = require(ReplicatedStorage.Client.InfoOverlay)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local v1 = UDim2.fromScale(0.5, 0.5)
local v2 = { Message = true }
local v3 = {
    0.15,
    Enum.EasingStyle.Circular,
    Enum.EasingDirection.Out
}
local v4 = {
    0.15,
    Enum.EasingStyle.Circular,
    Enum.EasingDirection.Out
}
local v5 = {
    0.25,
    Enum.EasingStyle.Sine,
    Enum.EasingDirection.Out
}
local v6 = {
    Shown = Signal.new(),
    Hidden = Signal.new()
}
local CurrentCamera = Workspace.CurrentCamera
local FieldOfView = CurrentCamera.FieldOfView
local v7
local v8 = {}
local DepthOfFieldEffect = Instance.new("DepthOfFieldEffect")

DepthOfFieldEffect.Name = "TabDepthBlur"
DepthOfFieldEffect.FarIntensity = 0.755
DepthOfFieldEffect.FocusDistance = 200
DepthOfFieldEffect.InFocusRadius = 13.25
DepthOfFieldEffect.NearIntensity = 0
DepthOfFieldEffect.Enabled = false
DepthOfFieldEffect.Parent = Lighting

local function screenFor(v9) -- line 36 | captures: GUI
    local v10 = GUI.Get(v9)
    local ScreenGui = v10:IsA("ScreenGui")
    local v11 = ("tab %* must resolve to a ScreenGui"):format(v9)
    assert(ScreenGui, v11)
    return v10
end

local function bodyFor(v12) -- line 42
    local v13 = v12:FindFirstChildOfClass("Frame") or v12:FindFirstChildWhichIsA("ImageLabel")
    local v14 = ("tab %* has no GuiObject body"):format(v12.Name)
    assert(v13, v14)
    local UIScale = v13:FindFirstChildOfClass("UIScale")
    if not UIScale then
        UIScale = Instance.new("UIScale")
        UIScale.Name = "TabScale"
        UIScale.Parent = v13
    end
    return v13, UIScale
end

local function setPlayerListVisible(v15) -- line 56 | captures: StarterGui
    if StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) ~= v15 then
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, v15)
    end
end

local function hidesPlayerList() -- line 61 | captures: ClientGlobals, CurrentCamera
    return ClientGlobals.Mobile and CurrentCamera.ViewportSize.Y > 550
end

local function wireCloseButton(v16, v17) -- line 68 | captures: ButtonFX, GamepadBindings, GUI, v6, v8
    if v8[v16] then
        return
    end
    local Frame = v17:FindFirstChildWhichIsA("Frame")
    local v18 = v17:FindFirstChild("Close") or Frame and Frame:FindFirstChild("Close")
    if v18 then
        local GuiButton = v18:IsA("GuiButton")
        local v19 = ("%*.Close must be a GuiButton"):format(v16.Name)
        assert(GuiButton, v19)
        GamepadBindings.Inspect(v18)
        GUI.ButtonActivated(v18, function() -- line 87 | captures: v6
            v6.Dismiss()
        end)
        ButtonFX(v18, 1.08)
    end
    v8[v16] = true
end

local function closeCurrent(v20, v21) -- line 93 | captures: v7, GuiService, StarterGui, ClientGlobals, GUI, InfoOverlay, Tween, v3, v5, v6, CurrentCamera, FieldOfView, DepthOfFieldEffect, bodyFor
    local v22 = v7
    if v22 == nil then
        return
    end
    v7 = nil
    GuiService.SelectedObject = nil
    GuiService.GuiNavigationEnabled = false
    local v23 = GUI.Get(v22)
    local ScreenGui = v23:IsA("ScreenGui")
    local v24 = ("tab %* must resolve to a ScreenGui"):format(v22)
    assert(ScreenGui, v24)
    local v25, v26 = bodyFor(v23)
    if v20 then
        v26.Scale = 0.85
        v23.Enabled = false
        if v7 == nil then
            DepthOfFieldEffect.Enabled = false
            if ClientGlobals.Mobile and CurrentCamera.ViewportSize.Y > 550 and StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) ~= true then
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
            end
        end
    else
        Tween(v25, { Position = UDim2.new(0.5, 0, 0.6, v25.Position.Y.Offset) }, v3).Completed:Once(function() -- line 108 | captures: v23, v7, StarterGui, ClientGlobals, CurrentCamera, DepthOfFieldEffect
            v23.Enabled = false
            if v7 ~= nil then
                return
            end
            DepthOfFieldEffect.Enabled = false
            if ClientGlobals.Mobile and CurrentCamera.ViewportSize.Y > 550 and StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) ~= true then
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
            end
        end)
        Tween(v26, { Scale = 0.85 }, v3)
        Tween(CurrentCamera, { FieldOfView = FieldOfView }, v5)
        Tween(DepthOfFieldEffect, { FocusDistance = 200 }, v5)
    end
    InfoOverlay.Dismiss()
    v6.Hidden:Fire(v22, v21, v20)
end

function v6.Current() -- line 141 | captures: v7
    return v7
end

function v6.IsShowing(v27) -- line 144 | captures: v7
    if v27 == nil then
        return v7 ~= nil
    end
    return v7 == v27
end

function v6.Show(v28, v29) -- line 153 | captures: v7, GuiService, StarterGui, ClientGlobals, GUI, InfoOverlay, Tween, v1, v2, v4, v5, v6, CurrentCamera, DepthOfFieldEffect, bodyFor, wireCloseButton
    if v7 == v28 then
        return false
    end
    local v30, v31
    if v7 == nil then
        v31 = true
    else
        v30 = v7
        if v30 == nil then
            v31 = true
        else
            v7 = nil
            GuiService.SelectedObject = nil
            GuiService.GuiNavigationEnabled = false
            local v32 = GUI.Get(v30)
            local ScreenGui = v32:IsA("ScreenGui")
            local v33 = ("tab %* must resolve to a ScreenGui"):format(v30)
            assert(ScreenGui, v33)
            local v34, v35 = bodyFor(v32)
            _ = v34

            local function finish() -- line 170 | captures: v32, v7, StarterGui, ClientGlobals, CurrentCamera, DepthOfFieldEffect
                v32.Enabled = false
                if v7 ~= nil then
                    return
                end
                DepthOfFieldEffect.Enabled = false
                if ClientGlobals.Mobile and CurrentCamera.ViewportSize.Y > 550 and StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) ~= true then
                    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
                end
            end

            v35.Scale = 0.85
            v32.Enabled = false
            if v7 == nil then
                DepthOfFieldEffect.Enabled = false
                if ClientGlobals.Mobile and CurrentCamera.ViewportSize.Y > 550 and StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) ~= true then
                    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
                end
            end
            v31 = false
        end
    end
    if not v31 then
        InfoOverlay.Dismiss()
        v6.Hidden:Fire(v30, v28, true)
    end
    local v36 = GUI.Get(v28)
    local ScreenGui = v36:IsA("ScreenGui")
    local v37 = ("tab %* must resolve to a ScreenGui"):format(v28)
    assert(ScreenGui, v37)
    local v38, v39 = bodyFor(v36)
    wireCloseButton(v36, v38)
    v36.Enabled = true
    v7 = v28
    DepthOfFieldEffect.Enabled = true
    if v29 then
        v38.Position = v1
        v39.Scale = 1
        DepthOfFieldEffect.FocusDistance = 5
        if not v2[v28] then
            CurrentCamera.FieldOfView = 76
        end
    else
        v38.Position = UDim2.new(0.5, 0, 0.6, v38.Position.Y.Offset)
        v39.Scale = 0.975
        DepthOfFieldEffect.FocusDistance = 200
        Tween(v38, { Position = v1 }, v4)
        Tween(v39, { Scale = 1 }, v4)
        Tween(DepthOfFieldEffect, { FocusDistance = 5 }, v5)
        if not v2[v28] then
            Tween(CurrentCamera, { FieldOfView = 76 }, v5)
        end
    end
    if ClientGlobals.Mobile and CurrentCamera.ViewportSize.Y > 550 and StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) ~= false then
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
    end
    local v40 = v29 == true
    v6.Shown:Fire(v28, v40)
    return true
end

function v6.Dismiss(v41) -- line 237 | captures: closeCurrent
    local v42 = v41 == true
    closeCurrent(v42, nil)
end

function v6.Toggle(v43) -- line 241 | captures: v7, v6
    if v7 == v43 then
        v6.Dismiss()
    else
        v6.Show(v43)
    end
end

return table.freeze(v6)
