local InteractionHandler = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")
local InteractionRate = 0.1
local InteractableObjects = workspace:WaitForChild("Interactions")
local InteractionEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Events"):WaitForChild("InteractionEvent")
local Device, CurrentInteraction, Interacting, Tool
local Centers = {}

function InteractionHandler.Init(Type)
	if Type then
		Device = "Mobile"
	else
		Device = "PC"
	end
end

local function IsInTable(Item, Table)
	for Index, Object in next, Table do
		if Object == Item then
			return true
		end
	end
	return false
end

local function ReturnClosestCenter()
   local ClosestCenter, ClosestCenterDistance = nil, 0
	for _, Center in next, Centers do
		local Distance = (Center.Position - HumanoidRootPart.Position).Magnitude
		if Distance < ClosestCenterDistance or ClosestCenterDistance == 0 then
			ClosestCenter = Center
			ClosestCenterDistance = Distance
		end
	end
	return ClosestCenter, ClosestCenterDistance
end

local function OnCharacterAdded(NewCharacter)
	Character = NewCharacter
	Humanoid = NewCharacter:WaitForChild("Humanoid")
	HumanoidRootPart = NewCharacter:WaitForChild("HumanoidRootPart")
end

local WaitForInteractions = coroutine.create(function()
	while true do
		for _, Object in next, CollectionService:GetTagged("Interactable") do
			if not IsInTable(Object.Center, Centers) then
				table.insert(Centers, Object.Center)
				local SecondaryCenter = Object:FindFirstChild("Center1")
				if SecondaryCenter then
					if not IsInTable(Object.Center1, Centers) then
						table.insert(Centers, Object.Center1)
					end
				end
			end
			local ClosestCenter = ReturnClosestCenter()
			if Object.Center ~= ClosestCenter then Object.Center.Interaction.Enabled = false end
			if Object:FindFirstChild("Center1") then if Object.Center1 ~= ClosestCenter then Object.Center1.Interaction.Enabled = false end end
			if (ClosestCenter.Position - HumanoidRootPart.Position).Magnitude < 10 and not Interacting then
				CurrentInteraction = ClosestCenter.Parent
				ClosestCenter.Interaction.Enabled = true
			else
				CurrentInteraction = nil
			end
		end
		wait(InteractionRate)
	end
end)

UserInputService.InputBegan:Connect(function(Input, GameProcessedEvent)
	if GameProcessedEvent then
		return
	end
	if Input.UserInputType == Enum.UserInputType.Keyboard then
		if Input.KeyCode == Enum.KeyCode.E and CurrentInteraction and not Interacting then
			InteractionEvent:FireServer(CurrentInteraction)
			Interacting = true
			delay(2, function()
				Interacting = false
			end)
		end
	end
end)	

Player.CharacterAdded:Connect(OnCharacterAdded)
coroutine.resume(WaitForInteractions)

return InteractionHandler