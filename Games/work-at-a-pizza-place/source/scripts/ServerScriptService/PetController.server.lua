local Pets = {}
local Global = require(script.Parent.Global)
local Players = Global.Players
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))

--PET DATA
local DataStore = ((game.PlaceId == Enums.PizzaPlaceId or game.PlaceId == Enums.PizzaPlaceInsideUniverseTestId or game.PlaceId == Enums.PizzaPlacePartyId)   and game:GetService("DataStoreService"):GetDataStore("Pets10")) or
				  (game.PlaceId == Enums.PizzaPlaceTestId and game:GetService("DataStoreService"):GetDataStore("TesterPetsB" ..  Enums.TestDataStoreVersion)) or
				  (game.PlaceId == Enums.PizzaPlacePrivateTestId and game:GetService("DataStoreService"):GetDataStore("PrivateTestPets" ..  Enums.PrivateTestDataStoreVersion)) or
				  (game.PlaceId == Enums.PizzaPlaceInsideUniverseTestId and game:GetService("DataStoreService"):GetDataStore("Pets10"))

local MaxNumPets = 3


print("Pet controller loaded")




local petDataLoaded = {}


function PlayerAdded(newPlayer)
	
	--runs one time
	local connection = nil
	connection = newPlayer.CharacterAdded:connect(function()
		Pets[newPlayer] = {}
		connection:disconnect()
		
		
		while not Players[newPlayer] or (not Players[newPlayer]["StartedPlaying"] )  do  wait(1) end --and playstate == "online"
		
		--disables pets on consoles
		--while Enums.IsConsoleServer == nil do wait() end
		--if Enums.IsConsoleServer then return end
		
		
		wait(2)
		
		if DataStore then
			
			local success,savedData = pcall(function() return DataStore:GetAsync(tostring(newPlayer.userId)) end)
			
			if not success then
				petDataLoaded[newPlayer] = false
				Dialog:ShowMessage(newPlayer,"Error","There was an error when loading your pets. Come back another time.")
			end
			
			if savedData then
				local active_counter = 0
				for i,petdata in ipairs(savedData) do
					local Pet
					Pet = require(script.Parent.Pet).new(newPlayer,petdata)
					if Pet.Active and active_counter <= MaxNumPets then
						active_counter = active_counter + 1
						Pet:SpawnPet()
					
					elseif active_counter > MaxNumPets then
						Pet:SetActive(false)
							
					end
					
					
				
					
					--prevent duplicate names
					for _,data in ipairs(Pets[newPlayer]) do
						if data.Name == Pet.Name then
							Pet.Name = " " .. Pet.Name .. " "
						end
					end
						
					spawn(function() Pet:StartAI() end)
						
					table.insert(Pets[newPlayer],1,Pet)

				end
				
			end
			
		end
		petDataLoaded[newPlayer] = true
	end)
	
	
	
	local died = nil
	newPlayer.CharacterAdded:connect(function(character)
		local humanoid = character.Humanoid
		if died then died:disconnect() end
		died = humanoid.Died:connect(function()
			for _,pet in ipairs(Pets[newPlayer]) do
				if pet.State ~= "Deactivated" then
					pet.EmotionState = "Sad"
					pet.State = "Follow"
				end
			end
		end)
		
		
		
	end)
	
	
	
end

game.Players.PlayerAdded:connect(PlayerAdded)



function PlayerRemoving(player)
	
	SaveData(player)
	if Pets[player] then
		for i,pet in ipairs(Pets[player]) do
			pet.State = "Destroyed"
			if pet.Object then pet.Object:Destroy() end
		end
		Pets[player] = nil
		petDataLoaded[player] = nil
	end
	
end
game.Players.PlayerRemoving:connect(PlayerRemoving)



