-- Reference copy for study. Game: Pet RNG (pet-rng)
-- Original: ReplicatedStorage/Engine/Modules/ToggleUI.lua
-- What it does: Two functions that slide the left, right and bottom HUD groups off-screen and back (used to hide the HUD during rolls/cutscenes).

local tweenService = game:GetService("TweenService")

local ToggleUI = {}

ToggleUI.Close = function(plr: Player)
	local PlayerGui = plr.PlayerGui
	local GUI = PlayerGui:WaitForChild("GUI")
	local Bottom = GUI:WaitForChild("Bottom")
	local Left = GUI:WaitForChild("Left")
	local Right = GUI:WaitForChild("Right")
	
	tweenService:Create(Right, TweenInfo.new(.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.fromScale(1,0)}):Play()
	tweenService:Create(Bottom, TweenInfo.new(.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0,.2)}):Play()
	tweenService:Create(Left, TweenInfo.new(.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.fromScale(-0.1,0)}):Play()
end

ToggleUI.Open = function(plr: Player)
	local PlayerGui = plr.PlayerGui
	local GUI = PlayerGui:WaitForChild("GUI")
	local Bottom = GUI:WaitForChild("Bottom")
	local Left = GUI:WaitForChild("Left")
	local Right = GUI:WaitForChild("Right")

	tweenService:Create(Right, TweenInfo.new(.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0.925,0)}):Play()
	tweenService:Create(Bottom, TweenInfo.new(.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0,0)}):Play()
	tweenService:Create(Left, TweenInfo.new(.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.fromScale(0,0)}):Play()
end

return ToggleUI
