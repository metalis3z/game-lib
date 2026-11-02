--[[
	sickMeter
	movementSpeed
	attentionMeter
	
	hungerMeter
	happinessMeter
	
	
	Look at object
	States
		Following
		Crying for food
		Crying from neglect
		Sleeping
		Sitting on shoulder
		Eating
		
		
--]]

local ServerScriptService = script.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local AssetLibraryManager = Global.AssetLibraryManager

local Pet = {}
Pet.__index = Pet


local levels =
{
	["High"] = 1,
	["Medium"] = 0,
	["Low"] = -1
}


local eyes = {
	["Normal"] = "rbxassetid://318581276",
	["Sleep"] = "rbxassetid://318581259",
	["Sad"] = "rbxassetid://315795267",
	["Happy"] = "rbxassetid://315800257",
}

local mouth = {
	["Smile"] = "rbxassetid://315795412",
	["Open"] = "rbxassetid://315656689",
	["Sleep"] = "rbxassetid://315795403",
	["Frown"] = "rbxassetid://315795369",
	
}

breedProperties = {
	["Default"] = {
		Size = 1.1,
		Speed = 100,
		FollowRadius = 8,
		BobAmplitude = 2, BobSpeed = 20,
		EnergyBurstFrequency = {7,15}, EnergyBurstLength = {2,5}, 
		FeedMax = 4, PetMax = 3, SleepMax = 3, PlayMax = 3,
		EatingSpeed = 2,  --seconds
		MovementFrequency = {1,1.5}, --.1 fast, 2 slow
		MouthOpenLength = {1.4,2.2},
		SitOnPlayerLength = {5,9},LookAtOwnerLength = {2,4},LookAtNearbyPlayersLength = {3,5},LookAtNearbyPetsLength = {1,4},
		SitOnPlayerFrequency = 20, LookAtOwnerFrequency = 10, LookAtNearbyPlayersFrequency = 10, LookAtNearbyPetsFrequency = 10, --20 = low, 5 = very high
		FeedRate = 300,SleepRate = 400,PetRate = 300,PlayRate = 360
	},
	
	["Bunny"] = {
		Size = 1,
		Speed = 100,
		FollowRadius = 7,
		BobAmplitude = 4, BobSpeed = 25,
		EnergyBurstFrequency = {9,15}, EnergyBurstLength = {3,4}, 
		FeedMax = 2, PetMax = 5, SleepMax = 2, PlayMax = 3,
		EatingSpeed = 3,  --seconds
		MovementFrequency = {1,2}, --.1 fast, 2 slow
		MouthOpenLength = {1,3},
		SitOnPlayerLength = {4,5},LookAtOwnerLength = {3,7},LookAtNearbyPlayersLength = {5,10},LookAtNearbyPetsLength = {3,10},
		SitOnPlayerFrequency = 20, LookAtOwnerFrequency = 30, LookAtNearbyPlayersFrequency = 5, LookAtNearbyPetsFrequency = 5, --20 = low, 5 = very high
		FeedRate = 500,SleepRate = 560,PetRate = 380,PlayRate = 520 
	},
	
	["Dog"] = {
		Size = 1.2,
		Speed = 100,
		FollowRadius = 7,
		BobAmplitude = 2, BobSpeed = 30,
		EnergyBurstFrequency = {9,15}, EnergyBurstLength = {3,4}, 
		FeedMax = 5, PetMax = 5, SleepMax = 3, PlayMax = 5,
		EatingSpeed = 3,  --seconds
		MovementFrequency = {.9,1.5}, --.1 fast, 2 slow
		MouthOpenLength = {5,8},
		SitOnPlayerLength = {4,9},LookAtOwnerLength = {3,4},LookAtNearbyPlayersLength = {5,6},LookAtNearbyPetsLength = {3,5},
		SitOnPlayerFrequency = 10, LookAtOwnerFrequency = 5, LookAtNearbyPlayersFrequency = 5, LookAtNearbyPetsFrequency = 5, --20 = low, 5 = very high
		FeedRate = 400,SleepRate = 460,PetRate = 280,PlayRate = 500 
	},
	["Cat"] = {
		Size = 1,
		Speed = 75,
		FollowRadius = 6,
		BobAmplitude = 2, BobSpeed = 20,
		EnergyBurstFrequency = {20,30}, EnergyBurstLength = {10,12}, 
		FeedMax = 2, PetMax = 2, SleepMax = 4, PlayMax = 2,
		EatingSpeed = 3,  --seconds
		MovementFrequency = {.9,1.5}, --.1 fast, 2 slow
		MouthOpenLength = {2,3},
		SitOnPlayerLength = {4,9},LookAtOwnerLength = {3,4},LookAtNearbyPlayersLength = {5,6},LookAtNearbyPetsLength = {3,5},
		SitOnPlayerFrequency = 10, LookAtOwnerFrequency = 20, LookAtNearbyPlayersFrequency = 20, LookAtNearbyPetsFrequency = 20, --20 = low, 5 = very high
		FeedRate = 600,SleepRate = 660,PetRate = 400,PlayRate = 1000 
	},
	["Cub"] = {
		Size = 1,
		Speed = 300,
		FollowRadius = 6,
		BobAmplitude = 1.5, BobSpeed = 20,
		EnergyBurstFrequency = {9,15}, EnergyBurstLength = {3,4}, 
		FeedMax = 3, PetMax = 3, SleepMax = 5, PlayMax = 4,
		EatingSpeed = 4,  --seconds
		MovementFrequency = {.9,1.5}, --.1 fast, 2 slow
		MouthOpenLength = {2,3},
		SitOnPlayerLength = {3,15},LookAtOwnerLength = {2,3},LookAtNearbyPlayersLength = {3,5},LookAtNearbyPetsLength = {5,15},
		SitOnPlayerFrequency = 40, LookAtOwnerFrequency = 10, LookAtNearbyPlayersFrequency = 30, LookAtNearbyPetsFrequency = 50, --20 = low, 5 = very high
		FeedRate = 400,SleepRate = 280,PetRate = 460,PlayRate = 440 
	},
	["Mouse"] = {
		Size = .75,
		Speed = 500,
		FollowRadius = 6,
		BobAmplitude = 2.5, BobSpeed = 20,
		EnergyBurstFrequency = {7,15}, EnergyBurstLength = {2,5}, 
		FeedMax = 2, PetMax = 4, SleepMax = 3, PlayMax = 3,
		EatingSpeed = 3,  --seconds
		MovementFrequency = {.8,1.5}, --.1 fast, 2 slow
		MouthOpenLength = {1.4,2.2},
		SitOnPlayerLength = {5,12},LookAtOwnerLength = {2,4},LookAtNearbyPlayersLength = {5,10},LookAtNearbyPetsLength = {2,3},
		SitOnPlayerFrequency = 10, LookAtOwnerFrequency = 10, LookAtNearbyPlayersFrequency = 5, LookAtNearbyPetsFrequency = 5, --20 = low, 5 = very high
		FeedRate = 500,SleepRate = 300,PetRate = 400,PlayRate = 600
	},
	["Monkey"] = {
		Size = 1.15,
		Speed = 50, 
		FollowRadius = 7,
		BobAmplitude = 4, BobSpeed = 30,
		EnergyBurstFrequency = {7,15}, EnergyBurstLength = {2,5}, 
		FeedMax = 3, PetMax = 2, SleepMax = 2, PlayMax = 2,
		EatingSpeed = 2,  --seconds
		MovementFrequency = {2,2.5}, --.1 fast, 2 slow
		MouthOpenLength = {2,4},
		SitOnPlayerLength = {8,10},LookAtOwnerLength = {2,4},LookAtNearbyPlayersLength = {3,5},LookAtNearbyPetsLength = {3,5},
		SitOnPlayerFrequency = 5, LookAtOwnerFrequency = 30, LookAtNearbyPlayersFrequency = 20, LookAtNearbyPetsFrequency = 10, --20 = low, 5 = very high
		FeedRate = 500 ,SleepRate = 630,PetRate = 600,PlayRate = 530 
	},
	["Plant"] = {
		Size = .95,
		Speed = -100,
		FollowRadius = 11,
		BobAmplitude = 5, BobSpeed = 20,
		EnergyBurstFrequency = {20,40}, EnergyBurstLength = {5,12}, 
		FeedMax = 2, PetMax = 4, SleepMax = 2, PlayMax = 2,
		EatingSpeed = 4,  --seconds
		MovementFrequency = {2,2.5}, --.1 fast, 2 slow
		MouthOpenLength = {.1,.5},
		SitOnPlayerLength = {10,20},LookAtOwnerLength = {5,20},LookAtNearbyPlayersLength = {2,5},LookAtNearbyPetsLength = {3,4},
		SitOnPlayerFrequency = 40, LookAtOwnerFrequency = 500, LookAtNearbyPlayersFrequency = 20, LookAtNearbyPetsFrequency = 10, --20 = low, 5 = very high
		FeedRate = 600,SleepRate = 400,PetRate = 330,PlayRate = 600 
	},
	
	["Bug"] = {
		Size = .7,
		Speed = 400,
		FollowRadius = 8,
		BobAmplitude = 3.5, BobSpeed = 23,
		EnergyBurstFrequency = {10,20}, EnergyBurstLength = {5,12}, 
		FeedMax = 2, PetMax = 2, SleepMax = 2, PlayMax = 2,
		EatingSpeed = 4,  --seconds
		MovementFrequency = {.8,2.5}, --.1 fast, 2 slow
		MouthOpenLength = {.1,.5},
		SitOnPlayerLength = {10,20},LookAtOwnerLength = {5,20},LookAtNearbyPlayersLength = {2,5},LookAtNearbyPetsLength = {3,4},
		SitOnPlayerFrequency = 40, LookAtOwnerFrequency = 500, LookAtNearbyPlayersFrequency = 20, LookAtNearbyPetsFrequency = 10, --20 = low, 5 = very high
		FeedRate = 530,SleepRate = 500,PetRate = 630,PlayRate = 700 
	},
	
	["Elf"] = {
		Size = .94,
		Speed = 700,
		FollowRadius = 8,
		BobAmplitude = 2, BobSpeed = 30,
		EnergyBurstFrequency = {20,40}, EnergyBurstLength = {5,12}, 
		FeedMax = 3, PetMax = 4, SleepMax = 2, PlayMax = 3,
		EatingSpeed = 2,  --seconds
		MovementFrequency = {1,1.5}, --.1 fast, 2 slow
		MouthOpenLength = {2,4},
		SitOnPlayerLength = {10,20},LookAtOwnerLength = {5,20},LookAtNearbyPlayersLength = {1,5},LookAtNearbyPetsLength = {6,7},
		SitOnPlayerFrequency = 20, LookAtOwnerFrequency = 10, LookAtNearbyPlayersFrequency = 10, LookAtNearbyPetsFrequency = 5, --20 = low, 5 = very high
		FeedRate = 450,SleepRate = 500,PetRate = 640,PlayRate = 550 
	},
	["Jellyfish"] = {
		Size = .8,
		Speed = 30, 
		FollowRadius = 8,
		BobAmplitude = 4, BobSpeed = 15,
		EnergyBurstFrequency = {7,15}, EnergyBurstLength = {2,5}, 
		FeedMax = 2, PetMax = 2, SleepMax = 2, PlayMax = 2,
		EatingSpeed = 3,  --seconds
		MovementFrequency = {1,3}, --.1 fast, 2 slow
		MouthOpenLength = {0,.1},
		SitOnPlayerLength = {5,9},LookAtOwnerLength = {2,4},LookAtNearbyPlayersLength = {3,5},LookAtNearbyPetsLength = {3,5},
		SitOnPlayerFrequency = 100, LookAtOwnerFrequency = 20, LookAtNearbyPlayersFrequency = 20, LookAtNearbyPetsFrequency = 100, --20 = low, 5 = very high
		FeedRate = 700 ,SleepRate = 530,PetRate = 600,PlayRate = 830 
	},
	
	["Deer"] = {
		Size = 1.15,
		Speed = 100,
		FollowRadius = 8,
		BobAmplitude = 2, BobSpeed = 25,
		EnergyBurstFrequency = {7,15}, EnergyBurstLength = {2,5}, 
		FeedMax = 2, PetMax = 4, SleepMax = 4, PlayMax = 2,
		EatingSpeed = 2,  --seconds
		MovementFrequency = {2,2.5}, --.1 fast, 2 slow
		MouthOpenLength = {1.4,2.2},
		SitOnPlayerLength = {3,5},LookAtOwnerLength = {2,4},LookAtNearbyPlayersLength = {5,7},LookAtNearbyPetsLength = {3,4},
		SitOnPlayerFrequency = 8, LookAtOwnerFrequency = 20, LookAtNearbyPlayersFrequency = 10, LookAtNearbyPetsFrequency = 3, --20 = low, 5 = very high
		FeedRate = 560,SleepRate = 300,PetRate = 420,PlayRate = 500
	},
	
	["Lion"] = {
		Size = 1.3,
		Speed = 0, 
		FollowRadius = 14,
		BobAmplitude = 3, BobSpeed = 10,
		EnergyBurstFrequency = {7,15}, EnergyBurstLength = {2,5}, 
		FeedMax = 4, PetMax = 2, SleepMax = 3, PlayMax = 2,
		EatingSpeed = 1,  --seconds
		MovementFrequency = {2.5,3}, --.1 fast, 2 slow
		MouthOpenLength = {0,0},
		SitOnPlayerLength = {5,9},LookAtOwnerLength = {2,4},LookAtNearbyPlayersLength = {3,5},LookAtNearbyPetsLength = {3,5},
		SitOnPlayerFrequency = 100, LookAtOwnerFrequency = 20, LookAtNearbyPlayersFrequency = 20, LookAtNearbyPetsFrequency = 30, --20 = low, 5 = very high
		FeedRate = 180 ,SleepRate = 530,PetRate = 600,PlayRate = 430 
	},
	
	["Moose"] = {
		Size = 1.4,
		Speed = 50,
		FollowRadius = 11,
		BobAmplitude = 3.5, BobSpeed = 20,
		EnergyBurstFrequency = {7,15}, EnergyBurstLength = {2,5}, 
		FeedMax = 4, PetMax = 2, SleepMax = 3, PlayMax = 3,
		EatingSpeed = 2,  --seconds
		MovementFrequency = {2,2.5}, --.1 fast, 2 slow
		MouthOpenLength = {1.4,2.2},
		SitOnPlayerLength = {3,5},LookAtOwnerLength = {2,4},LookAtNearbyPlayersLength = {5,7},LookAtNearbyPetsLength = {3,4},
		SitOnPlayerFrequency = 8, LookAtOwnerFrequency = 20, LookAtNearbyPlayersFrequency = 10, LookAtNearbyPetsFrequency = 3, --20 = low, 5 = very high
		FeedRate = 560,SleepRate = 300,PetRate = 420,PlayRate = 500
	},
	
	["Bull"] = {
		Size = 1.35,
		Speed = 100,
		FollowRadius = 8,
		BobAmplitude = 1.5, BobSpeed = 15,
		EnergyBurstFrequency = {7,15}, EnergyBurstLength = {2,5}, 
		FeedMax = 5, PetMax = 2, SleepMax = 4, PlayMax = 2,
		EatingSpeed = 1,  --seconds
		MovementFrequency = {1,1.5}, --.1 fast, 2 slow
		MouthOpenLength = {0,0},
		SitOnPlayerLength = {3,8},LookAtOwnerLength = {2,4},LookAtNearbyPlayersLength = {3,5},LookAtNearbyPetsLength = {1,4},
		SitOnPlayerFrequency = 40, LookAtOwnerFrequency = 1000, LookAtNearbyPlayersFrequency = 30, LookAtNearbyPetsFrequency = 30, --20 = low, 5 = very high
		FeedRate = 180,SleepRate = 400,PetRate = 700,PlayRate = 500
	},
	
}