function SaveData(player)

	if Players[player] and petDataLoaded[player] then
		--if player.Name ~= "Dued1" and player.Name ~= "Player" and player.Name ~= "Player1" then return end
		if Pets[player] == nil or #Pets[player] == 0 then return false end --helps prevents overwritting pet saved data if there is an error
		
		local petData = {}
		
		for _,pet in ipairs(Pets[player]) do
			if pet.AllowSaving then
				table.insert(petData,1,{
					Name = pet.Name,
					PrimaryColor = pet.PrimaryColor,
					SecondaryColor = pet.SecondaryColor,
					Type = pet.Type,
					FeedLevel = pet.FeedLevel,
					PetLevel = pet.PetLevel,
					SleepLevel = pet.SleepLevel,
					PlayLevel = pet.PlayLevel,
					Active = pet.Active,
					CustomHatName = pet.CustomHatName,
				})
			end
		end
		
		if not DataStore or game:GetService("RunService"):IsStudio() or Players[player].IsTestPlayer then return true end
		
		print("Saved pet data")
		return pcall(function()
			DataStore:SetAsync(player.userId,petData)
		end)
	
	end
	return false
end






function GetPetByName(player,name)
	for _,pet in ipairs(Pets[player]) do
		if pet.Name == name then
			return pet
		end
	end
end


function PetRemoved(pet)
	if pet.Owner.Value and pet.Owner.Value.Parent == game.Players and pet.Parent ~= game.ReplicatedStorage then
		local pet = GetPetByName(pet.Owner.Value,pet.Name)
		if pet and pet.AllowSaving and pet.State ~= "Destroyed" then
			pet:SetState("Destroyed")
			wait(11)  --wait for all the old threads to end\ 
			if pet then
				pet:SetState("Follow")
				pet:SpawnPet()
				workspace.PetService.PetObjectChanged:FireClient(pet.Owner,pet.Object)
				
				spawn(function() pet:StartAI() end)
			end

		end
	end
end
workspace.Pets.ChildRemoved:connect(PetRemoved)



function PackagePetData(pet)
	return 
	{
		["Name"] = pet.Name,
		["Type"] = pet.Type,
		["Active"] = pet.Active,
		["SleepMeter"] = {pet.SleepLevel,pet.Properties.SleepMax},
		["FeedMeter"] = {pet.FeedLevel,pet.Properties.FeedMax},
		["PetMeter"] = {pet.PetLevel,pet.Properties.PetMax},
		["PlayMeter"] = {pet.PlayLevel,pet.Properties.PlayMax},
		["Object"] = pet.Object,
		
	}
end


workspace.PetService.SetCustomHat.OnServerEvent:connect(function(player,petName,customHatName,assetId,preview)
	if player and Players[player] and (assetId == nil or preview or Players[player]:GetInventoryItemById(assetId)) then --validate
		local Pet = GetPetByName(player,petName)
		if Pet then
			Pet:SetCustomHat(customHatName, not preview) --dont allow saving if just previewing
		end
	end
end)


workspace.PetService.FeedPet.OnServerEvent:connect(function(player,petName)
	local Pet = GetPetByName(player,petName)
	if Pet then
		if Pet.Active and Pet.State ~= "Sleeping" and Pet.State ~= "Eating" and Pet.State ~= "Destroyed" and Pet.FeedLevel < Pet.Properties.FeedMax then
			if player.Character and player.Character:FindFirstChild("Kibble") then player.Character.Kibble:Destroy() end --stop feeding other pet
			local kibble = game.ServerStorage.PetObjects.Kibble:clone()
			kibble.Parent = player.Character
			Pet:EatKibble(kibble.Handle)
		elseif Pet.FeedLevel >= Pet.Properties.FeedMax then
			Dialog:ShowMessage(player,"","Your pet is full.","Ok")
			
		end
	end
end)



