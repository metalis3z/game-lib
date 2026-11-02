
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))



local Customer = {}--G.Customer


Customer.__index = Customer



Dialog = {
	CustomerOrder = {
		"Could I have a ordername please",
		"Give me a ordername will ya?",
		"Could I get a ordername please?",
		"I would like to order a ordername.",
		"Do you all sell hamburgers? Oh, just pizzas?.... I'll have a ordername.",
		"I'd like a ordername with a salad on top, hold the salad...hehe",
		"Uh.......Hi.......Uh......ordername please..",
		"Oh that looks tasty.....Oh....Hm......I'll have the ordername.",
		"I'll have uhhhhhhhhh...........uhhhhhhhhh ordername",
		"Hi friend, I would like a ordername",
		"Give me somthin' tasty...........like a ordername",
		"Hey pizza person. Give me a ordername",
		"ordername sounds good to me. Could I get that?",
		"Could I get a ordername with a side of ordername?",
		"I heard the ordernames are yummy here. I'll have that",
		"I'll go with a ordername cause it's the best!",
		"Woah the ordername looks sooo good. I want that!",
		"How about you give me a ordername or I'll go elsewhere.",
		"Howdy! Could I get a ordername",
		"Please give me a ordername. I'm starving!",
		"Hello, could I get a ordername please?",
		"Could I get a free ordername? No? I understand.",
		"Like Hi could I like get a ordername like please?",
		"I heard the ordernames are good here. I'll have that.",
		"Hmm...ordername or a cheese pizza.....I'll go with a ordername",
		"Toss a ordername in the oven.",
		"What's your favorite thing here?.......ordername?......I'll have that.",
		"I've had a hankering for a ordername all day!",
		"I'll have your finest ordername please.",
		"ordername is my favorite, make me one now!!!!!",
		"I've been down in the dumps all day and only a ordername can lift my spirits.",
		"Make me a ordername like my grandma used to",
		"Oh! The pepperoni pizza looks great, but I'm going to get a ordername instead.",
		
		"Me like food. Me want ordername.",
		"Give me a sec..............................ordername please.",
		"Hey hey hey give me a ordername",
		"How are you? I would like a ordername please.",
		"I want a ordername now or I'm leaving",
		"Oh hi, I would like a ordername please.",
		"ordername I want ordername....please.",
		"ordername is the best thing ever!",
		"What's good here?...The ordername?....I'll get that.",
		"I love this place. The ordername is my favorite.",
		"Could I get uh....a ordername please?",
		"I'll have the Builder Brother's ordername please.",
		"Hehe, hi, I want ordername.",
		"Make me a ordername made with extra love.",
		"OMG the ordername looks heavenly! I'll have that.",
		"Pizza is my favorite food! I want a ordername.",
	},
	CustomerPositive = {
		"Thanks a bundle!",
		"Wow thanks!",
		"Thank you",
		"Have a good one",
		"Alright!",
		"I'm starvin'",
		"Thanks",
		"You did it!",
		"Good job!",
		"You're the best!",
		"You rock!",
		"Yay! Pizza!",
		"Pizza! Pizza! Pizza! Pizza! Pizza! Pizza!",
		"Nice job",
	},
	CustomerNegative = {
		"I'm leaving and never coming back here again!",
		"Why did I even come here?",
		"Well I'm out of here!",
		"I didn't want your gross pizza anyways!",
		"I hate this place!",
		"Builder brothers pizza is the worst!",
		"The service here is awfull.",
		"You're wasting my time.",
		"I just wanted some pizza.....",
		"You've got to be kidding me...",
		"Um...I'm just going to leave",
		"This place is awfull. I'm going to BurgerBell!",
		"What's wrong with you?",
		"Fine! I wasen't hunrgy anyways!",
		"This saddens my heart....",
		"I hate you!",
		"What's your name? Let me talk to your manager",
		"Come on! I'm starving!",
		"Nuuuuu! How could this happen!",
		"I was looking forward to eating here.....",
		"Uhhh! these employees!",
		"You are bad at your job",
		"What a nutjob!",
		"Are you serious?",
		"I just wanted pizza...",
		"You are not nice!",
		"I'm never coming here again",
		"Lame.....",
		"Uh......Whatever....",
		"How could you do this to me?",
		"Wow good job noob",
		"I wasn't that hungry anyways",
		"I just wanted food!",
		"You messed up...",
		"You should be fired",
		"I'm telling your manager!",
		"You should just quit your job",
		"OMG NUUUUU!",
		"WAAAAAAAAAAAAAA!",
		"Nooooooooo......Noooooooo!",
		"Noob service...",
		"You just lost a customer",
		"You can't do this to me!",
		"Why would you do this?",
		"Do you think this is funny?",
		"Are you kidding me?",
		"Nuuuu! I'm starving!",
		"I'm going home now...",
		"I guess you don't want my money",
		"Pshhhh....",
		"The service here is a joke",
		"I'm going to complain to your manager",
		"Let me talk to your manager",
	},
	PlayerCorrectResponse = {
		"Welcome, may I take your order?",
		"What would you like to eat?",
		"Let me know when you are ready to order.",
		"Hello and welcome to builder brothers pizza!",
		"Nice to see you! What can I get for ya?",
		"Lovely day outside. What would you like?",
		"Greetings, we sell pizza and soda.",
		"Would you like to try our pepperoni pizza?",
		"Hi, what would you like to eat?",
		"We have the best pizza! Your order please?",
		"We have great cheese pizza. Would you like some?",
		"Let me take your order.",
		"Hi there. What would you like to order?",
		"Ill take your order and then you can have a seat",
		"May I take your order?",
		"Our pizza is guaranteed to be hot and fresh",
		"Our pizza is guaranteed to be delicious.",
		"Take your time and order when you are ready.",
		"Welcome, what would you like?",
		"Hi, what can I get ya?",
		"Nice to see you! What would you like?",
		"What kind of pizza would you like?",
		"Hey Hey! What would you like?",
		"May I take your order?",
		"Let me know what you would like, no rush.",
		"Hello valued customer. What would you like?",
		"Your order please?",
		"What kind of pizza do you want?",
		"Take your time and order when you are ready.",
	},
	PlayerIncorrectResponse ={
		"Would you like a spoon for your beverage?",
		"I'm Buddy the elf. What's you favorite color?",
		"Do you like waffles cause we don't have any here.",
		"Sorry, we don't serve food here.",
		"We are really sorry but we only serve chili",
		"What are you looking at you noob!",
		"If you want real food, eat somewhere else",
		"I'm the cashier and you're a dumb customer.",
		"I love you!",
		"Go away nobody likes you! Your order please?",
		"We are out of pizza, come back tomorrow",
		"Your shoes are untied.....Got you!",
		"Welcome, would you like to try our maggot pizza?",
		"We don't take kindly to your types in here", 
		"Hey chump, go take a hike!",
		"Hi there, leave now or die!!!!!",
		"Neat shirt, you should throw it away.",
		"Hello we serve spaghetti and salad. Choose one.",
		"I don't like strangers. Go awaaaaaay!",
		"PEW!PEW! PEW!PEW! YOU'RE DEAD!",
		"I made you a sweater out of eye lashes.",
		"If you're happy and you know it, clap your hands",
		"I'm having a heart attack! Call the ambulance",
		"Hi, could I get a pepperoni pizza please?",
		"We will have your pizza delivered within 1 week.",
		"All we serve here is cream-of-wheat and carrots.",
		"Our pizza is guaranteed to kill you",
		"Everything here is outrageously expensive.",
		"Would you like a taco? Or perhaps a burrito?",
		"Welcome to the taco hut! May I take your order?",
		"I'm not going to take your order!",
		"I don't take orders from noobs.",
		"I know this is sudden but will you marry me?",
		"LOL HI IZ COOL WHR U NOZ",
		"Welcome to my house! Have a seat.",
		"We have a buy 1 get 100 free offer today.",
		"I'll take your order and then I'll eat your food.",
		"Welcome to the bank! Please deposit your money",
		"Welcome to build a bear workshop.",
		"Our pizza is guaranteed to be disgusting.",
		"Party at my house!",
		"There's a great place to eat across the street.",
		"There's money in this cash register. Want some?",
		"May I steal your money?",
		"We have the best chicken tenders in the universe.",
		"Geetings, we sell car insurance",
		"This is a stick up! Give me all your left overs!",
		"Can you take my order? I'm starving.",
		"No U!",
		"Come at me bro!",
		"Haha! you look dumb.",
		"OMG HAXOR",
		"Hello, we serve the best poisonous pizza",
		"The building is on fire! Leave now!",
		"I would like a pepperoni pizza.",
		"Sorry, we are out of pizzas today",
		"Hello and welcome to the worst place on earth",
		"We are closed right now. Come back tomorrow",
		"You're cruisin' for a bruisin'.",
		"Why be here when you could be somewhere else?",
		"Sorry, we just closed. Never come back.",
		"How many tacos would you like?",
		"Sorry, we're fresh out of pizza.",
		"Hello and welcome to your worst nightmare.",
		"Could I borrow your wallet?",
		"You should go to Taco Hut instead.",
		"Nobody likes you.",
		"Haha! NERD!",
	}
}




