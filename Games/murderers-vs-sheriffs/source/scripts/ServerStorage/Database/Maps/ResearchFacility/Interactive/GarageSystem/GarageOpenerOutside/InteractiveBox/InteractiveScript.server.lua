local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local PullTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local DoorTweenInfo = TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

local opened = script.Parent.Parent.Parent.Opened
local debounce = script.Parent.Parent.Parent.Debounce

local OtherBox = script.Parent.OtherBox
local Lever = script.Parent.Parent.Lever
local GarageDoor = script.Parent.Parent.Parent.GarageDoor
local InUse = script.Parent.InUse
local Interact = script.Parent.Interact

CollectionService:AddTag(script.Parent, "InteractiveBox")

Interact.OnServerEvent:Connect(function(Player)
	if debounce.Value == true then return end
	debounce.Value = true
	InUse.Value = true
	OtherBox.Value.InUse.Value = true

	local tween1 = TweenService:Create(Lever.Main, PullTweenInfo, {CFrame = Lever.Position2.CFrame})
	tween1:Play()
	tween1.Completed:Wait()

	local tween3 = TweenService:Create(Lever.Main, PullTweenInfo, {CFrame = Lever.Position1.CFrame})
	tween3:Play()
	tween3.Completed:Wait()

	if opened.Value == false then
		local tween2 = TweenService:Create(GarageDoor.Main, DoorTweenInfo, {Position = GarageDoor.DoorPosition1.Position})
		tween2:Play()

		tween2.Completed:Wait()
		opened.Value = true
	else
		local tween2 = TweenService:Create(GarageDoor.Main, DoorTweenInfo, {Position = GarageDoor.DoorPosition2.Position})
		InUse.Value = true
		tween2:Play()

		tween2.Completed:Wait()
		opened.Value = false
	end
	debounce.Value = false

	InUse.Value = false
	OtherBox.Value.InUse.Value = false
end)