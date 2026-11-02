Players = game:GetService("Players")
TweenService = game:GetService("TweenService")
player = Players.LocalPlayer
Camera = workspace.CurrentCamera
local blurEffect = Instance.new("BlurEffect",Camera)
local colorCorrection = Instance.new("ColorCorrectionEffect",Camera)
colorCorrection.Enabled = false
blurEffect.Size = 0; blurEffect.Enabled = false

EFFECT_TIME = Players.RespawnTime
BLUR_SIZE = 50
CORRECTION_COLOR = Color3.fromRGB(138, 0, 0)

local BlurEffectInfo = TweenInfo.new(
	EFFECT_TIME,
	Enum.EasingStyle.Linear,
	Enum.EasingDirection.Out,
	0,
	false,
	0)

BlurTween = TweenService:Create(blurEffect, BlurEffectInfo, {Size = BLUR_SIZE})


local CorrectionEffectInfo = TweenInfo.new(
	5,
	Enum.EasingStyle.Linear,
	Enum.EasingDirection.Out,
	0,
	false,
	0)

ColorTween = TweenService:Create(colorCorrection, CorrectionEffectInfo, {TintColor = CORRECTION_COLOR})

local BrightnessEffectInfo = TweenInfo.new(
	EFFECT_TIME,
	Enum.EasingStyle.Linear,
	Enum.EasingDirection.Out,
	0,
	false,
	0)

BrightnessTween = TweenService:Create(colorCorrection, BrightnessEffectInfo, {Brightness = -1})

function setupDeathTweens(character)
	local humanoid = character:WaitForChild("Humanoid")
	blurEffect.Size = 0
	colorCorrection.TintColor = Color3.fromRGB(255, 255, 255)
	colorCorrection.Brightness = 0
	if BrightnessTween and BlurTween and ColorTween == Enum.PlaybackState.Playing then
		BrightnessTween:Cancel()
		ColorTween:Cancel()
		BlurTween:Cancel()
		local startergui = game:GetService('StarterGui')
		startergui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
	end
	
	colorCorrection.Enabled = false
	blurEffect.Size = 0
	blurEffect.Enabled = false
	
	humanoid.Died:Connect(onDied)
end

function onDied()
	blurEffect.Enabled = true
	colorCorrection.Enabled = true
	local startergui = game:GetService('StarterGui')
	startergui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
	
	ColorTween:Cancel()
	BrightnessTween:Cancel()
	BlurTween:Cancel()
end

if player.Character then
	setupDeathTweens(player.Character)
	local startergui = game:GetService('StarterGui')
	startergui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
end

player.CharacterAdded:Connect(function()
	setupDeathTweens(player.Character)
	local startergui = game:GetService('StarterGui')
	startergui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
	task.wait(1)
	blurEffect.Size = 0
	blurEffect.Enabled = false
end)