local SitTime = 45
local SitTimeVariance = 10

Customers = nil

CustomerDialogSpeed = 10


--[[
	Glee
	Sad
	Angry
	Laugh
	
	Scared
	Amazed
	Confused
	Think
	
	Hi
	Bye
	Point
	Cheer
	
	Dance
	Dance1
	Dance2
	Dance3
	Trip
	
]]
local emotions = {"Glee","Sad","Laugh","Angry","Scared","Amazed","Hi","Bye","Confused","Think","Point","Dance","Dance2","Dance3","Cheer","Trip"}--"Wave"


local parkingLot = workspace.CustomerParking
local PathNodes = game.ReplicatedStorage.PathNodes
local parkingNodes = PathNodes.Parking
local seats = workspace.Seating

local Paths = {  
	ParkingPaths = {  
		[parkingLot.Spot1] = {parkingNodes.a1,parkingNodes.Entrance},
		[parkingLot.Spot2] = {parkingNodes.b1,parkingNodes.Entrance},
		[parkingLot.Spot3] = {parkingNodes.c1,parkingNodes.c2,parkingNodes.Entrance},
		[parkingLot.Spot4] = {parkingNodes.d1,parkingNodes.d2,parkingNodes.Entrance},
		[parkingLot.Spot5] = {parkingNodes.e1,parkingNodes.e2,parkingNodes.Entrance},
		[parkingLot.Spot6] = {parkingNodes.f1,parkingNodes.f2,parkingNodes.Entrance},
		[parkingLot.Spot7] = {parkingNodes.g1,parkingNodes.g2,parkingNodes.Entrance},
		[parkingLot.Spot8] = {parkingNodes.h1,parkingNodes.h2,parkingNodes.Entrance},
	},
	
	Lanes = {
		["Right"] = {PathNodes.Lanes.Right}, 
		["Left"] = {PathNodes.Lanes.Left},
		["DriveThrough"] = {PathNodes.Lanes.DriveThrough},
	},
}


