local Open = script.Parent.Parent.Parent.SlidingDoor.Open
local SlidingDoor = script.Parent.Parent.Parent.SlidingDoor
local tweenService = game:GetService("TweenService")
local Debounce = false

local TweenInfoo2 = TweenInfo.new(25.2,Enum.EasingStyle.Linear,Enum.EasingDirection.In)
local TweenInfoo = TweenInfo.new(0.2,Enum.EasingStyle.Cubic,Enum.EasingDirection.Out)
local Up = tweenService:Create(script.Parent,TweenInfoo2,{CFrame = script.Parent.Parent.UpPos.CFrame})
local Down = tweenService:Create(script.Parent,TweenInfoo,{CFrame = script.Parent.Parent.DownPos.CFrame})

script.Parent.Parent.ClickPart.ProximityPrompt.Triggered:connect(function(player)
	if Debounce == false and Open.Value == false then
		Debounce = true
		script.Parent.Parent.ClickPart.ProximityPrompt.MaxActivationDistance = 0
		local SwitchDownAnim = player.Character.Humanoid:LoadAnimation(player.Character.SwitchDownAnim)
		SwitchDownAnim:Play()
		wait(0.2)
		Down:Play()
		SlidingDoor.Door.Alert:Play()
		SlidingDoor.Lever.ClickDetectorScript.Disabled = true
		Open.Value = true
		SlidingDoor.Door.DoorSound:Play()
		SlidingDoor.Lever.Back.Sound:Play()
		wait(0.2)
		Up:Play()
		wait(5)
		Open.Value = false
		SlidingDoor.Door.DoorSound:Play()
		SlidingDoor.Lever.Back.Sound:Play()
		SlidingDoor.Lever.ClickDetectorScript.Disabled = false
		wait(20)
		script.Parent.Parent.ClickPart.ProximityPrompt.MaxActivationDistance = 3
        Debounce = false
	end
end) 
	