workspace.PetService.PlayBall.OnServerEvent:connect(function(player,petName)
	local Pet = GetPetByName(player,petName)
	if Pet then
		if Pet.Active and Pet.State ~= "Sleeping" and Pet.State ~= "Playing" and Pet.State ~= "Destroyed" and Pet.PlayLevel < Pet.Properties.PlayMax then
			
			if player.Character and player.Character:FindFirstChild("Ball") then player.Character.Ball:Destroy() end
			
			local ball = game.ServerStorage.PetObjects.Ball:clone()
			ball.Parent = player.Backpack
			player.Character.Humanoid:EquipTool(ball)
			
			
			
			Pet:PlayBall(ball.Handle)
		elseif Pet.PlayLevel >= Pet.Properties.PlayMax then
			Dialog:ShowMessage(player,"","Your pet does not want to play right now.","Ok")
		end
	end
end)

function workspace.PetService.GetHeartParticles.OnServerInvoke(player,particle)
	if particle then
		particle:Destroy()
		return
	end
	
	local heart = game.ServerStorage.PetObjects.PetParticles.HeartParticlesPetting:clone()
	heart.Parent = workspace
	return heart
end





workspace.PetService.Petting.OnServerEvent:connect(function(player,action,petName,duration)
	local Pet = GetPetByName(player,petName)
	if Pet then
		if Pet.Active and Pet.State ~= "Destroyed" then
			if action == "Start" then
				Pet:StartPetting()
			elseif action == "Petting" then
				Pet:Petting(duration)
			elseif action == "Cancel" then
				Pet:CancelPetting()
			end
		elseif Pet.State == "Destroyed" then
			workspace.PetService.Petting:FireClient(Pet.Owner,"Cancel",Pet.Name,nil)
		end
	end
end)



workspace.PetService.PutToSleep.OnServerEvent:connect(function(player,petName)
	local Pet = GetPetByName(player,petName)
	if Pet then
		if Pet.Active and Pet.State ~= "Destroyed" and Pet.SleepLevel < Pet.Properties.SleepMax then	
			Pet:PutToSleep()
		elseif Pet.SleepLevel >= Pet.Properties.SleepMax then
			Dialog:ShowMessage(player,"","Your pet is not tired.","Ok")
		end
	end
end)






--------CUSTOMIZING PET------------------------


---Finished
function workspace.PetService.FinishedCustomizing.OnServerInvoke(player,petName)
	
	if not petDataLoaded[player] then
		Dialog:ShowMessage(player,"Error","There was an error loading your pets. You cannot buy new pets right now.")
		return false
	end
	
	
	local Pet = Pets[player][1] --new pets are first in table
	
		
	local cancel = false
	local numPets = #Pets[player]
	
	
	--prevent duplicate names
	for _,data in ipairs(Pets[player]) do
		if data.Name == petName then
			petName = " " .. petName .. " "
		end
	end
	

	Pet:SetName(petName)
	
	
	
	
	if not workspace.Main.BuyPetWithMoneyz:Invoke(player)then
		Dialog:ShowMessage(player,"","You don't have enough Moneyz.","Ok")
		Pet:SetState("Destroyed")
		Pet.Object:Destroy()
		table.remove(Pets[player],1)
		return false
	end
		
	local success = ProcessPurchase(player)
	if not success  then
		Pet:SetState("Destroyed")
		Pet.Object:Destroy()
		table.remove(Pets[player],1)
		Dialog:ShowMessage(player,"Error","There was an error. Try again another time.")
		Players[player]:AddMoneyz(Enums.PetPrice)
		return false
	end
		
	return true
		
	
end




function ProcessPurchase(player)
	local Pet = Pets[player][1]
	if Pet then
		Pet:SetState("Follow")
		Pet:TeleportToOwner()
		Pet.AllowSaving = true
		workspace.PetService.PetCreated:FireClient(player,PackagePetData(Pet))
		if not SaveData(player) then
			print("Could not save pet, canceling purchase")
			return false
		end
		return true
	else
		return false
	end
end

script.ProcessPurchase.OnInvoke = ProcessPurchase