function Customer:StartPathFinding()
	
	wait()
	local function walkPath(path,this)   ---set customer to walk on path
		if not this.Model or not this.Model:FindFirstChild("Torso") then return end
		local torso = this.Model.Torso
		for _,part in pairs(path) do
			
			if self.Deleted then return end
			
			local seated = self.Model.Humanoid.Seated:connect(function(active,seat)
				if active and this.Lane ~= "DriveThrough" and seat ~= self.Seat then
					this.Model.Humanoid.JumpPower = 10
					this.Model.Humanoid.Jump = true
					delay(.5,function() if not this.Deleted and this.Humanoid then this.Humanoid.JumpPower = 50 end end)
				end
			end)
			
			this.Model.Humanoid:MoveTo(part.Position+ Vector3.new(0,2.5,0))
			
			local finished = false
			
			spawn(function() --keep customer walking
				while not this.Deleted and not finished and this.Model and this.Model:FindFirstChild("Humanoid") do
					this.Model.Humanoid:MoveTo(part.Position+ Vector3.new(0,2.5,0))
					wait(2)
				end
			end)
			
			spawn(function() --teleport to destination if take too long
				wait(10)
				if this.Lane ~= "DriveThrough" and not this.Deleted and not finished and self.Model and self.Model:FindFirstChild("Torso") then
					if self.State == Enums.CustomerStates.WalkingToTable and this.Seat and this.Seat.Occupant ~= nil then return end -- see if a player is sitting in the seat
					this.Model.Humanoid.Jump = true
					wait(1)
					if  self.Model and self.Model:FindFirstChild("Torso") then
						self.Model.Torso.CFrame = CFrame.new(part.Position + Vector3.new(0,2.5,0))
					end
				elseif this.Lane == "DriveThrough" and not this.Deleted and not finished and self.Car then
					self:delete()
				end
			end)
			
			local posX = part.Position.X
			local posZ = part.Position.Z
			while not this.Deleted and (torso.Position-Vector3.new(posX,torso.Position.Y,posZ)).magnitude > 2 do
				wait() 
			end	
			finished = true
			
			seated:disconnect()
			
		end
	end
	
	
	local function ReverseTable(tab)
		local newTable = {}
		local j = 0
		for i=#tab,1,-1 do
			j = j + 1
			newTable[j] = tab[i]
		end
		return newTable
	end
	

	
	
	
	
	
	

	local parkingLotPath = nil
	if self.Lane ~= "DriveThrough" then
		parkingLotPath = Paths.ParkingPaths[self.ParkingSpot] --walk from car to entrance
		walkPath(parkingLotPath,self)
		SoundFX:PlaySoundInsideZone("EntranceTone","Cashier")
	end
	
	local lanePath = Paths.Lanes[self.Lane] --walk from entrance to cashier
	walkPath(lanePath,self)
	
	
	if self.Lane == "DriveThrough" and self.Car and self.Car:FindFirstChild("Seat") then --stop car by anchoring
		self.Car.Seat.Anchored = true
	end
	
	
	
	--[[if self.Lane ~= "DriveThrough" then
		self.State = Enums.CustomerStates.WalkingToTable
	else
		self.State = Enums.CustomerStates.Leaving
	end
	wait(8)]]
	
	self.State = Enums.CustomerStates.WaitingForCashier

	
	while not self.Deleted and self.State ==  Enums.CustomerStates.WaitingForCashier do   --- stay in same spot until cashier is finished
		wait(.3)
	end
	
	if self.Deleted then return end

	self.Container:UnoccupyLane(self.Lane)
	self.OccupyingLane = false
	
	wait(2)  --let player read the customer chat
	
	if self.Deleted then return end

	
	
	if self.Lane == "DriveThrough" and self.Car and self.Car:FindFirstChild("Seat") then --stop car by anchoring
		self.Car.Seat.Anchored = false
	end

	
	if self.State ==  Enums.CustomerStates.Leaving  then  --if cashier messed up the order
		if self.Lane == "DriveThrough" then
			wait(2) --give 2 seconds to drive off
			if self.Deleted then return end
		else
			walkPath(ReverseTable(parkingLotPath),self)
			if self.Deleted then return end
		end
	end
	
	
	
	if self.State ==  Enums.CustomerStates.WalkingToTable then  --if cahsier chose correct button
		
		self.Seat = self.Container:FindOpenSeat()-- choose random seat
		
		local seatPathEnter = self.Seat.PathEnter:GetChildren()--Paths.SeatEnter[self.Seat] --find path associated with object
		walkPath(seatPathEnter,self)
		walkPath({self.Seat},self)
		wait()
		if not self.Deleted and self.Humanoid and not self.Humanoid.Sit and self.Seat.Occupant == nil and self.Model and self.Model:FindFirstChild("Torso") then
			self.Model.Torso.CFrame = self.Seat.CFrame
		end
		
		self.State =  Enums.CustomerStates.SittingAtTable
		
		wait(math.random(SitTime-SitTimeVariance,SitTime+SitTimeVariance)) 
		
		self.State =  Enums.CustomerStates.Leaving
		
		if self.Deleted then return end
		
		if not self.Model or not self.Model:FindFirstChild("Humanoid") then self:delete() end
		
		self.Humanoid.JumpPower = 10
		self.Humanoid.Jump = true
		delay(.5,function()if self.Humanoid then self.Humanoid.JumpPower = 50 end end)
		
		
		local seatPathExit = self.Seat.PathExit:GetChildren()--Paths.SeatExit[self.Seat] --find path associated with object
		--self.Model.Torso.CFrame = CFrame.new(seatPathExit[1].Position + Vector3.new(0,2,0))
		walkPath(seatPathExit,self)
		if self.Deleted then return end
		
		local doByeEmotion = math.random(1,3) --1 in 3 changes of saying bye when leaving
		if doByeEmotion == 3 then 
			self:ShowEmotion("Bye")
		end
		
		walkPath(ReverseTable(parkingLotPath),self) -- walk to car
		if self.Deleted then return end
	end
	
	self:delete()
	
	
