-- Script by XcorrectTheDev

local Theme = script.Parent.Death3
local FlashEffect = script.Parent.Frame
local Camera = workspace.Camera
local FlashAmount = 0.0005 -- How much screen flash when music is playing
local ScreenAngelsAmount = 0.0025 -- How much screen angles change when music is playing

game:GetService("RunService").RenderStepped:Connect(function()
FlashEffect.BackgroundTransparency = 1 - Theme.PlaybackLoudness * FlashAmount
Camera.CFrame = workspace.Camera.CFrame * CFrame.Angles(0, 
   0, math.rad(math.random(- Theme.PlaybackLoudness,
   Theme.PlaybackLoudness) * ScreenAngelsAmount)) + Vector3.new(
   math.rad(math.random( - Theme.PlaybackLoudness * ScreenAngelsAmount,
	 Theme.PlaybackLoudness * ScreenAngelsAmount) * ScreenAngelsAmount ), 
   math.rad(math.random( - Theme.PlaybackLoudness * ScreenAngelsAmount,
	 Theme.PlaybackLoudness * ScreenAngelsAmount) * ScreenAngelsAmount ), 
   math.rad(math.random( - Theme.PlaybackLoudness * ScreenAngelsAmount,
	 Theme.PlaybackLoudness * ScreenAngelsAmount) * ScreenAngelsAmount )
)     
end)
