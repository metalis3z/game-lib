--!strict
-- LOCATION: ReplicatedStorage/Modules/EffectsSystem

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)

local EffectsSystem = {}

local templates = ReplicatedStorage:WaitForChild("Templates")
local soundFolder = Workspace:WaitForChild("Sounds")
local winSound = soundFolder:WaitForChild("Win") :: Sound

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Resolve gui fresh every call — caching it at module level breaks after death
local function getGui()
	return playerGui:FindFirstChild("GUI")
end

local function spawnVisual(templateName: string, amount: number, soundToPlay: Sound?, duration: number)
	local gui = getGui()
	if not gui then return end

	local template = templates:FindFirstChild(templateName)
	if not template then return end

	local clone = template:Clone() :: Frame
	local textLabel = clone:FindFirstChild("Text") :: TextLabel
	local uiStroke = textLabel and textLabel:FindFirstChild("Stroke") :: UIStroke
	local imageLabel = clone:FindFirstChild("Image") :: ImageLabel

	if textLabel then
		textLabel.Text = "+" .. NumberFormatter.Format(amount)
	end

	if soundToPlay then
		soundToPlay:Play()
	end

	local randomX = math.random(20, 80) / 100
	local randomY = math.random(20, 80) / 100
	clone.Position = UDim2.fromScale(randomX, randomY)
	clone.Rotation = math.random(-15, 15)
	clone.Parent = gui
	clone.Visible = true

	local originalSize = clone.Size
	clone.Size = UDim2.fromScale(0, 0)

	local tweenIn = TweenService:Create(clone, TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
		Size = originalSize,
		Rotation = 0,
	})

	local targetPos = UDim2.new(randomX, 0, randomY - 0.1, 0)
	local tweenOut = TweenService:Create(clone, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Position = targetPos,
		BackgroundTransparency = 1,
	})

	if textLabel then
		TweenService:Create(textLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			TextTransparency = 1,
		}):Play()
		if uiStroke then
			TweenService:Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Transparency = 1,
			}):Play()
		end
	end

	if imageLabel then
		TweenService:Create(imageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			ImageTransparency = 1,
		}):Play()
	end

	tweenIn:Play()
	tweenIn.Completed:Wait()
	task.wait(duration)

	-- Guard: gui may be gone if player reset mid-animation
	if not clone.Parent then return end

	tweenOut:Play()
	Debris:AddItem(clone, 0.6)
end

function EffectsSystem.ShowSpeedPopUp(amount: number)
	task.spawn(spawnVisual, "PopUp", amount, nil, 0.2)
end

function EffectsSystem.ShowWinPopUp(amount: number)
	task.spawn(spawnVisual, "WinPopUp", amount, winSound, 1.5)
end

return EffectsSystem