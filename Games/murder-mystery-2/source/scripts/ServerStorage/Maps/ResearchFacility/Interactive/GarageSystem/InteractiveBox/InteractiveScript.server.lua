local TweenService = require(game.ReplicatedStorage.ReplicatedTweening)
local garageSystem = script.Parent.Parent
local doorPosClosed = garageSystem.DoorPosition2
local doorPosOpen = garageSystem.DoorPosition1 
local MainDoorPart = garageSystem.GarageDoor.Main
local LeverOutside = garageSystem.GarageOpenerInside.Lever:WaitForChild("Main")
local tweenInfoDoor = TweenInfo.new(2)
local tweenInfoLever = TweenInfo.new(0.25)
local open = garageSystem.Opened.Value
local debounce = garageSystem.Debounce.Value

local OpenDoor = TweenService:GetTweenObject(MainDoorPart,TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),{CFrame = doorPosOpen.CFrame})
local OpenLeverOutside = TweenService:GetTweenObject(LeverOutside,TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),{CFrame = LeverOutside.Parent.Position2.CFrame})
local CloseDoor = TweenService:GetTweenObject(MainDoorPart,TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),{CFrame = doorPosClosed.CFrame})
local CloseLeverOutside = TweenService:GetTweenObject(LeverOutside,TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),{CFrame = LeverOutside.Parent.Position1.CFrame})

script.Parent.Interact.OnServerEvent:Connect(function(player)
	if player.Character and garageSystem.Debounce.Value == false then
		if garageSystem.Opened.Value == false then
			garageSystem.Opened.Value = true
			garageSystem.Debounce.Value = true
			OpenLeverOutside:Play()
			wait(0.6)
			OpenDoor:Play()
			CloseLeverOutside:Play()
			wait(5)
			garageSystem.Debounce.Value = false
		elseif garageSystem.Opened.Value == true then
			garageSystem.Opened.Value = false
			garageSystem.Debounce.Value = true
			OpenLeverOutside:Play()
			wait(0.6)
			CloseDoor:Play()
			CloseLeverOutside:Play()
			wait(5)
			garageSystem.Debounce.Value = false
		end
	end
end)