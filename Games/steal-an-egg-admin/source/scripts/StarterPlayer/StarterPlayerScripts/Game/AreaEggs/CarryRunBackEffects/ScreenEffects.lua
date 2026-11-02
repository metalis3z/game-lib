-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenOnce = require(ReplicatedStorage.Shared.Utils.Instances).TweenOnce
require(script.Types.Interface)
local v1 = Color3.fromRGB(191, 0, 3)
local v2 = TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local v3 = {}

v3.__index = v3
v3.__class = "GuardRunBackEffects"

function v3.new() -- line 16 | captures: PlayerGui, v3
    local v4 = {}
    local v5 = setmetatable(v4, v3)
    local RunBackEffects = PlayerGui:WaitForChild("RunBackEffects")
    local ScreenGui = RunBackEffects:IsA("ScreenGui")
    assert(ScreenGui, "PlayerGui.RunBackEffects must be a ScreenGui")
    local Run = RunBackEffects:WaitForChild("Run")
    local GuiObject = Run:IsA("GuiObject")
    assert(GuiObject, "RunBackEffects.Run must be a GuiObject")
    local Blur = RunBackEffects:WaitForChild("Blur")
    local ImageLabel = Blur:IsA("ImageLabel")
    assert(ImageLabel, "RunBackEffects.Blur must be an ImageLabel")
    v5._activeSerial = 0
    v5._blurOriginalTransparency = Blur.ImageTransparency
    v5._blurTween = nil
    v5._runOriginalColor = Run.BackgroundColor3
    v5._runTween = nil
    v5._widgets = {
        Blur = Blur,
        Run = Run,
        ScreenGui = RunBackEffects
    }
    v5:_init()
    return v5
end

local function _cancelTweens(v6) -- line 36
    local _blurTween = v6._blurTween
    if _blurTween ~= nil then
        _blurTween:Cancel()
        _blurTween:Destroy()
    end
    v6._blurTween = nil
    local _runTween = v6._runTween
    if _runTween ~= nil then
        _runTween:Cancel()
        _runTween:Destroy()
    end
    v6._runTween = nil
end

v3._cancelTweens = _cancelTweens

local function _resetVisualState(v7) -- line 50
    local _widgets = v7._widgets
    _widgets.Blur.Visible = true
    _widgets.Blur.ImageTransparency = v7._blurOriginalTransparency
    _widgets.Run.BackgroundColor3 = v7._runOriginalColor
    _widgets.ScreenGui.Enabled = false
end

v3._resetVisualState = _resetVisualState

function v3._playCycle(v8, v9, v10) -- line 57 | captures: TweenOnce, v1, v2
    if v9 ~= v8._activeSerial then
        return
    end
    local _widgets = v8._widgets
    local v11, v12
    if v10 then
        v12 = 1
        v11 = v1
    else
        v12 = v8._blurOriginalTransparency
        v11 = v8._runOriginalColor
    end
    v8:_cancelTweens()
    v8._blurTween = TweenOnce(_widgets.Blur, v2, { ImageTransparency = v12 })
    local v13 = { BackgroundColor3 = v11 }
    v8._runTween = TweenOnce(_widgets.Run, v2, v13)
    local _blurTween = v8._blurTween
    local v14 = _blurTween ~= nil
    assert(v14, "Blur tween must exist during run-back effect cycle")
    local v15 = v8._runTween ~= nil
    assert(v15, "Run tween must exist during run-back effect cycle")
    task.spawn(function() -- line 82 | captures: v8, v9, v10, _blurTween
        _blurTween.Completed:Wait()
        if v9 == v8._activeSerial then
            v8:_playCycle(v9, not v10)
        end
    end)
end

local function Start(v16, v17) -- line 90
    v16._activeSerial += 1
    local _widgets = v16._widgets
    _widgets.ScreenGui.Enabled = true
    local v18 = v17 ~= true
    _widgets.Blur.Visible = v18
    _widgets.Blur.ImageTransparency = v16._blurOriginalTransparency
    _widgets.Run.BackgroundColor3 = v16._runOriginalColor
    v16:_playCycle(v16._activeSerial, true)
end

v3.Start = Start

local function Stop(v19) -- line 100
    v19._activeSerial += 1
    v19:_cancelTweens()
    v19:_resetVisualState()
end

v3.Stop = Stop

local function _init(v20) -- line 105
    v20:Stop()
end

v3._init = _init
return v3
