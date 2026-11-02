-- Script by XcorrectTheDev

local Theme = script.Parent.Theme
local FlashEffect = script.Parent.FlashEffect
local Camera = workspace.Camera
local ScreenZoomAmount = 0.025 -- How much screen zoom when music is playing
local FlashAmount = 0.0005 -- How much screen flash when music is playing
local ScreenAngelsAmount = 0.003 -- How much screen angles change when music is playing
local StandardFieldOfView = 70 -- Standard FieldOfView on roblox better set it to 70

game:GetService("RunService").RenderStepped:Connect(function()
Camera.FieldOfView = StandardFieldOfView - Theme.PlaybackLoudness * ScreenZoomAmount
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