--
workspace.PetService.CustomizePet.OnServerEvent:connect(function(player,action,data)
	
	if action == "Start" then
		
		if not petDataLoaded[player] then
			Dialog:ShowMessage(player,"Error","There was an error loading your pets. You cannot buy new pets right now.")
			return
		end
		
		local Pet = require(script.Parent.Pet).new(player,{})
		Pet.AllowSaving = false --allow saving once it's create
		Pet:SpawnPet()
		Pet:SetState("Customize")		--hold pet still while player customizes
		
		Pet:SetType("Default")
		Pet:SetPrimaryColor(1013)
		Pet:SetSecondaryColor(1013)
		
		if game.Lighting.TimeOfDay > tostring(17) then  --light up pet if past 17:00:00
			local light = Instance.new("PointLight")
			light.Color = Color3.new(217/255,203/255,0)
			light.Range = 9
			light.Shadows = true
			light.Brightness = 100
			light.Parent = Pet.Object
		end
		
		local numPetsOwned = #Pets[player]
		
		spawn(function() Pet:StartAI() end)

		table.insert(Pets[player],1,Pet)  --add to list of pets
		
		
		workspace.PetService.CustomizePet:FireClient(player,Pet.Object,numPetsOwned)
	
	elseif action == "Cancel" then
		local Pet = Pets[player][1] --new pets are first in table
		if Pet and not Pet.AllowSaving then
			Pet:SetState("Destroyed")
			Pet.Object:Destroy()
			table.remove(Pets[player],1)
		end
	
	
	elseif action == "TypeChanged" then
		local Pet = Pets[player][1]
		if Pet then
			Pet:SetType(data)
		end
	
	elseif action == "PrimaryChanged" then
		local Pet = Pets[player][1]
		if Pet then
			Pet:SetPrimaryColor(data)
		end
	
	elseif action == "SecondaryChanged" then
		local Pet = Pets[player][1]
		if Pet then
			Pet:SetSecondaryColor(data)
		end
	end
	
	
end)


function workspace.PetService.GetRandomPetWithinRange.OnInvoke(range,this)
	local pets = {}
	for _,pet in ipairs(Pets[this.Owner]) do
		if this ~= pet and this.Object and (this.Object.Position - pet.Object.Position).magnitude < range then
			table.insert(pets,pet)
		end
	end
	if #pets == 0 then return nil end
	return pets[math.random(1,#pets)]
end


function workspace.PetService.Command.OnServerInvoke(player,petName,action)
	local Pet = GetPetByName(player,petName)
	if Pet and Pet.Active and Pet.State ~= "Sleeping" and Pet.State ~= "Destroyed" then
		if action == "Stop" then
			Pet.State = "Follow"
		elseif action == "Hold" then
			Pet.State = "Holding"
		elseif action == "Stay" then
			Pet.State = "Staying"
			Pet.Object.Stay.Value = true
		elseif action == "StopCommand" then
			if Pet.State == "Holding" then
				Pet.State = "Follow"
			end
		end
	else 
		return false
	end
	return true
end



function workspace.PetService.ToggleActive.OnServerInvoke(player,petName)
	local Pet = GetPetByName(player,petName)
	if Pet then
		if Pet.State == "Destroyed" then return Pet.Active end
		if Pet and not Pet.Active then  --if about to be activated
			local activePetsCount = 0
			for name,pet in pairs(Pets[player]) do
				if pet.Active then
					activePetsCount = activePetsCount + 1
				end
			end
			if activePetsCount >= MaxNumPets then
				return nil
			end
		end
		return Pet:SetActive(not Pet.Active)
	end
	return false
end



function workspace.PetService.GetPetData.OnServerInvoke(player)
	while petDataLoaded[player] == nil do wait(.1) end
	if not Pets[player] then return {} end
	local petData = {}
	for _,pet in pairs(Pets[player]) do
		table.insert(petData,PackagePetData(pet))
	end
	return petData
end

