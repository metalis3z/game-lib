local tweenService = game:GetService("TweenService")
local Debounce = false
local TweenInfoo = TweenInfo.new(0.2,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out)
local TweenInfoo2 = TweenInfo.new(1,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out)
local SwitchUp = tweenService:Create(script.Parent.Lever,TweenInfoo2,{CFrame = script.Parent.UpPos.CFrame})
local SwitchDown = tweenService:Create(script.Parent.Lever,TweenInfoo,{CFrame = script.Parent.DownPos.CFrame})
local SwitchUp2 = tweenService:Create(script.Parent.Lever,TweenInfoo2,{Orientation = script.Parent.UpPos.Orientation})
local SwitchDown2 = tweenService:Create(script.Parent.Lever,TweenInfoo,{Orientation = script.Parent.DownPos.Orientation})

script.Parent.ClickPart.ProximityPrompt.Triggered:connect(function(player)
	if script.Parent.Parent.Open.Value == true and Debounce == false then
		Debounce = true
		script.Parent.ClickPart.ProximityPrompt.MaxActivationDistance = 0
		local DoorLeverAnim = player.Character.Humanoid:LoadAnimation(player.Character.DoorLeverAnim)
		DoorLeverAnim:Play()
		wait(0.2)
		script.Parent.ClickPart.ProximityPrompt.ObjectText = "Open Door"
		script.Parent.Parent.Open.Value = false
		script.Parent.Parent.Door.DoorSound:Play()
script.Parent.Back.Sound:Play()
		SwitchDown:Play()
		SwitchDown2:Play()
		wait(0.1)
		SwitchUp:Play()
		SwitchUp2:Play()
		script.Parent.ClickPart.ProximityPrompt.MaxActivationDistance = 3
		Debounce = false
	elseif script.Parent.Parent.Open.Value == false and Debounce == false then
		Debounce = true
		script.Parent.ClickPart.ProximityPrompt.MaxActivationDistance = 0
		local DoorLeverAnim = player.Character.Humanoid:LoadAnimation(player.Character.DoorLeverAnim)
		DoorLeverAnim:Play()
		wait(0.2)
		script.Parent.ClickPart.ProximityPrompt.ObjectText = "Close Door"
		script.Parent.Parent.Open.Value = true
		script.Parent.Parent.Door.DoorSound:Play()
		script.Parent.Back.Sound:Play()
		SwitchDown:Play()
		SwitchDown2:Play()
		wait(0.1)
		SwitchUp:Play()
		SwitchUp2:Play()
		script.Parent.ClickPart.ProximityPrompt.MaxActivationDistance = 3
		Debounce = false
end
end)
