local Debounce = script.Parent.InUse.Value
local TweenService = require(game.ReplicatedStorage.ReplicatedTweening)
local ParticleBlock = script.Parent.Parent.DoorSwitch.ParticleBlock
local Doors = script.Parent.Parent.Doorway.MainDoor
script.Parent.Interact.OnServerEvent:Connect(function()
	if script.Parent.ForceClosed.Value == false then
		if Debounce == false then
			Debounce = true
			ParticleBlock.Parent.Broken.Transparency = 0
			ParticleBlock.Parent.Broken.Decal.Transparency = 0
			ParticleBlock.Parent.Misc.Transparency = 1
			ParticleBlock.Parent.Misc.Decal.Transparency = 1
			ParticleBlock.Emitter.Enabled = true
			TweenService:GetTweenObject(Doors.Door1.Door, TweenInfo.new(0.1,Enum.EasingStyle.Linear), {Position = Doors.Door1.DoorClosed.Position}):Play()
			TweenService:GetTweenObject(Doors.Door2.Door, TweenInfo.new(0.1,Enum.EasingStyle.Linear), {Position = Doors.Door2.DoorClosed.Position}):Play()
			wait(0.2)
			ParticleBlock.Zap:Play()
			ParticleBlock.Hit:Play()
			wait(20)
			TweenService:GetTweenObject(Doors.Door1.Door, TweenInfo.new(15,Enum.EasingStyle.Linear), {Position = Doors.Door1.DoorOpen.Position}):Play()
			TweenService:GetTweenObject(Doors.Door2.Door, TweenInfo.new(15,Enum.EasingStyle.Linear), {Position = Doors.Door2.DoorOpen.Position}):Play()
			wait(20)
			ParticleBlock.Parent.Broken.Transparency = 1
			ParticleBlock.Parent.Broken.Decal.Transparency = 1
			ParticleBlock.Parent.Misc.Transparency = 0
			ParticleBlock.Parent.Misc.Decal.Transparency = 0
			ParticleBlock.Emitter.Enabled = false
			wait(10)
			Debounce = false
		end
	end
end)
script.Parent.KnifeHit.Event:Connect(function()
	if Debounce == false then
		script.Parent.ForceClosed.Value = true
		Debounce = true
		TweenService:GetTweenObject(Doors.Door1.Door, TweenInfo.new(0.1,Enum.EasingStyle.Linear), {Position = Doors.Door1.DoorClosed.Position}):Play()
		TweenService:GetTweenObject(Doors.Door2.Door, TweenInfo.new(0.1,Enum.EasingStyle.Linear), {Position = Doors.Door2.DoorClosed.Position}):Play()
		wait(20)
		TweenService:GetTweenObject(Doors.Door1.Door, TweenInfo.new(15,Enum.EasingStyle.Linear), {Position = Doors.Door1.DoorOpen.Position}):Play()
		TweenService:GetTweenObject(Doors.Door2.Door, TweenInfo.new(15,Enum.EasingStyle.Linear), {Position = Doors.Door2.DoorOpen.Position}):Play()
		wait(20)
		script.Parent.ForceClosed.Value = false
		wait(10)
		Debounce = false
	end
end)