local Clicked = false
local tweenService = game:GetService("TweenService")
local TweenInfoo = TweenInfo.new(0.2,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out)
local TweenUp = tweenService:Create(script.Parent.Parent.Lever,TweenInfoo,{CFrame = script.Parent.Parent.UpPos.CFrame})
local TweenDown = tweenService:Create(script.Parent.Parent.Lever,TweenInfoo,{CFrame = script.Parent.Parent.DownPos.CFrame})
script.Parent.ProximityPrompt.Triggered:Connect(function(player)
if Clicked == false and script.Parent.Parent.Parent.Open.Value == 0 then
		Clicked = true
		script.Parent.ProximityPrompt.MaxActivationDistance = 0
local SwitchDownAnim = player.Character.Humanoid:LoadAnimation(player.Character.SwitchDownAnim)
local SwitchUpAnim = player.Character.Humanoid:LoadAnimation(player.Character.SwitchUpAnim)
SwitchDownAnim:Play()
wait(0.2)
		script.Parent.Parent.Parent.Open.Value = 1
TweenDown:Play()
script.Parent.Lever:Play()
		wait(4)
		script.Parent.ProximityPrompt.MaxActivationDistance = 3
Clicked = false
elseif Clicked == false and script.Parent.Parent.Parent.Open.Value == 1 then 
		Clicked = true
		script.Parent.ProximityPrompt.MaxActivationDistance = 0
local SwitchDownAnim = player.Character.Humanoid:LoadAnimation(player.Character.SwitchDownAnim)
local SwitchUpAnim = player.Character.Humanoid:LoadAnimation(player.Character.SwitchUpAnim)
SwitchUpAnim:Play()
wait(0.2)
		script.Parent.Parent.Parent.Open.Value = 0
TweenUp:Play()
script.Parent.Lever:Play()
		wait(2)
		script.Parent.ProximityPrompt.MaxActivationDistance = 3
Clicked = false
end
end)