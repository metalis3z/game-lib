-- Game: pet-rng
-- Original: ServerScriptService/Engine/Scripts/PetEquip.server.lua
-- What it does: Equips a pet model that follows the player using Attachment + AlignPosition/AlignOrientation, with a bobbing tween that changes speed while the player walks.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataManager = require(game.ServerScriptService.Engine.Scripts.Data.DataManager)
local PetsModule = require(ReplicatedStorage.DataModules.Pets)
local PetSystem = require(game.ReplicatedStorage.Engine.Modules.PetSystem)
local AbbreviateModule = require(game.ReplicatedStorage.Engine.Modules.AbbreviateModule)
local Rarities = require(game.ReplicatedStorage.DataModules.Rarities)

local RSEngine = ReplicatedStorage:WaitForChild("Engine")
local Remotes = RSEngine:WaitForChild("RemotesEvents")
local EquipPet = Remotes:WaitForChild("EquipPet")

local tweenService = game:GetService("TweenService")

local PetPositions = {
	{Position = Vector3.new(0, .1, 5), Orientation = Vector3.new(0, -90, 0)},
}

local function GetPetOrder(character: Model)
	local petFolder = character.Pets
	if #petFolder:GetChildren() == 0 then
		return 1
	end

	local activeSlots = {}
	for _, pet in ipairs(petFolder:GetChildren()) do
		local order = pet.Order.Value
		activeSlots[order] = order
	end

	for availableSlot = 1, #PetPositions, 1 do
		if not activeSlots[availableSlot] then
			return availableSlot
		end
	end
end

local function IsPlayerMoving(Humanoid) --function
	if Humanoid.MoveDirection.Magnitude == 0 then --if the movedirection is equal to 0 then the following will happen;
		return false 
	elseif Humanoid.MoveDirection.Magnitude > 0 then --if the movedirection is greater than 0 then the following will happen;
		return true
	end
end

function givePet(player, pet, Equip)	
	local newPetPositions =  {
		{Position = Vector3.new(0, 1.5, 5), Orientation = Vector3.new(0, -90, 0)},
	}
	if pet:GetAttribute("big") then
		newPetPositions =  {
			{Position = Vector3.new(0, 1.5, 10), Orientation = Vector3.new(0, -90, 0)},
		}
	end
	if pet:GetAttribute("offset") then
		newPetPositions[1].Position += Vector3.new(0,pet:GetAttribute("offset"),0)
	end
	
	if player then 
		local character = workspace:WaitForChild(player.Name)
		if character then
			if Equip == true then
				local pets = character:WaitForChild("Pets")
				pets:ClearAllChildren()
				local humanrootpart = character.HumanoidRootPart
				local newpet: Model = pet:Clone()
				for i,part in pairs(newpet:GetChildren()) do
					if part:IsA("BasePart") then
						part.Anchored = false
					end
				end

				newpet:PivotTo(humanrootpart.CFrame)

				local characterAttachment = Instance.new("Attachment", humanrootpart)
				characterAttachment.Visible = false

				local petAttachment = Instance.new("Attachment", newpet.PrimaryPart)
				petAttachment.Visible = false

				local alingPosition = Instance.new("AlignPosition", newpet)
				if pet.Name == "Huge Miner Cat" or pet.Name == "Huge Shard Cat" or pet.Name == "Huge Holy Cat" or pet.Name == "Huge Holy Elephant" or pet.Name == "Huge Holy Cow" or pet.Name == "Huge Cat" then
					alingPosition.MaxForce = 25000000
				else
					alingPosition.MaxForce = 2500000000
				end
				alingPosition.Attachment0 = petAttachment
				alingPosition.Attachment1 = characterAttachment
				alingPosition.Responsiveness = 25

				local alingOrientation = Instance.new("AlignOrientation", newpet)
				if pet.Name == "Huge Miner Cat" or pet.Name == "Huge Shard Cat" or pet.Name == "Huge Holy Cat" or pet.Name == "Huge Holy Elephant" or pet.Name == "Huge Holy Cow" or pet.Name == "Huge Cat" then
					alingOrientation.MaxTorque = 25000000	
				else
					alingOrientation.MaxTorque = 2500000000
				end
				alingOrientation.Attachment0 = petAttachment
				alingOrientation.Attachment1 = characterAttachment
				alingOrientation.Responsiveness = 25

				local order = Instance.new("IntValue", newpet)
				order.Name = "Order"
				order.Value = GetPetOrder(character)

				local petPosition = newPetPositions[order.Value]
				
				if petPosition then

					characterAttachment.Position = petPosition.Position
					characterAttachment.Orientation = petPosition.Orientation --+ if egg then  Vector3.new(0, -90, 0) else Vector3.new(0,0,0)
					local attPos1 = petAttachment.Position
					local attOrientation1 = petAttachment.Orientation

					newpet.Parent = pets

					local animate = false
					local tween1 = tweenService:Create(characterAttachment, TweenInfo.new(.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true), {Position = attPos1 + Vector3.new(0,2.5,0) + petPosition.Position})
					local tween2 = tweenService:Create(characterAttachment, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true), {Position = attPos1 + Vector3.new(0,2.5,0) + petPosition.Position})
					while newpet.Parent == pets do
						wait()

						if IsPlayerMoving(character.Humanoid) == true then
							if animate == false then
								animate = true
								tween2:Pause()
								characterAttachment.Position = petPosition.Position
								characterAttachment.Orientation = petPosition.Orientation
								tween1:Play()
							end
						else
							if animate == true then
								animate = false
								tween1:Pause()
								characterAttachment.Position = petPosition.Position
								characterAttachment.Orientation = petPosition.Orientation --+ if egg then  Vector3.new(0, -90, 0) else Vector3.new(0,0,0)
								tween2:Play()
							end
						end
					end
				end
			else
				if pet then
					pet = character:WaitForChild("Pets"):FindFirstChild(pet.Name)
					if pet then
						pet:Remove()
						for i,otherPet in pairs(character:WaitForChild("Pets"):GetChildren()) do
							otherPet:SetAttribute("pos", -7 + (i*5))
						end
					end
				end
			end
		end
	end
end

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local pets = Instance.new("Folder", character)
		pets.Name = "Pets"
		
		local humanoid = character:WaitForChild("Humanoid")
		humanoid.WalkSpeed = 24
	end)
end)

EquipPet.OnServerEvent:Connect(function(player, pet, equip)
	DataManager.profiles[player].Data["EquipedPet"] = pet.Name
	local character = player.Character or player.CharacterAdded:Wait()
	local oldTitle = character.Head:FindFirstChild("Title")
	if oldTitle then
		oldTitle:Remove()
	end
	local petInfo
	
	for _, aPet in pairs(PetsModule) do
		if aPet.name == pet.Name then
			petInfo = aPet
		end
	end
	
	if petInfo then
		local new = script.Title:Clone()
		new.petName.Text = petInfo.name
		new.petName.TextColor3 = Rarities[petInfo.title].color
		local rarity = math.round(1/petInfo.weight * PetSystem.getTotalRarity())
		new.rarity.Text = "1/".. AbbreviateModule:AbbreviateNumbers(rarity)
		new.Parent = character.Head
	end
	
	givePet(player, pet, equip)
end)
