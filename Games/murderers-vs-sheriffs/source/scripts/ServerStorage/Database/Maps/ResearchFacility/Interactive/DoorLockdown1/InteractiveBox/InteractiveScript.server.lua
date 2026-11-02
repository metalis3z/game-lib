local InUse = script.Parent.InUse
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local Box = script.Parent.Parent.DoorSwitch
local ParticleBlock = Box.ParticleBlock
local Doors = script.Parent.Parent.Doorway.MainDoor

CollectionService:AddTag(script.Parent, "InteractiveBox")

local function CloseDoor(Stabbed)
	if Stabbed then
		InUse.Value = true
		Box.Broken.Transparency = 0
		Box.Broken.Decal.Transparency = 0
		Box.Fixed.Transparency = 1
		Box.Fixed.Decal.Transparency = 1
		ParticleBlock.Emitter.Enabled = true
		TweenService:Create(Doors.Door1.Door, TweenInfo.new(0.1,Enum.EasingStyle.Linear), {Position = Doors.Door1.DoorClosed.Position}):Play()
		TweenService:Create(Doors.Door2.Door, TweenInfo.new(0.1,Enum.EasingStyle.Linear), {Position = Doors.Door2.DoorClosed.Position}):Play()
		ParticleBlock.Zap:Play()
		ParticleBlock.Hit:Play()
		wait(8)
		TweenService:Create(Doors.Door1.Door, TweenInfo.new(12,Enum.EasingStyle.Linear), {Position = Doors.Door1.DoorOpen.Position}):Play()
		TweenService:Create(Doors.Door2.Door, TweenInfo.new(12,Enum.EasingStyle.Linear), {Position = Doors.Door2.DoorOpen.Position}):Play()
		wait(12)
		Box.Broken.Transparency = 1
		Box.Broken.Decal.Transparency = 1
		Box.Fixed.Transparency = 0
		Box.Fixed.Decal.Transparency = 0
		ParticleBlock.Emitter.Enabled = false
		InUse.Value = false
	else
		InUse.Value = true
		TweenService:Create(Doors.Door1.Door, TweenInfo.new(0.1,Enum.EasingStyle.Linear), {Position = Doors.Door1.DoorClosed.Position}):Play()
		TweenService:Create(Doors.Door2.Door, TweenInfo.new(0.1,Enum.EasingStyle.Linear), {Position = Doors.Door2.DoorClosed.Position}):Play()
		wait(20)
		TweenService:Create(Doors.Door1.Door, TweenInfo.new(12,Enum.EasingStyle.Linear), {Position = Doors.Door1.DoorOpen.Position}):Play()
		TweenService:Create(Doors.Door2.Door, TweenInfo.new(12,Enum.EasingStyle.Linear), {Position = Doors.Door2.DoorOpen.Position}):Play()
		wait(12)
		script.Parent.ForceClosed.Value = false
		InUse.Value = false
	end
end

script.Parent.ForceClosed:GetPropertyChangedSignal("Value"):Connect(function()
	CloseDoor(false)
end)

script.Parent.KnifeHit.Event:Connect(function()
	if not InUse.Value then
		CloseDoor(true)
	end
end)