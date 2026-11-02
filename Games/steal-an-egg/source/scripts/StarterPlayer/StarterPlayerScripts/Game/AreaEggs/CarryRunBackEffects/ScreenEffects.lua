-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastTween = require(ReplicatedStorage.Library.Functions.FastTween)

require(script.Types.Interface)

local v1 = Color3.fromRGB(191, 0, 3)
local v2 = TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local t = {}

t.__index = t
t.__class = "GuardRunBackEffects"
function t.new() --[[ new | Line: 40 | Upvalues: t (copy), PlayerGui (copy) ]]
	local v2 = setmetatable({}, t)
	local RunBackEffects = PlayerGui:WaitForChild("RunBackEffects")

	assert(RunBackEffects:IsA("ScreenGui"), "PlayerGui.RunBackEffects must be a ScreenGui")

	local Run = RunBackEffects:WaitForChild("Run")

	assert(Run:IsA("GuiObject"), "RunBackEffects.Run must be a GuiObject")

	local Blur = RunBackEffects:WaitForChild("Blur")

	assert(Blur:IsA("ImageLabel"), "RunBackEffects.Blur must be an ImageLabel")
	v2._activeSerial = 0
	v2._blurOriginalTransparency = Blur.ImageTransparency
	v2._blurTween = nil
	v2._runOriginalColor = Run.BackgroundColor3
	v2._runTween = nil
	v2._widgets = {
		Blur = Blur,
		Run = Run,
		ScreenGui = RunBackEffects
	}
	v2:_init()

	return v2
end
function t._cancelTweens(p1) --[[ _cancelTweens | Line: 70 ]]
	local _blurTween = p1._blurTween

	if _blurTween ~= nil then
		_blurTween:Cancel()
		_blurTween:Destroy()
	end

	p1._blurTween = nil

	local _runTween = p1._runTween

	if _runTween ~= nil then
		_runTween:Cancel()
		_runTween:Destroy()
	end

	p1._runTween = nil
end
function t._resetVisualState(p1) --[[ _resetVisualState | Line: 86 ]]
	local _widgets = p1._widgets

	_widgets.Blur.ImageTransparency = p1._blurOriginalTransparency
	_widgets.Run.BackgroundColor3 = p1._runOriginalColor
	_widgets.ScreenGui.Enabled = false
end
function t._playCycle(p1, p2, p3) --[[ _playCycle | Line: 93 | Upvalues: v1 (copy), FastTween (copy), v2 (copy) ]]
	if p2 ~= p1._activeSerial then
		return
	end

	local _widgets = p1._widgets
	local v12 = if p3 then 1 else p1._blurOriginalTransparency
	local v22 = if p3 then v1 else p1._runOriginalColor

	p1:_cancelTweens()
	p1._blurTween = FastTween(_widgets.Blur, v2, {
		ImageTransparency = v12
	})
	p1._runTween = FastTween(_widgets.Run, v2, {
		BackgroundColor3 = v22
	})

	local _blurTween = p1._blurTween

	assert(if _blurTween == nil then false else true, "Blur tween must exist during run-back effect cycle")
	assert(if p1._runTween == nil then false else true, "Run tween must exist during run-back effect cycle")
	task.spawn(function() --[[ Line: 115 | Upvalues: _blurTween (copy), p2 (copy), p1 (copy), p3 (copy) ]]
		_blurTween.Completed:Wait()

		if p2 == p1._activeSerial then
			p1:_playCycle(p2, not p3)
		end
	end)
end
function t.Start(p1) --[[ Start | Line: 129 ]]
	p1._activeSerial = p1._activeSerial + 1

	local _widgets = p1._widgets

	_widgets.ScreenGui.Enabled = true
	_widgets.Blur.ImageTransparency = p1._blurOriginalTransparency
	_widgets.Run.BackgroundColor3 = p1._runOriginalColor
	p1:_playCycle(p1._activeSerial, true)
end
function t.Stop(p1) --[[ Stop | Line: 138 ]]
	p1._activeSerial = p1._activeSerial + 1
	p1:_cancelTweens()
	p1:_resetVisualState()
end
function t._init(p1) --[[ _init | Line: 148 ]]
	p1:Stop()
end

return t