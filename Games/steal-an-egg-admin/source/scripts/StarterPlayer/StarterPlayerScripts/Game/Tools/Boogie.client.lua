-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ToolSetup = require(ReplicatedStorage.Client.Util.ToolSetup)
local t = require(ReplicatedStorage.Packages.t)
require(ReplicatedStorage.Shared.Globals.Constants)
local v1 = require(ReplicatedStorage.Packages.Log).new()
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ShakePresets = require(ReplicatedStorage.Client.Modules.ShakePresets)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Boogie = require(ReplicatedStorage.Data.Gears).Directory.Boogie
local LocalPlayer = Players.LocalPlayer
local v2 = assert(LocalPlayer)
local v3 = Trove.new()
local CurrentCamera = workspace.CurrentCamera
local FieldOfView = CurrentCamera.FieldOfView

local function playBoogieAnimation(v4) -- line 22 | captures: t, v1, Boogie, v3
    t.strict(t.instanceIsA("Model"))(v4)
    local Humanoid = v4:FindFirstChildOfClass("Humanoid")
    if Humanoid then
        local Animator = Humanoid:FindFirstChildOfClass("Animator")
        if Animator then
            local Animation = Instance.new("Animation")
            Animation.AnimationId = Boogie.BOOGIE_ANIMATION_ID
            local v5 = Animator:LoadAnimation(Animation)
            v5:Play()
            v3:Add(function() -- line 39 | captures: Animation, v5
                if v5 then
                    v5:Stop()
                    Animation:Destroy()
                end
            end)
            return v5
        end
        v1:AtError():Log("[BoogieClient] Animator not found")
    else
        v1:AtError():Log("[BoogieClient] Humanoid not found")
    end
    return nil
end

local function applyScreenEffects(v6) -- line 48 | captures: Lighting, TweenService, ShakePresets, Boogie, v3, CurrentCamera, FieldOfView
    v3:Clean()
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
    ColorCorrectionEffect.Saturation = Boogie.COLOR_CORRECTION.Saturation
    ColorCorrectionEffect.Brightness = Boogie.COLOR_CORRECTION.Brightness
    ColorCorrectionEffect.Contrast = Boogie.COLOR_CORRECTION.Contrast
    ColorCorrectionEffect.Parent = Lighting
    v3:Add(ColorCorrectionEffect)
    local v7 = TweenService:Create(CurrentCamera, Boogie.FOV_TWEEN_INFO, { FieldOfView = FieldOfView + Boogie.FOV_OFFSET })
    v7:Play()
    v3:Add(function() -- line 58 | captures: v7, CurrentCamera, FieldOfView
        v7:Cancel()
        CurrentCamera.FieldOfView = FieldOfView
    end)
    local v8 = TweenService:Create(ColorCorrectionEffect, Boogie.COLOR_CORRECTION_TWEEN_INFO, { Brightness = Boogie.COLOR_CORRECTION_TWEEN.Brightness })
    v8:Play()
    v3:Add(function() -- line 64 | captures: v8
        v8:Cancel()
    end)
    local v9 = ShakePresets[Boogie.SHAKE_PRESET]:Clone()
    local v10 = ShakePresets.DriveCamera(v9, CurrentCamera)
    v3:Add(v10)
    v3:Add(task.delay(v6, function() -- line 70 | captures: v3
        v3:Clean()
    end))
end

local function playBoogieSFX() -- line 74
end

local Attach = ToolSetup.Attach
local DisplayName = Boogie.DisplayName
local v11 = {}

function v11.onActivated(v12) -- line 76 | captures: Remotes
    Remotes.DanceGadget.AskDance:FireServer()
end

Attach(DisplayName, v11)
Remotes.DanceGadget.AttachEffect.OnClientEvent:Connect(function(v13) -- line 80 | captures: v2, playBoogieAnimation, applyScreenEffects
    applyScreenEffects(v13)
    local Character = v2.Character
    if Character then
        playBoogieAnimation(Character)
    end
end)
Remotes.DanceGadget.DetachEffect.OnClientEvent:Connect(function() -- line 87 | captures: v3
    v3:Clean()
end)
Remotes.DanceGadget.EmitSfx.OnClientEvent:Connect(function() -- line 90
end)
