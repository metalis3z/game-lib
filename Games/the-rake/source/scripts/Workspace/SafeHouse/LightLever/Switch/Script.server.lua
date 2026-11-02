local Open = script.Parent.Parent.Open
local Debounce = false
local tweenService = game:GetService("TweenService")
local TweenInfoo = TweenInfo.new(0.2,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out)
local Up = tweenService:Create(script.Parent,TweenInfoo,{CFrame = script.Parent.Parent.UpPos.CFrame})
local Down = tweenService:Create(script.Parent,TweenInfoo,{CFrame = script.Parent.Parent.DownPos.CFrame})

script.Parent.Parent.ClickPart.ProximityPrompt.Triggered:connect(function(player)
	if Open.Value == false and Debounce == false then 
		Debounce = true
		script.Parent.Parent.ClickPart.ProximityPrompt.MaxActivationDistance = 0
		local SwitchDownAnim = player.Character.Humanoid:LoadAnimation(player.Character.SwitchDownAnim)
		local SwitchUpAnim = player.Character.Humanoid:LoadAnimation(player.Character.SwitchUpAnim)
		SwitchDownAnim:Play()
		wait(0.2)
		Open.Value = true
		Down:Play()
		wait(1)
		script.Parent.Parent.ClickPart.ProximityPrompt.MaxActivationDistance = 3
		Debounce = false
	elseif Open.Value == true and Debounce == false then 
		Debounce = true
		script.Parent.Parent.ClickPart.ProximityPrompt.MaxActivationDistance = 0
		local SwitchDownAnim = player.Character.Humanoid:LoadAnimation(player.Character.SwitchDownAnim)
		local SwitchUpAnim = player.Character.Humanoid:LoadAnimation(player.Character.SwitchUpAnim)
		SwitchUpAnim:Play()
		wait(0.2)
		Open.Value = false
		Up:Play()
		wait(1)
		script.Parent.Parent.ClickPart.ProximityPrompt.MaxActivationDistance = 3
		Debounce = false
	end
end)
	
