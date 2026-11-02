local ServerScriptService = script.Parent
local Global = require(ServerScriptService.Global)
local Door = Global.Door
local Players = Global.Players
local Manager = Global.Manager
local Houses = Global.Houses
local AssetLibraryManager = Global.AssetLibraryManager
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))


print("Door depedencies loaded")

Door.__index = Door


--types - Open to anyone, open for owner, open for manager,backyard door

--types = PublicDoor,FrontDoor,ManagerDoor



function Door:SetState(open,doorTouchCanCollide)
	
	self.IsOpen = open
	

	for _,part in ipairs(self.Object.Door_Closed:GetChildren()) do
		part.Transparency = (open and 1) or 0
		part.CanCollide = (not open and self.Type ~= "PublicDoor"  and true) or false
	end
	
	for _,part in ipairs(self.Object.Door_Open:GetChildren()) do
		part.Transparency = (open and 0) or 1
	end
	
	if doorTouchCanCollide ~= nil then
		self.Object.DoorTouch.CanCollide = doorTouchCanCollide
	end
	
	if open then 
		self.DoorOpenSound:Play()
	else
		self.DoorClosedSound:Play()
	end
end

function Door:SetDoorbellEnabled(enabled)
	self.DoorbellEnabled = enabled
end



function Door.new(object,house)
	
	local debounce = false
	local function Activate(self,player,clicked)
		
		
		
		if self.Type == "PublicDoor" and not self.IsOpen then
			
			self:SetState(true)
			wait(2)
			
			--keep the door open until no one is nearby
			while true do
				wait(.5)
				local keepOpen = false
				for _,player in ipairs(game.Players:GetPlayers()) do
					if player:DistanceFromCharacter(object.DoorTouch.Position) < 6 then
						keepOpen = true
					end
				end
				if not keepOpen then 
					break
				end
			end
			self:SetState(false)


		elseif  self.Type == "ManagerDoor" then 
			
			if player.TeamColor == BrickColor.new("Bright green") and not Manager.CurrentManager then
				spawn(function() error("Player should be manager") end)
			end
			
			if player.TeamColor ~= BrickColor.new("Bright green") and Manager.CurrentManager == player then
				spawn(function() error("Manager does not have the right teamcolors") end)
			end
			
			if self.IsOpen and self.Object.Door_Closed.Door.Transparency == 0 then
				spawn(function() error("Door should be open but is not") end)
			end
			
			if self.Object.Door_Closed.Door.Transparency == 1 and  self.Object.DoorTouch.CanCollide == true then
				spawn(function() error("Door is open but cant go through") end)

			end
			
			
			
			
			
			if not Manager.CurrentManager or not Manager.CurrentManager.Parent or Manager.CurrentManager == player or player.TeamColor == BrickColor.new("Bright green") then
				if not self.IsOpen then
					self:SetState(true)
					wait(2)
					self:SetState(false)
				end
	
			else
				local torso = Utility:GetObjectInsideCharacter(player,"HumanoidRootPart")
				if torso then
					local objPosition = object.DoorTouch.CFrame:pointToObjectSpace(torso.Position)
					if objPosition.X < 0 and not self.IsOpen then --open door for person insdie house - close door behind visitor when the leave
						self:SetState(true)
						wait(2)
						self:SetState(false)
						
					end
				end
			end
			
			
		elseif self.Type == "BackyardDoor" then
			if clicked then
				self:SetState(not self.IsOpen) --toggle]
			else
				if not self.IsOpen then
					self:SetState(true)
				end
			end
				
		elseif self.Type == "SecondDoor" then
			if clicked then
				self:SetState(not self.IsOpen) --toggle]
			else
				if not self.IsOpen then
					self:SetState(true)
				end
			end							

		elseif self.Type == "ThirdDoor" then
			if clicked then
				self:SetState(not self.IsOpen) --toggle]
			else
				if not self.IsOpen then
					self:SetState(true)
				end
			end

		elseif self.Type == "FourthDoor" then
			if clicked then
				self:SetState(not self.IsOpen) --toggle]
			else
				if not self.IsOpen then
					self:SetState(true)
				end
			end
						
		elseif self.Type == "FrontDoor"  then
			
			if Players[player] == nil then
				spawn(function() error("Player does not have data") end)
			
			elseif house.Object:FindFirstChild(player.Name) ~= nil and house.Owner ~= Players[player] then
				spawn(function() error("Mislabled house") end)
			end
			
			if self.IsOpen and self.Object.Door_Closed.Door.Transparency == 0 then
				spawn(function() error("HOUSE Door should be open but is not") end)
			end
			
			
			
			
			if Players[player] and house.Owner == Players[player] or Players[player].IsAdmin then
				if clicked then --only toggle if player click on door
					self:SetState(not self.IsOpen)
				elseif not self.IsOpen then
					self:SetState(true)
				end
	
			else
				local torso = Utility:GetObjectInsideCharacter(player,"HumanoidRootPart")
				if torso then
					local objPosition = object.DoorTouch.CFrame:pointToObjectSpace(torso.Position)
					if objPosition.X > 0 and not self.IsOpen then --open door for person insdie house - close door behind visitor when the leave
						self:SetState(true)
						wait(2)
						self:SetState(false)
				
					elseif not self.IsOpen and objPosition.X < 0 and not self.DoorbellDebounce and self.DoorbellEnabled then --ring doorbell
						
						self.DoorbellDebounce = true
						
						local players = self.House:GetPlayersInside()
						table.insert(players,player) --let person touching door hear too
							
						for _,player in ipairs(players) do
							SoundFX:PlaySound(player,"Doorbell")
						end
						
						delay(5,function() self.DoorbellDebounce = false end)
						
					end
				end
			end
		end
	end
	
	
	local this = {}
	setmetatable(this,Door)
	this.Type = object.Name
	this.DoorbellDebounce = false
	this.DoorbellEnabled = true
	this.House = house
	this.Object = object
	this.IsOpen = false
	this.DoorOpenSound = script.DoorOpen:clone()
	this.DoorClosedSound = script.DoorClosed:clone()

	local debounce = false
	this.Touched = object.DoorTouch.Touched:connect(function(hit)
		if not debounce and hit and hit.Parent and hit.Parent.Parent and (hit.Parent:FindFirstChild("Humanoid") or hit.Parent.Parent:FindFirstChild("Humanoid")) then
			debounce = true
			local player = game.Players:GetPlayerFromCharacter(hit.Parent) or game.Players:GetPlayerFromCharacter(hit.Parent.Parent)
			if player then
				Activate(this,player,false) 
			end
			wait(.3)
			debounce = false
		end
	end)
	
	this.Clicked = nil
	if object:FindFirstChild("ClickDetector") then --only house doors have click dectectors
		this.Clicked = object.ClickDetector.Detector.Event:connect(Utility:Debounce(function(player) Activate(this,player,true) wait(.3) end))
	end
	
	this.DoorOpenSound.Parent = object.DoorTouch
	this.DoorClosedSound.Parent = object.DoorTouch

	return this
end

function Door:DisconnectEvents()
	if self.Touched then self.Touched:disconnect() end 
	if self.Clicked then self.Clicked:disconnect() end
end




print("Door loaded")


return Door
