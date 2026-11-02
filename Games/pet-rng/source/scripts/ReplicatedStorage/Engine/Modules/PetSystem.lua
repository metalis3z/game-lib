local DataManager = require(game.ServerScriptService.Engine.Scripts.Data.DataManager)
local Pets = require(game.ReplicatedStorage.DataModules.Pets)
local Rarities = require(game.ReplicatedStorage.DataModules.Rarities)
local AbbreviateModule = require(game.ReplicatedStorage.Engine.Modules.AbbreviateModule)

local totalRarity = 0
for _, pet in pairs(Pets) do
	totalRarity += pet.weight
end

local PetSystem = {}

local function getPetData(petName)
	local pet
	for _, aPet in pairs(Pets) do
		if aPet.name == petName then
			pet = aPet
		end
	end
	return pet
end

PetSystem.getTotalRarity = function()
	return totalRarity
end

local function displayInfo(player: Player, petData, petDisplay, frame)
	local playerGui = player.PlayerGui
	local gui = playerGui:WaitForChild("GUI")
	local frames = gui:WaitForChild("Frames")
	local petsFrame = frames:WaitForChild("Inventory")
	local holder = petsFrame:WaitForChild("PetsHolder")
	local infoFrame = holder:WaitForChild("InfoFrame")
	local PetPreview = infoFrame:WaitForChild("PetPreview")
	
	for _, object in pairs(PetPreview:GetChildren()) do
		object:Remove()
	end
	
	petDisplay.Parent = PetPreview
	infoFrame.Amount.Text = "You have: " .. frame:GetAttribute("amount")
	infoFrame.Amount2.Text = "You have: " .. frame:GetAttribute("amount")
	infoFrame.PetName.Text = petData.name
	infoFrame.PetNameShadow.Text = petData.name
	local rarity = math.round(1/petData.weight * totalRarity)
	infoFrame.Increase.Text = "1/".. AbbreviateModule:AbbreviateNumbers(rarity)
	infoFrame.Increase2.Text = "1/".. AbbreviateModule:AbbreviateNumbers(rarity)
	infoFrame.Rarity.Text = petData.title
	infoFrame.rarityShadow.TextColor3 = Rarities[petData.title].color
	infoFrame.rarityShadow.Text = petData.title
end

PetSystem.UpdatePets = function(player: Player)
	local playerGui = player.PlayerGui
	local gui = playerGui:WaitForChild("GUI")
	local frames = gui:WaitForChild("Frames")
	local petsFrame = frames:WaitForChild("Inventory")
	local holder = petsFrame:WaitForChild("PetsHolder")
	local scroll = holder:WaitForChild("HolderScroll")
	local template = scroll:WaitForChild("PetTemplate")
	
	local indexFrame = frames:WaitForChild("Index")
	local indexHolder = indexFrame:WaitForChild("PetsHolder")
	local indexScroll = indexHolder:WaitForChild("HolderScroll")
	local indexTemplate = indexScroll:WaitForChild("PetTemplate")

	
	for _, object in pairs(scroll:GetChildren()) do
		if object:IsA("ImageButton") and object.Visible then
			object:Remove()
		end
	end
	
	for _, object in pairs(indexScroll.Basic.Container:GetChildren()) do
		if object:IsA("ImageButton") and object.Visible then
			object:Remove()
		end
	end
	

	for _, object in pairs(indexScroll.Cave.Container:GetChildren()) do
		if object:IsA("ImageButton") and object.Visible then
			object:Remove()
		end
	end
	

	for _, object in pairs(indexScroll.Snow.Container:GetChildren()) do
		if object:IsA("ImageButton") and object.Visible then
			object:Remove()
		end
	end
	

	for _, object in pairs(indexScroll.Desert.Container:GetChildren()) do
		if object:IsA("ImageButton") and object.Visible then
			object:Remove()
		end
	end
	
	repeat wait() until DataManager.profiles[player]
	for _, pet in pairs(DataManager.profiles[player].Data["Pets"]) do
		local petData = getPetData(pet)
		
		local clone = scroll:FindFirstChild(petData.name)
		if not clone then
			clone = template:Clone()
			local petDisplay = petData.pet:Clone()
			petDisplay.Parent = clone.SelectPet
			local multi = 1
			if petDisplay:GetAttribute("big") then
				multi = 2
			end
			
			petDisplay:PivotTo(CFrame.new(0,0,-4*multi) * CFrame.Angles(0, math.rad(100), math.rad(-10)))
			clone.Name = petData.name
			clone.LayoutOrder = table.find(Pets, petData) * -1
			clone.Visible = true
			clone.Parent = scroll
			
			clone.MouseButton1Click:Connect(function()
				displayInfo(player, petData, petDisplay:Clone(), clone)
			end)
		end
		
		
		clone:SetAttribute("amount", clone:GetAttribute("amount") + 1)
	end
	
	for _, pet in pairs(Pets) do
		

		local clone = indexScroll:FindFirstChild(pet.name)
		if not clone then
			clone = indexTemplate:Clone()
			local petDisplay = pet.pet:Clone()
			petDisplay.Parent = clone.SelectPet
			local multi = 1
			if petDisplay:GetAttribute("big") then
				multi = 2
			end
			
			clone.Name = pet.name
			clone.LayoutOrder = table.find(Pets, pet) * -1
			clone.Visible = true
			local rarity = math.round(1/pet.weight * totalRarity)
			clone.Rarity.Text = "1/".. AbbreviateModule:AbbreviateNumbers(rarity)
			if table.find(DataManager.profiles[player].Data["Pets"], pet.name) then
				clone.Owns.Visible = false
				petDisplay:PivotTo(CFrame.new(0,0,-4*multi) * CFrame.Angles(0, math.rad(100), math.rad(-10)))
			end
			
			
			if pet.title == "Snow" or pet.title == "Desert" or pet.title == "Cave" then
				if pet.title == "Snow" then
					clone.Parent = indexTemplate.Parent.Snow.Container	
				elseif pet.title == "Cave" then
					clone.Parent = indexTemplate.Parent.Cave.Container
				else
					clone.Parent = indexTemplate.Parent.Desert.Container
				end	
			else
				clone.Parent = indexTemplate.Parent.Basic.Container
			end
		end
	end
end

return PetSystem