local Hats = {
	["Cowboy"] = 2000 --moneyz
}


local sitPositions = {
	Vector3.new(-1,0,0),
	Vector3.new(1,0,0),
	Vector3.new(0,-1,0)
}


function bodyMoversEnabled(this,enabled)
	local bodyPosition = this.Object.BodyPosition
	local bodyGyro = this.Object.BodyGyro
	if enabled then
		bodyPosition.MaxForce = Vector3.new(this.Object.Size.X * 40, 500, this.Object.Size.Z * 40)
		bodyGyro.MaxTorque = Vector3.new(0, 400000, 0)
	else
		bodyPosition.MaxForce = Vector3.new(0,0,0)
		bodyGyro.MaxTorque = Vector3.new(0, 0, 0)
	end
end

function Weld(x,y)
	local W = Instance.new("Weld")
	W.Name = "PizzaWeld"
	W.Part0 = x
	W.Part1 = y
	local CJ = CFrame.new(x.Position)
	local C0 = x.CFrame:inverse()*CJ
	local C1 = y.CFrame:inverse()*CJ
	W.C0 = C0
	W.C1 = C1
	W.Parent = x
end

function petWithinRange(range,this)
	local pets = {}
	local children = workspace.Pets:GetChildren()
	for _,pet in ipairs(children) do
		if this.Object ~= pet and (this.Object.Position - pet.Position).magnitude < range then
			table.insert(pets,pet)
		end
	end
	if #pets == 0 then return nil end
	return pets[math.random(1,#pets)]
end



	local function ConvertScale(input,inputRange,outputRange)
		local inputRangeMin = inputRange[1]
		local inputRangeMax = inputRange[2]
		local outputRangeMin  = outputRange[1]
		local outputRangeMax = outputRange[2]
		local scale = (input - inputRangeMin) / (inputRangeMax - inputRangeMin)
		return ((outputRangeMax - outputRangeMin) * scale) + outputRangeMin
	end
	--1.4 .7,1.5   9,10
	

function playerWithinRange(range,this)
	local players = {}
	local children = game.Players:GetPlayers()
	for _,player in ipairs(children) do
		if player ~= this.Owner and player.Character and player.Character:FindFirstChild("Head") and (this.Object.Position - player.Character.Head.Position).magnitude < range then
			table.insert(players,player)
		end
	end
	if #players == 0 then return nil end
	return players[math.random(1,#players)].Character.Head
end


function SitOnShoulder(self,state)
	local W = nil
	if (self.Owner.Character and self.Owner.Character:FindFirstChild("Head")) then
		
		local rand = math.random(1,3)
		while self.Owner and self.State ~= "Destroyed" and self.Owner.Character:FindFirstChild("Head"):FindFirstChild(rand) do  --if pet is already in that position then there will be a weld in the head
			rand = math.random(1,3)
			wait(.1) 
		end 
		
		if self.State == "Destroyed" then return end
		
		local randomPosition = sitPositions[rand]
		local playerHeadRadius = self.Owner.Character.Head.Size.Y/2
		local petHeadRadius = self.Object.Size.X/2
		local bodyPosition = self.Object.BodyPosition
		local bodyGyro = self.Object.BodyGyro
		
		local reserve = Instance.new("IntValue")
		reserve.Name = rand
		reserve.Parent = self.Owner.Character.Head
		self.Reserve = reserve
		
		--adjust position if sitting on head or shoulders
		local position = nil
		if rand ~= 3 then
			position = randomPosition * (petHeadRadius+playerHeadRadius+.2) - Vector3.new(0,-playerHeadRadius+petHeadRadius-(petHeadRadius/4),0)  --move to left and add .2 to give a little extra space then bring the pet down to the shoulder
		else  
			position = Vector3.new(0,-(playerHeadRadius+petHeadRadius-(petHeadRadius/4)),0)
		end


		while self.State == state and self.Owner.Character  do
			bodyPosition.position = self.Owner.Character.Head.CFrame:pointToWorldSpace(-position)
			bodyGyro.cframe = CFrame.new( self.Object.Position, self.Object.Position - ((self.Object.Position - bodyPosition.Position).unit) * 2 )
			if (bodyPosition.position - self.Object.Position).magnitude < .5 then
				bodyMoversEnabled(self,false)
				break
			end
			wait(.1)
		end
		if self.State == "Destroyed" then return end
		
		
		--self.Object.Size = self.Object.Size - Vector3.new(0,self.Object.Size.Y/4,0) -- squish the pet
		
		
		if self.Owner.Character and self.Owner.Character:FindFirstChild("Head") then
			W = Instance.new("Weld")
			W.Name = rand
			W.Part0 = self.Owner.Character.Head
			W.Part1 = self.Object
			W.C1 = CFrame.new(position)
			W.Parent = self.Owner.Character.Head
			
			self.HeadWeld = W
		end
		
		
	end
end




local hatRotation = {
	["Dog"] = CFrame.Angles(0,math.pi,0),
	["Bull"] = CFrame.Angles(0,math.pi,0),
}


function WeldToMouth(pet,object,rotation)
	local size = pet.Size.Y
	local angle = 335
	local X = math.cos(math.rad(angle))
	local Y = math.sin(math.rad(angle))
	local unitY = Y *(size/2)
	local unitX = X *(size/2)	
	
	local W = Instance.new("Weld")
	W.Name = object.Name .. "Weld"
	W.Part0 = pet
	W.Part1 = object
	W.C0 = CFrame.new(0,unitY,-unitX) 
											--W.C1 = CFrame.new(pet.CFrame:pointToWorldSpace(Vector3.new(0,-unitY,unitX ))) --* hatRotation[type]
	if rotation then
		W.C0 = W.C0 * rotation
	end
	W.Parent = pet
	
end

function AttachHat(this,animalType,customHatName)
	
	if animalType and this.Object:FindFirstChild("Hat") then this.Object.Hat:Destroy() end
	if customHatName and this.Object:FindFirstChild("CustomHat") then this.Object.CustomHat:Destroy() end
	
	if not animalType and not customHatName then return end --if there isnt a custom hat
	
	local hat = Instance.new("Part")
	hat.Name = (animalType and "Hat") or "CustomHat"
	hat.FormFactor = "Custom"
	hat.Size = Vector3.new(.2,.2,.2)
	hat.Parent = this.Object
	hat.BrickColor = BrickColor.new(this.SecondaryColor)
	hat.CanCollide = false
	hat.Locked = true
	if customHatName then --custom phsical properties didnt exits before, now I can make new hats weightless
		hat.CustomPhysicalProperties = PhysicalProperties.new(0,.4,.25) 
	end
	--hat:SetNetworkOwner(this.Owner)
	--hat.Parent:SetNetworkOwner(this.Owner)
	
	this.Hat = hat
	
	local rotation = nil
	if animalType and hatRotation[animalType] then
		rotation = hatRotation[animalType]
	end
		
	--scale hat mesh
	local defaultSize = 1.5 --all pet parts fit on a 1.5,1.5,1.5 sized pet
	local newSize = this.Object.Size.Y/defaultSize
	if animalType ~= "Default" or customHatName then
		local mesh = (animalType and game.ServerStorage.PetObjects.PetParts[animalType]:clone()) or AssetLibraryManager:GetAssetByName(customHatName).Object:clone()
		mesh.Scale = Vector3.new(mesh.Scale.X*newSize,mesh.Scale.Y*newSize,mesh.Scale.Z*newSize)
		mesh.Offset = Vector3.new(mesh.Offset .X*newSize,mesh.Offset .Y*newSize,mesh.Offset .Z*newSize)
		mesh.Parent = hat
	else
		hat.Transparency = 1
	end
	
	WeldToMouth(this.Object,hat,rotation)
	
	return hat
end


function Joy(self,meter,max_meter)
	
	if self.State == "Destroyed" then return end
	
	if meter and meter >= max_meter then return end   --don't joy if meter is already full
	
	local Eyes = self.Object.Eyes
	local Mouth = self.Object.Mouth
	Eyes.Texture = eyes["Happy"]
	Mouth.Texture = mouth["Open"]
	self.EmotionState = "Joy"
	local heart = game.ServerStorage.PetObjects.PetParticles.HeartParticles:clone()
	heart.Parent = self.Object
	self.Object.Joy:Play()
	
	delay(math.random(300,500)/100,function()
		if self.State == "Destroyed" then return end
		
		if self.State ~= "Sleeping" then
			Eyes.Texture = eyes["Normal"]
			Mouth.Texture = mouth["Smile"]
		end
		
		self.EmotionState = "Normal"
		heart.Enabled = false
		wait(2)
		if self.State == "Destroyed" then return end
		heart:Destroy()
	end)
	
end

function Pet:TeleportToOwner()
	if self.Owner and self.Owner.Character and self.Owner.Character:FindFirstChild("HumanoidRootPart") then
		local position = self.Owner.Character.HumanoidRootPart.Position
		self.Object.Position = position
		self.Object.BodyPosition.position = position
		if self.Hat then self.Hat:Destroy() end
		self.Hat = AttachHat(self,self.Type)
		self.CustomHat = AttachHat(self,nil,self.CustomHatName)
	end
end



function Pet:SetActive(active)
	if self.State == "Destroyed" then return end
	if not active then 
		self.Active = false
		self.Object.Parent = game.ReplicatedStorage
		self.State = "Deactivated"
	else
		if self.Object == nil then
			self:SpawnPet()
			workspace.PetService.PetObjectChanged:FireClient(self.Owner,self.Object)
			--spawn(function() self:StartAI() end)
		else
			
			self.Active = true
			self.Object.Parent = workspace.Pets
			self:TeleportToOwner()
			self.State = "Follow"
			
		end

	end
	return active
end











----Set Values-----------------------------------------
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


function Pet:SetState(state)
	self.State = state
	if state == "Customize" and self.Owner.Character then
		self.Object.Position = Vector3.new(self.Owner.Character.HumanoidRootPart.Position.X, 150,self.Owner.Character.HumanoidRootPart.Position.Z)
		self.Object.BodyPosition.Position = self.Object.Position
		--[[if self.Hat then self.Hat:Destroy()
			self.Hat = AttachHat(self,self.Type)
		end]]
	end
end

function Pet:SetPrimaryColor(color)
	self.PrimaryColor = color
	self.Object.BrickColor = BrickColor.new(color)
end

function Pet:SetSecondaryColor(color)
	self.SecondaryColor = color
	self.Object.Hat.BrickColor = BrickColor.new(color)
end

function Pet:SetCustomHat(hatName,save)
	if save then
		self.CustomHatName = hatName
	end
	if hatName == nil and not save then --reset hat back to original hat after player has finished previewing hats
		self.CustomHat = AttachHat(self,nil,self.CustomHatName)
	else
		self.CustomHat = AttachHat(self,nil,hatName)
	end
	
end

function Pet:SetType(type)
	
	
	self.Properties = breedProperties[type]
	self.Object.Size = Vector3.new(self.Properties.Size,self.Properties.Size,self.Properties.Size)
	self.Object.FloatForce.Force = Vector3.new(0,self.Object:GetMass()*196.2,0)
	
	
	self.Type = type
	self.Hat = AttachHat(self,type)
	self.Hat.BrickColor = BrickColor.new(self.SecondaryColor)
	
	if type == "Cat" then -- add cat nose
		game.ServerStorage.PetObjects.Nose:clone().Parent = self.Object
	elseif self.Object:FindFirstChild("Nose") then
		self.Object.Nose:Destroy()
	end
	
	
end

function Pet:SetName(name)
	self.Name = name
	self.Object.NameBillboard.PetName.Text = name
	self.Object.Name = name

	workspace.Main.FilterPlayerText:FireAllClients(self.Owner,self.Object.NameBillboard.PetName,"Text")

end




--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\











--FEED-------------------------------------------
function Pet:EatKibble(kibbleHandle)
	
	if self.State == "Eatting" or self.State == "Sleeping" then kibbleHandle.Parent:Destroy() return end
	self.KibbleObject = kibbleHandle
	self.State = "Eatting"
end




--PLAY---------------------------------------------
function Pet:PlayBall(ballHandle)
	
	if self.State == "Playing" or self.State == "Sleeping" then ballHandle.Parent:Destroy() return end
	self.Ball = ballHandle
	self.State = "Playing"
	self.Object.Eyes.Texture = eyes["Normal"]
	self.Object.Mouth.Texture = mouth["Open"]
	
	
	
end


--PETTING-------------------------------------------
function Pet:StartPetting()
	
	if self.State == "Sleeping" or self.State == "Petting" or self.PetLevel >= self.Properties.PetMax then 

		workspace.PetService.Petting:FireClient(self.Owner,"Cancel",self.Name,nil)
		return
	end
	

	self.State = "Petting"
	self.SoundPlayed = false
end

function Pet:CancelPetting()
	if self.State == "Petting" then
		self.State = "Follow"
		
		workspace.PetService.Petting:FireClient(self.Owner,"Cancel",self.Name,nil)
	end
end

function Pet:Petting(duration)
	if self.State ~= "Petting" then return end
	if not self.LastDuration then
		self.LastDuration = 0
	end
	
	
	local Eyes = self.Object.Eyes
	local Mouth = self.Object.Mouth
	if duration == 0 then
		Eyes.Texture = eyes["Normal"]
		Mouth.Texture = mouth["Open"]
	elseif duration < 50 then
		
		Eyes.Texture = eyes["Sleep"]
		Mouth.Texture = mouth["Open"]
		if not self.SoundPlayed then
			self.SoundPlayed = true
			self.Object.Satisfied:Play()
		end
	elseif duration < 200 then
		
		Eyes.Texture = eyes["Sleep"]
		Mouth.Texture = mouth["Open"]
		
	else
		Eyes.Texture = eyes["Sleep"]
		Mouth.Texture = mouth["Sleep"]
	end
	
	if self.LastDuration > duration then  --if duration resets
		self.LastDuration  = 0
	end
	
	if math.abs(self.LastDuration - duration) > 100 then  --increment meter every 100 duration
		
		self.LastDuration = duration --debounce
		
		if self.PetLevel < self.Properties.PetMax then
			self.PetLevel = self.PetLevel + 1
			workspace.PetService.MeterChanged:FireClient(self.Owner,self.Name,"PetMeter",self.PetLevel)
			
		end
		
		if self.PetLevel >= self.Properties.PetMax then
			self.LastDuration = 0
			Eyes.Texture = eyes["Normal"]
			Mouth.Texture = mouth["Open"]
			self.Object.Joy:Play()
			self.State = "Staying" --debounce
			wait(1)
			if self.State == "Destroyed" then return end
			Mouth.Texture = mouth["Smile"]
			self.State = "Follow"
			workspace.PetService.Petting:FireClient(self.Owner,"Cancel",self.Name,nil)
			

		end
	end
end


--Sleep---------------------------------------------------------
function Pet:PutToSleep()
	
	if self.State == "Sleeping" then return end
	self.State = "Sleeping"

end











--Spawn--0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0
function Pet:SpawnPet()
	
	print("Spawning pet")

	local object = game.ServerStorage.PetObjects.Pet:clone()
	object.Parent = workspace.Pets
	object.Size = Vector3.new(self.Properties.Size,self.Properties.Size,self.Properties.Size)
	object.FloatForce.Force = Vector3.new(0,object:GetMass()*196.2,0)
	object.Owner.Value = self.Owner
	object.Name = self.Name
	object.NameBillboard.PetName.Text = self.Name
	object.NameBillboard.StudsOffset = Vector3.new(0,object.Size.Y,0)
	object.BodyPosition.D = 1250 - self.Properties.Speed
	--self.Object.NameBillboard.PlayerToHideFrom = self.Owner
	object:SetNetworkOwner(self.Owner)
	object.BrickColor = BrickColor.new(self.PrimaryColor)
	self.Object = object
	
	self:TeleportToOwner()

	--adjust pitch of sound depending on size
	self.Object.Eat.Pitch = ConvertScale(object.Size.Y,{.7,1.5},{1.5,.8})
	self.Object.Satisfied.Pitch = ConvertScale(object.Size.Y,{.7,1.5},{1.75,1.25})
	self.Object.Joy.Pitch = ConvertScale(object.Size.Y,{.7,1.5},{1.6,.9})
	self.Object.Sleep.Pitch = ConvertScale(object.Size.Y,{.7,1.5},{1.5,.5})
	
	self.Hat.BrickColor = BrickColor.new(self.SecondaryColor)
	
	self.Active = true
	
	if self.Type == "Cat" then -- add cat nose
		game.ServerStorage.PetObjects.Nose:clone().Parent = object
	end
	
	for _,obj in ipairs(object:GetChildren()) do
		if obj:IsA("Sound") then
			obj.MaxDistance = 70
		end
	end
	
end





--/////////////////////////////////////////////////////////

function Pet:StartAI()
	
	

--Decrease Meters--------------------------------------------------------------------------------------------

	spawn(function()
		
		while self.State == "Customize" do
			wait(.1)
		end
	
		local Counters = {}
	
		while true do
			
			if self.State == "Destroyed" then break end
			
			if self.Active and self.State ~= "Sleeping" then
				for _,name in ipairs({"Feed","Sleep","Pet","Play"}) do
		
					if Counters[name.."Counter"] == nil then
						Counters[name.."Counter"] = self.Properties[name .. "Rate"]			
					end
					
					if Counters[name.."Counter"] <= 0 then
						if self[name .. "Level"] > 0 then
							self[name .. "Level"] = self[name .. "Level"] - 1
							workspace.PetService.MeterChanged:FireClient(self.Owner,self.Name,name .."Meter",self[name .. "Level"])
						end
						Counters[name.."Counter"] = self.Properties[name .. "Rate"]
					end
					
					Counters[name.."Counter"] = Counters[name.."Counter"] - 1
				end
			end
			
			wait(1)
		end
	end)
	
	
	while self.Object == nil do   --wait until spawnpet() is called
		wait(.1)
	end








--Blink-------------------------------><><><><><><><><><><><><><><><><><><><><<>

	local Eyes = self.Object:WaitForChild("Eyes",10)
	local Mouth = self.Object:WaitForChild("Mouth",10)
	local currentEyes = nil
	
	
	spawn(function()
		while true do
			if self.State == "Destroyed" then break end
			
			if self.State ~= "Sleeping" and self.EmotionState ~= "Joy" and self.State ~= "Petting" then
				currentEyes = Eyes.Texture
				
				Eyes.Texture = eyes["Sleep"]
				wait(.2)
				
				if self.State == "Destroyed" then break end
				
				if self.State ~= "Sleeping" then
					Eyes.Texture = currentEyes
				end
				wait(math.random(200,400)/100)
			end
			wait(.1)
		end
	end)
	

	--play cry sound when sad
	spawn(function()
		while true do
			wait(math.random(20,40))
			if self.State == "Destroyed" then return end
			if self.EmotionState == "Sad" and self.State == "Follow" then
				if self.Object:FindFirstChild("Sad") then
					self.Object.Sad.Pitch =  ConvertScale(self.Object.Size.Y,{.7,1.5},{1.5,.8}) + (math.random(-10,10)/100)  --value range
					self.Object.Sad:Play()
				end
			end
		end
	end)
	
	
--Emotion State-----:D:D:D:D:D:D:D:D:D:D:D:D:D:D:D:D:D:D:
	spawn(function()
		while true do
			wait(10)
			if self.State == "Destroyed" then break end
			if self.Active then
				
				if (self.FeedLevel == 0 or self.SleepLevel == 0 or self.PlayLevel == 0 or self.PetLevel == 0) and self.State == "Follow" and self.EmotionState ~= "Joy" then --if sad
					
					Eyes.Texture = eyes["Sad"]
					Mouth.Texture = mouth["Frown"]
					self.EmotionState = "Sad"
					
					
					
				
				elseif self.State == "Follow" and self.EmotionState ~= "Joy" then   --if happy
					
					self.EmotionState = "Normal"
					Eyes.Texture = eyes["Normal"]
					Mouth.Texture = mouth["Smile"]
					
					delay(math.random(1,7),function()
						if self.State == "Destroyed" then return end
						
						if self.State ~= "Sleeping" then  --open mouth
							Mouth.Texture = mouth["Open"]
							wait(math.random(self.Properties.MouthOpenLength[1]*100,self.Properties.MouthOpenLength[2]*100)/100)
							if self.State == "Destroyed" then return end
							Mouth.Texture = mouth["Smile"]
						end
					end)
					
				end
				
				
				
			end
			wait(.1)
		end
	end)
	
	
	
	
	
	local bobSpeed = self.Properties.BobSpeed
	local bobAmplitude = self.Properties.BobAmplitude
	local lookAtOwnerFrequency = self.Properties.LookAtOwnerFrequency
	local lookAtNearbyPlayersFrequency = self.Properties.LookAtNearbyPlayersFrequency
	local lookAtNearbyPetsFrequency = self.Properties.LookAtNearbyPetsFrequency
	local sitOnPlayerFrequency = self.Properties.SitOnPlayerFrequency
	local followRadius = self.Properties.FollowRadius
	local movementFrequency = self.Properties.MovementFrequency

	
	--Energy Burst-----------
	spawn(function()
		while true do
			
			if self.State == "Follow" and self.EmotionState ~= "Sad" then
				movementFrequency[1] = movementFrequency[1] / 2
				movementFrequency[2] = movementFrequency[2] / 2
				bobSpeed = bobSpeed * 2
				
				wait(math.random(self.Properties.EnergyBurstLength[1],self.Properties.EnergyBurstLength[2]))
				
				movementFrequency[1] = movementFrequency[1] * 2
				movementFrequency[2] = movementFrequency[2] * 2
				bobSpeed = bobSpeed / 2
				
			elseif self.State == "Destroyed" then
				break
			end
			
			wait(math.random(self.Properties.EnergyBurstFrequency[1],self.Properties.EnergyBurstFrequency[2]))
		end
	end)
	

	
	local bodyGyro = self.Object:WaitForChild("BodyGyro",1)
	local bodyPosition = self.Object:WaitForChild("BodyPosition",1)
		
	local i = 0  --for sine bobing
	
	
	
	local lookTarget = nil
	local chaseTarget = nil
	local size = self.Object.Size.Y
	local randomPos = Vector3.new(math.random(-followRadius*100,followRadius*100)/100,math.random(0,followRadius*100)/100,math.random(-followRadius*100,followRadius*100)/100)
	local lastState = nil
	
	delay(math.random(0,200)/100,function()
		Joy(self)
	end)
	
	
	while true do
		
		
		while not self.Active and self.State ~= "Destroyed" do
			wait(.1)
		end
		
		
		
--Follow-------------------------------------------------------------------------------
		if self.State == "Follow" then
			local subState = "Follow" --look at player, sit on player shoulder, chase
			bodyMoversEnabled(self,true)
			spawn(function()
				while self.State == "Follow" do
					
					local petObject = self.Object
					local petObjectPosition = self.Object.Position
					for index = 1,10 do
						
						local newRandomPos = Vector3.new(math.random(-followRadius*100,followRadius*100)/100,math.random(0,followRadius*100)/100,math.random(-followRadius*100,followRadius*100)/100)
						local distance = size * 3
						if ((petObjectPosition + newRandomPos) - (petObjectPosition + (petObject.CFrame.lookVector * (distance/2)))).magnitude  < distance and petObject.CFrame:pointToObjectSpace(petObjectPosition + newRandomPos).z < 0 then
							randomPos = newRandomPos
							break
						end
					end
					if self.State == "Destroyed" then break end
					wait(math.random(movementFrequency[1]*100,movementFrequency[2]*100)/100)
				end
			end)
			
			spawn(function()
			
				while self.State == "Follow" do
					
					local lookAtOwner = math.random(1,lookAtOwnerFrequency)
					local lookAtNearbyPlayers = math.random(1,lookAtNearbyPlayersFrequency)
					local lookAtNearbyPets = math.random(1,lookAtNearbyPetsFrequency)
					local sitOnShoulder = math.random(1,sitOnPlayerFrequency)
					
					if self.EmotionState == "Sad" then
						lookAtOwner = math.random(1,math.floor(lookAtOwnerFrequency/2)) --look at owner more when sad
					end
					
					if sitOnShoulder == 1 and self.Owner.Character and self.Owner.Character:FindFirstChild("Head") and (self.Object.Position - self.Owner.Character.Head.Position).magnitude < 5 and self.EmotionState ~= "Sad" then
					
						self.State = "Sitting"
					
					elseif lookAtOwner == 1 and self.Owner.Character and self.Owner:FindFirstChild("Head") then
						lookTarget = self.Owner.Character.Head
						wait(math.random(self.Properties.LookAtOwnerLength[1],self.Properties.LookAtOwnerLength[2]))
						if self.State == "Follow" then
							lookTarget = nil
						end
						
					elseif lookAtNearbyPlayers == 1 and self.EmotionState ~= "Sad" then
						lookTarget = playerWithinRange(10,self)
						if lookTarget then
							wait(math.random(self.Properties.LookAtNearbyPlayersLength[1],self.Properties.LookAtNearbyPlayersLength[2]))
							if self.State == "Follow" then
								lookTarget = nil
							end
						end
					elseif lookAtNearbyPets == 1  and self.EmotionState ~= "Sad" then
						local closePet = petWithinRange(10,self)--workspace.PetService.GetRandomPetWithinRange:Invoke(10,self)
						if closePet then--and closePet.State == "Follow" then
							lookTarget = closePet
							wait(math.random(self.Properties.LookAtNearbyPetsLength[1],self.Properties.LookAtNearbyPetsLength[2]))
							if self.State == "Follow" then
								lookTarget = nil
							end
							--chaseTarget = closePet
							--self.State = "Chase"
							--while self.State == "Chase" do wait(.1) end
						end
					end
					wait(1)
				end
			end)
			local owner = self.Owner
			local petObject = self.Object
			
			
			while self.State == "Follow" do
				
				i = i + bobSpeed
				
				if lookTarget then
				
					bodyPosition.Position = lookTarget.Position + Vector3.new(randomPos.X,0,randomPos.Z) + Vector3.new(0,math.sin(math.rad(i))/bobAmplitude,0)--
					bodyGyro.cframe = CFrame.new( petObject.Position, lookTarget.Position )
									
				
				else
					
					pcall(function() bodyPosition.Position = owner.Character.HumanoidRootPart.Position + randomPos + Vector3.new(0,math.sin(math.rad(i))/bobAmplitude,0) end)
					bodyGyro.cframe = CFrame.new( petObject.Position, petObject.Position - ((petObject.Position - bodyPosition.Position).unit) * 2)
					
				end
				wait(.1)
			end
		
		
			
			
--Playing-----------------------------------------------------------------------------------------------------------------------------------------------------------
		elseif self.State == "Playing"  then
			bodyMoversEnabled(self,true)
			local size = self.Object.Size.Y
			local bp = self.Object.BodyPosition
			bp.D = 150
			bp.MaxForce = Vector3.new(50 * size,50 * size,50 * size)
			bp.P = 3000
			local ball = self.Ball
			local petObject = self.Object
			local stillChasing = true
			local ballThrown = false
			spawn(function()
				while ball.Parent ~= workspace and self.State == "Playing" do  --wait for ball to be thrown
					wait(.1)
				end
				wait(math.random(3,5))
				if stillChasing and self.State ~= "Destroyed" and self.State == "Playing" then  --if still hasnet reached ball, slow down the pet
					local bp = self.Object.BodyPosition
					bp.D = 1250 - self.Properties.Speed
					bp.P = 2000
				end
			end)
			
			while self.State == "Playing" and self.Owner.Character do
				if ball and ball.Parent then
					
					if ball.Parent == workspace then  --chase ball
						
						local angle = 330
						local X = math.cos(math.rad(angle))
						local Y = math.sin(math.rad(angle))
		
						local unitY = Y *(size/2)
						local unitX = X * (size/2)																				---((kibbleSize/2)+(self.Object.Size.Y/2)+
						bodyPosition.Position = ball.CFrame:pointToWorldSpace(Vector3.new(0,-unitY,-unitX ))--self.KibbleObject.Position  + (self.KibbleObject.CFrame.lookVector * ((kibbleSize/2)+(self.Object.Size.Y/2)-unitX)) + unitY
						bodyGyro.cframe = CFrame.new( petObject.Position, petObject.Position - ((petObject.Position - (ball.Position)).unit) * 2 )
							
						if (ball.Position - self.Hat.Position).magnitude < 3 and ball.Counter.Value < tick() then
							
							stillChasing = false 
							ball.CanCollide = false
							ball.Parent = petObject
							ball.Cleanup:Destroy()
							ball.Shape = "Block"
							ball.FormFactor = "Custom"
							ball.Size = Vector3.new(size/2,size/2,size/2)
							
							local bp = self.Object.BodyPosition
							bp.D = 1250 - self.Properties.Speed
							bp.P = 2000
							bodyMoversEnabled(self,true)

							
							
							
							local function touched(hit)  --when the ball touches the player
								if hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
									ball:Destroy()
									Joy(self,self.PlayLevel,self.Properties.PlayMax)
									if self.PlayLevel < self.Properties.PlayMax then
										self.PlayLevel = self.PlayLevel + 1
										workspace.PetService.MeterChanged:FireClient(self.Owner,self.Name,"PlayMeter",self.PlayLevel)
									end
									self.State = "Follow"
								end
							end
							ball.Touched:connect(touched)
		
							WeldToMouth(petObject,ball,nil)
							
						end
						
					elseif ball.Parent == petObject and self.Owner.Character then --return ball
						local RightArm = self.Owner.Character:FindFirstChild("Right Arm") or self.Owner.Character:FindFirstChild("RightHand")
						bodyPosition.Position = RightArm.Position + Vector3.new(0,math.sin(math.rad(i))/bobAmplitude,0)
						bodyGyro.cframe = CFrame.new( petObject.Position, RightArm.Position )
							
					elseif ball.Parent:IsA("Tool") and ball.Parent.Parent:IsA("Model") then  --wait for ball to be thrown
						bodyPosition.Position = ball.Position + Vector3.new(randomPos.X,0,randomPos.Z) + Vector3.new(0,math.sin(math.rad(i))/bobAmplitude,0)--
						bodyGyro.cframe = CFrame.new( petObject.Position, ball.Position )
					
					end
						
				else
					self.State = "Follow"
						
				end
				i = i + bobSpeed
				wait(.1)
			end
			
			
			if petObject:FindFirstChild("BallWeld") then
				petObject.BallWeld:Destroy()
			end
			
			--if ball disapears
			if self.Object:FindFirstChild("BodyPosition") then
				local bp = self.Object.BodyPosition
				bp.D = 1250 - self.Properties.Speed
				bp.P = 2000
			end
			
			
			
			
	
--Sitting---------------------------------------------------------------------------------------------------------------------------------
		elseif self.State == "Sitting" then
			SitOnShoulder(self,"Sitting")
			local sitonplayer = self.Properties.SitOnPlayerLength
			delay(math.random(sitonplayer[1],sitonplayer[2]),function()
				if self.State == "Sitting" then
					self.State = "Follow"
				end
			end)
			
			while self.State == "Sitting"  do
				wait(.1)
			end
			
			if self.HeadWeld then self.HeadWeld:Destroy() end
			if self.Reserve then self.Reserve:Destroy() end
			
			pcall(function() self.Object:SetNetworkOwner(self.Owner) end)
			
--Petting---------------------------------------------------------------------------------------------------------------------------------
		elseif self.State == "Petting" then
			
			bodyMoversEnabled(self,true)
		
			local petObject = self.Object
			petObject.BodyPosition.Position = self.Object.Position
			petObject.BodyGyro.MaxTorque = Vector3.new(0,0,0)
			petObject.Velocity = Vector3.new(0,0,0)
			petObject.RotVelocity = Vector3.new(0,0,0)
			
			workspace.PetService.Petting:FireClient(self.Owner,"Ready")
			
			local lockPostiion = petObject.Position
			while self.State == "Petting" do
				
				bodyPosition.Position = lockPostiion + Vector3.new(0,math.sin(math.rad(i))/(bobAmplitude*3),0)  --small bob amplitude
				i = i + bobSpeed
				
				wait(.1)
			end
			
		--	self.Object.Anchored = false
			
			if self.State == "Destroyed" then break end
			
			
			self:CancelPetting()
			
			self.Object.BodyGyro.MaxTorque = Vector3.new(0, 400000, 0)
			
			self.Object.Eyes.Texture = eyes["Normal"]
			self.Object.Mouth.Texture = mouth["Smile"]

--Sleeping------------------------------------------------------------------------------------------------------------------------------------
		elseif self.State == "Sleeping" then
			
			bodyMoversEnabled(self,true)
			
			SitOnShoulder(self,"Sleeping")
			
			local PlayerJumped = false
			local jumped = nil
			if self.Object and self.Owner.Character and self.Owner.Character:FindFirstChild("Humanoid") then
				jumped = self.Owner.Character.Humanoid.Jumping:connect(function()
					jumped:disconnect()
					PlayerJumped = true
					self.State = "Follow"
					Eyes.Texture = eyes["Sad"]
					Mouth.Texture = mouth["Frown"]
					self.Object.Sleep:Stop()
					self.Hat.Sleep:Destroy()
					wait(.3)
					pcall(function() self.Object.Sad:Play() end)
				end)
			end
			
			
			if self.Object:FindFirstChild("Sleep") then self.Object.Sleep:Play() end
	
			local sleep = game.ServerStorage.PetObjects.PetParticles.Sleep:clone()
			sleep.Parent = self.Hat
			
			if hatRotation[self.Type] then
				sleep.EmissionDirection = "Back"
				sleep.Acceleration = Vector3.new(0, 0.3, 0.3)
			end
			
			self.Object.Eyes.Texture = eyes["Sleep"]
			self.Object.Mouth.Texture = mouth["Sleep"]
			
			local counter = 0
			local seconds = 30
			while (self.State == "Sleeping" and self.SleepLevel < self.Properties.SleepMax) do
				wait(1)
				if counter == seconds then
					self.SleepLevel = self.SleepLevel + 1
					workspace.PetService.MeterChanged:FireClient(self.Owner,self.Name,"SleepMeter",self.SleepLevel)
					counter = 0
				else
					counter = counter + 1
				end
			end
			
			if self.State == "Destroyed" then break end
			
			if not PlayerJumped then
				self.Object.Sleep:Stop()
				if self.Hat:FindFirstChild("Sleep") then self.Hat.Sleep:Destroy() end
				self.Object.Eyes.Texture = eyes["Normal"]
				self.Object.Mouth.Texture = mouth["Smile"]
			end
			
			
			if self.HeadWeld then self.HeadWeld:Destroy() end
			if self.Reserve then self.Reserve:Destroy() end
			
			if self.State == "Sleeping" then
				self.State = "Follow"
			end
			
			if jumped then jumped:disconnect() end
	
			pcall(function() self.Object:SetNetworkOwner(self.Owner) end)
		
--Eating----------------------------------------------------------------------------------------------------------------------------	
		elseif self.State == "Eatting" and self.KibbleObject then
			
			local kibbleSize = .5
			local eatCounter = (self.Properties.EatingSpeed) * 10
			
			bodyMoversEnabled(self,true)
			
			spawn(function()
				while self.State == "Eatting" do
				
					Mouth.Texture = mouth["Smile"]
					wait(math.random(20,30)/100)
					Mouth.Texture = mouth["Open"]
					
					wait(.1)
				end
				
			end)
		
			local kibble = nil
			local kibbleParticle = nil
			while self.State == "Eatting" do
				
				
				if self.State == "Destroyed" then break end
				if self.KibbleObject and self.KibbleObject.Parent then
					kibble = self.KibbleObject
					kibbleParticle = self.KibbleObject.Particles
					local angle = 330
					local X = math.cos(math.rad(angle))
					local Y = math.sin(math.rad(angle))

					local unitY = Y *(size/2)
					local unitX = X * (size/2)																				
					bodyPosition.Position = self.KibbleObject.CFrame:pointToWorldSpace(Vector3.new(0,-unitY,-unitX ))
					bodyGyro.cframe = CFrame.new( self.Object.Position, self.Object.Position - ((self.Object.Position - (self.KibbleObject.Position)).unit) * 2 )
					if eatCounter > 0 and (self.KibbleObject.Position - self.Hat.Position).magnitude < .3 then
						eatCounter = eatCounter - 1
						kibbleParticle.Enabled = true
						if not self.Object.Eat.IsPlaying then
							self.Object.Eat:Play()
						end
					elseif eatCounter <= 0 then
						kibbleParticle.Enabled = false
						
						self.KibbleObject.Parent:Destroy()
						self.State = "Follow"
						self.Object.Eat:Stop()
						
						Joy(self,self.FeedLevel,self.Properties.FeedMax)
						
						if self.FeedLevel < self.Properties.FeedMax then
							self.FeedLevel = self.FeedLevel + 1
							workspace.PetService.MeterChanged:FireClient(self.Owner,self.Name,"FeedMeter",self.FeedLevel)
						end
					else
						if self.Object.Eat.IsPlaying then
							self.Object.Eat:Stop()
						end
						kibbleParticle.Enabled = false
					end
				else
					self.State = "Follow"
					
				end
				wait(.1)
			end
			
			if self.KibbleObject and self.KibbleObject.Parent then
				self.KibbleObject.Parent:Destroy()
			end
			
			if self.Object and self.Object:FindFirstChild("Eat") then
				self.Object.Eat:Stop()
			end
			
--Cutomize--------------------------------------------------------------------------------------------------------------------------------
		elseif self.State == "Customize" then
			
			pcall(function() self.Object:SetNetworkOwner(self.Owner) end)
			
			bodyMoversEnabled(self,true)
			local petObject = self.Object
			local lockPostiion = petObject.Position
			while self.State == "Customize" do
				
				bodyPosition.Position = lockPostiion + Vector3.new(0,math.sin(math.rad(i))/(bobAmplitude*2),0) 
				i = i + bobSpeed
				
				wait(.1)
				
				bobAmplitude = self.Properties.BobAmplitude  --update type properties during customization
				bobSpeed = self.Properties.BobSpeed
				lookAtOwnerFrequency = self.Properties.LookAtOwnerFrequency
				lookAtNearbyPlayersFrequency = self.Properties.LookAtNearbyPlayersFrequency
				lookAtNearbyPetsFrequency = self.Properties.LookAtNearbyPetsFrequency
				sitOnPlayerFrequency = self.Properties.SitOnPlayerFrequency
				followRadius = self.Properties.FollowRadius
				size = self.Object.Size.Y
				movementFrequency = self.Properties.MovementFrequency
			end
			
			if self.Object:FindFirstChild("PointLight") then
				self.Object.PointLight:Destroy()
			end
			
			pcall(function() self.Object:SetNetworkOwner(self.Owner) end)
			
----Staying-------------------------------
		elseif self.State == "Staying" then	
			
			bodyMoversEnabled(self,true)
		
			local petObject = self.Object
			petObject.BodyPosition.Position = self.Object.Position
			petObject.BodyGyro.MaxTorque = Vector3.new(0,0,0)
			petObject.Velocity = Vector3.new(0,0,0)
			petObject.RotVelocity = Vector3.new(0,0,0)
			
			
			local lockPostiion = petObject.Position
			while self.State == "Staying" do
				
				bodyPosition.Position = lockPostiion + Vector3.new(0,math.sin(math.rad(i))/(bobAmplitude),0) 
				i = i + bobSpeed
				
				wait(.1)
			end
			
			
			
			if self.State == "Destroyed" then break end
			
			self.Object.Stay.Value = false
			
			
			self.Object.BodyGyro.MaxTorque = Vector3.new(0, 400000, 0)
			
			if self.Owner and self.Owner:DistanceFromCharacter(self.Object.Position) > 40 then
				self:TeleportToOwner()
			end
			
			
--Holding ------------------------------------------------------------
		elseif self.State == "Holding" and self.Owner.Character then	
			
			bodyMoversEnabled(self,true)
			
			local folder = Instance.new("Folder")
			folder.Name = "HoldOutHand"
			folder.Parent = self.Owner.Character
			
			local toolAnimation = Instance.new("StringValue")
			toolAnimation.Name = "toolanim"
			toolAnimation.Value = "None"
			toolAnimation.Parent = folder
			
			
			local petObject = self.Object
			

		
			
			
			local playerArmRadius = .5
			local petHeadRadius = self.Object.Size.X/2
			local bodyPosition = self.Object.BodyPosition
			local bodyGyro = self.Object.BodyGyro
			
		
			
			--adjust position if sitting on head or shoulders
			--local position = Vector3.new(-1.5,-playerHeadRadius+petHeadRadius-(petHeadRadius/4),1.5)  --move to left and add .2 to give a little extra space then bring the pet down to the shoulder
			local position = Vector3.new(0,.5,petHeadRadius+petHeadRadius-(petHeadRadius/4))
	
	
			while self.State == "Holding" and folder.Parent and self.Owner and self.Owner.Character  do
				local rightArm = self.Owner.Character:FindFirstChild("Right Arm") or self.Owner.Character:FindFirstChild("RightHand")
				bodyPosition.position = rightArm.CFrame:pointToWorldSpace(-position)
				bodyGyro.cframe = CFrame.new( self.Object.Position, self.Object.Position - ((self.Object.Position - bodyPosition.Position).unit) * 2 )
				if (bodyPosition.position - self.Object.Position).magnitude < .5 then
					bodyMoversEnabled(self,false)
					break
				end
				wait(.1)
			end
			if self.State == "Destroyed" then return end
			
			
			--self.Object.Size = self.Object.Size - Vector3.new(0,self.Object.Size.Y/4,0) -- squish the pet
			
			local rightArm = self.Owner.Character:FindFirstChild("Right Arm") or self.Owner.Character:FindFirstChild("RightHand")

			local W = Instance.new("Weld")
			W.Name = "HoldWeld"
			W.Part0 = rightArm
			W.Part1 = self.Object
			W.C0 = CFrame.new(-position)
			W.C1 =  CFrame.Angles(math.pi/2,0,0) --+  Vector3.new(0,-(petHeadRadius+petHeadRadius-(petHeadRadius/4)),0)
			W.Parent = rightArm
			
			self.HeadWeld = W
			
			workspace.Animation.PlayAnimation:FireClient(self.Owner,"ToolHold",.2)
			
			
			while self.State == "Holding" and folder.Parent  do
				wait(.1)
			end
			
			workspace.Animation.StopAnimation:FireClient(self.Owner,"ToolHold",.2)
			
			
			if W then W:Destroy() end
			if folder then folder:Destroy() end
			
			pcall(function() self.Object:SetNetworkOwner(self.Owner) end)
			
		elseif self.State == "Destroyed" then
			break
		elseif self.State == "Deactivated" then
			wait(.3)
		end
		wait()
	end
end



--{}{}{{}{}{{}{}{}{}{}{}{}{}{}{}}{{}{}{}{}{}{}{}{}{}{}}{}

function Pet.new(player,petData)
	
	local this = {}
	setmetatable(this,Pet)
	
	this.Owner = player
	this.Name = petData.Name or ""
	--this.Age = petData.Age or 0
	this.PrimaryColor = petData.PrimaryColor or 1013
	this.SecondaryColor = petData.SecondaryColor or 1013
	this.Type = petData.Type or "Default"
	this.CustomHatName = petData.CustomHatName or "No Hat"
	
	this.FeedLevel =  petData.FeedLevel or 1
	this.PetLevel = petData.PetLevel or 1
	this.SleepLevel = petData.SleepLevel or 1
	this.PlayLevel = petData.PlayLevel or 1
	
	this.State = "Follow" --Follow,  Eatting, Sleeping, 
	this.EmotionState = "Normal" --crying, tired, joy/happy, sad
	this.Active = petData.Active or false
	this.AllowSaving = true
	
	this.Properties = breedProperties[this.Type]
	
	
	if this.FeedLevel > this.Properties.FeedMax then  this.FeedLevel = this.Properties.FeedMax end
	if this.SleepLevel > this.Properties.SleepMax then  this.SleepLevel = this.Properties.SleepMax end
	if this.PetLevel > this.Properties.PetMax then  this.PetLevel = this.Properties.PetMax end
	if this.PlayLevel > this.Properties.PlayMax then  this.PlayLevel = this.Properties.PlayMax end

	--[[this.Size = 1
	
	this.HungerMax = math.random(2,5)
	this.PetMax = math.random(2,5)
	this.SleepMax = math.random(2,5)
	this.PlayMax = math.random(2,5)
	
	
	
	this.MovementSpeed = "High"  
	this.SitOnPlayerFrequency = "Medium"  -- how frequent lands on player
	this.SitOnPlayerLength = "High"
	this.PetSocialLevel = "Low"
	this.PlayerSocialLevel = "Low"
	this.EatingSpeed = 1.5  --in seconds


	
	this.MovementFrequency = "High"--1-10
	this.MovementSpeed = 5
	this.BobAmplitude = 5]]
	
	
	this.KibbleObject = nil
	this.BallObject = nil
	
	
	
	this.Hat = nil
	this.HeadWeld = nil
	
	this.CustomHat= nil
	


	return this
end

return Pet