end


local function ChooseRandom(dialogs) --pick a random dialog
	return dialogs[math.random(1,#dialogs)]
end






function Customer:OrderComplete(failed)
	if failed then
		
		self.State = Enums.CustomerStates.Leaving
		
		local emote = math.random(1,5)
		if emote == 1 or emote == 2 or emote == 3 then
			self:ShowEmotion("Angry")
		elseif emote == 4 then
			self:ShowEmotion("Confused")
		elseif emote == 5 then
			self:ShowEmotion("Sad")
		end
		
		--say somthing negative
		--local negative = ChooseRandom(Dialog.CustomerNegative)
		--game:GetService("Chat"):Chat(self.Model.Head,negative,0)
		--print(negative)	
		
	else
		if self.Lane == "DriveThrough" then
			self.State = Enums.CustomerStates.Leaving
		else
			self.State = Enums.CustomerStates.WalkingToTable
		end
		
		--say something positive
		local positive = ChooseRandom(Dialog.CustomerPositive)
		game:GetService("Chat"):Chat(self.Model.Head,positive,0)
		print(positive)	
		
		if math.random(1,3) == 1  then 
			self:ShowEmotion("Glee")
			wait(.5)
		end
	end
end






function Customer:ShowEmotion(emotion)
	
	if not debounce and self.Model and self.Model:FindFirstChild("Humanoid") then
		local model = self.Model
		local humanoid = model.Humanoid

		debounce = true
		local animation = model.Head:FindFirstChild(emotion)
		
		if animation then
			
			local face = model.Head:FindFirstChild("face")
			local newFace = animation:FindFirstChild("Face")
			if face and newFace then
				local FT = face.Texture
				face.Texture = newFace.Texture
				delay(2,function() 
					face.Texture = FT
				end)
			end
		
			local animTrack = humanoid:LoadAnimation(animation)
			animTrack:Play()
			
			local sound = model.Head:FindFirstChild(animation.Name .. "Sound")
			if sound ~= nil then
				sound:Play()
			end
			
			delay(2,function() 
				debounce = false
			end)
		end
	end
end









--_______Create Customer Model__________

function createModel(this)  --creates customer model
	
	local outfits = this.Container.Outfits
	local template = outfits[math.random(1,#outfits)]
	local customer = template:clone()
		
	local remove_debounce = false
	if customer:FindFirstChild("Torso") == nil then  this:delete() return end  --if customer does not spawn correctly
	customer.Torso.Anchored = false

	local humanoid = Instance.new("Humanoid")
	humanoid.DisplayDistanceType = "None"
	humanoid.WalkSpeed = 13
	humanoid.Parent = customer
	
	
	for i,v in ipairs(customer.Head:GetChildren()) do  --sounds won't play inside animation objects
	 	local sound = v:FindFirstChild("Sound")
		if sound ~= nil then
			sound.Name = v.Name .. "Sound"
			sound.Parent = customer.Head
		end
	end
	
	customer.Animate.Disabled = false
	customer.Parent = game.Workspace.Customers
	customer:MakeJoints()
	customer.Torso.Anchored = true
	
	--teleport to fisrt parking path node
	if this.Lane ~= "DriveThrough" then
		local firstPathNode = Paths.ParkingPaths[this.ParkingSpot][1]
		customer.HumanoidRootPart.CFrame = CFrame.new(firstPathNode.Position + Vector3.new(0,2.5,0))	
	end
	

	for i,v in ipairs(customer:GetChildren()) do
		if v:IsA("Part") then
			v.Anchored = false
		end
	end
	
	
	
	
	--delete customer if stopped working - timeout
	spawn(function()
		local lastState = Enums.CustomerStates.WalkingToEntrance
		while not this.Deleted and this.Model and this.Model.Parent do 
			wait(5)
			
			if lastState ~= this.State and not this.Deleted then
				lastState = this.State
				
				spawn(function() --start new thread for each state change
					
					local currentState = this.State
					if this.State == Enums.CustomerStates.WaitingForCashier or this.State == Enums.CustomerStates.WalkingToEntrance then
						
						wait(300) 
						

						while true do --if timeout happens durring a converation, the customer will never timeout. thats why it loops just incase the player doesnt take the customer order
							
							if not this.Deleted and currentState == Enums.CustomerStates.WaitingForCashier or this.State == Enums.CustomerStates.WalkingToEntrance then --customer waiting too long
							
								local dialog = game.ServerScriptService.GameService.GetCustomerDialog:Invoke(this.Model) --see if anyone is talking to customer and dont make customer leave if so
								if dialog then
									
									if dialog.CurrentPlayer == nil then --if noone is talking
										
										this.State = Enums.CustomerStates.Leaving
										
										wait(60) --give cutstomer 60 seconds to leave else destroy it
										
										if this.Model or this.Model.Parent then
											this:delete()
											return
										end
										
									end
								
								else --if dialong doesnt exist, the destroy
									this:delete()
									return
								end
							
							else  
								return
							end
							
							wait(15)
						end
				
					else
						wait(180)
						
						if not this.Deleted and currentState == this.State then
							this:delete()
						end
					end
				end)
			end
		end
	end)
	

	---Set up dialog---

	local right_index = math.random(1,3)
	for i,choice in ipairs(customer.Head.Dialog:GetChildren()) do
		if right_index == i then  --right answer
				
			local items = {"cheese pizza","pepperoni pizza","sausage pizza","mountain dew"}	
			local customerOrder = ChooseRandom(Dialog.CustomerOrder)
			
			choice.ResponseDialog =  string.gsub(customerOrder,"ordername", items[this.Order.Order])
			choice.Name = "Correct"
			choice.UserDialog =  ChooseRandom(Dialog.PlayerCorrectResponse)
					
			customer.RightOrder.Value = choice
			this.RightOrder = choice
		
		else --wrong answer
	
			choice.ResponseDialog =  ChooseRandom(Dialog.CustomerNegative)
			choice.UserDialog =   ChooseRandom(Dialog.PlayerIncorrectResponse)
					
		end
	end

	delay(.1,function() 
		if customer and customer:FindFirstChild("Torso") then 
			customer.Torso.Anchored = false 
			if this.Lane ~= "DriveThrough" then
				humanoid:ChangeState(Enum.HumanoidStateType.Running) 
			end
		end 
	end)
	
	return customer
end










--////////////Create Car\\\\\\\\\\\\\\

function createCar(self)
	math.randomseed(math.floor((tick()-math.floor(tick()))*10000))
	math.random()
	local function weld(object)
		local parts,last = {}
		local function scan(parent)
			for _,v in pairs(parent:GetChildren()) do
				--wait()
				if (v:IsA("BasePart") and v ~= workspace.Terrain) then
					if (last ) then
						local w = Instance.new("Weld")
						w.Name = ("%s_Weld"):format(v.Name)
						w.Part0,w.Part1 = last,v
						w.C0 = last.CFrame:inverse()
						w.C1 = v.CFrame:inverse()
						w.Parent = last
					end
					last = v
					table.insert(parts,v)
				elseif v:IsA("BasePart") and v.Name == "Wheel" then
					table.insert(parts,v)
				end
				scan(v)
			end
		end
		scan(object)
		for _,v in pairs(parts) do
			v.Anchored = false
		end
	end
	
	
	
	local vehicles = game.ServerStorage.CustomerVehicles:GetChildren()
	local car = vehicles[math.random(1,#vehicles)]:clone()
	car.Parent = workspace.CustomerCars
	
	if self.Lane == "DriveThrough" then
		car:MakeJoints()
		Utility:RotateModel(car,-90)
		weld(car)
		
			
		car:MoveTo(workspace.CarSpawn.Position)
		car.Seat.Anchored = true
		car.Seat.Disabled = false
		self.Model.Torso.CFrame = CFrame.new(car.Seat.Position)
		
		
		if game.Lighting.TimeOfDay == "15:00:00" or game.Lighting.TimeOfDay == "21:00:00" then
			car.Light.SpotLight.Enabled = true
			car.Light.Material = "Neon"
			car.Light2.Material = "Neon"
			car.Rear_Light.Material = "Neon"
			car.Rear_Light2.Material = "Neon"
		end
	else
		
		car.Seat.BodyVelocity:Destroy()
		car.Seat.BodyGyro:Destroy()
		if math.random(1,2) == 1 then
			Utility:RotateModel(car,180) --half the cars parked the other direction
		end
		Utility:RotateModel(car,math.random(-2,2)) --not always perfect parking
		
		spawn(function()
			repeat
				car:MoveTo(self.ParkingSpot.Position)
				wait(1)
			until not car or not car:FindFirstChild("Seat") or car.Seat.Position.Y < 2.6
		end)	
	end
	
	local color = math.random(0,127)
	for _,part in ipairs(car:GetChildren()) do
		if part.Name == "Paint" then
			part.BrickColor = BrickColor.palette(color)
		end
	end
	
	wait()
	car.Seat.Anchored = false

	return car
end




function Customer.new(customers,order,lane,parkingSpot)
	math.randomseed(tick())
	math.random()
	
	local this = {}
	setmetatable(this, Customer)
	
	this.Container = customers
	this.Order = nil--Order.new(this,this.NPC.OrderNumber)	
	this.State = Enums.CustomerStates.WalkingToEntrance
	this.Order = order
	this.Table = nil --table sitting at
	this.ParkingSpot = parkingSpot
	this.Lane = lane
	this.OccupyingLane = true
	this.Model = createModel(this)
	this.Humanoid = this.Model:FindFirstChild("Humanoid")
	this.Car = createCar(this)
	this.Seat = nil
	this.Deleted = false
	this.Dialog = this.Model.Head.Dialog
	
	this.RightOrder = nil
	
	
	
	
	local model = this.Model
	local humanoid = model.Humanoid
	
	if lane ~= "DriveThrough" then
		this.Touched = model.Torso.Touched:connect(function(hit) --jump when touched
			wait()
			if hit and hit.Parent and hit.CanCollide and not humanoid.Sit then
				humanoid.Jump = true
			end
		end)
	end
	
	
	this.Died = humanoid.Died:connect(function()
		
	end)
	
	this.ChildRemoved = model.ChildRemoved:connect(function(part)
		if part.Name == "Head" then
			wait()
			if not this.Deleted then
				this:delete()
			end
		end
	end)


	return this
end




function Customer:delete()
	self.Container:delete(self)
end


function Customer:GetOrder()
	return self.Order
end


function Customer:SetState(state)
	self.State  = state
end

function Customer:GetState()
	return self.State
end








return Customer




