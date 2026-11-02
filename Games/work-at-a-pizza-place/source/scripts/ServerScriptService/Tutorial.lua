local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
if Enums.IsPartyServer then
	return false
end

local Tutorial = {}
local ServerScriptService = script.Parent
local Global = require(ServerScriptService:WaitForChild("Global"))
local Players = Global.Players
local Vehicles = Global.Vehicles
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))



Tutorial.__index = Tutorial

--events will que up without this 
workspace.TutorialService.PlayerAction.OnServerEvent:connect(function(player,eventName,eventValue)
end)
workspace.TutorialService.PlayerAction.PlayerAction.Event:connect(function(player,eventName,eventValue)
end)


function WaitForEvent(event_name,this)

	local event_value = nil
	local playerActionClient = workspace.TutorialService.PlayerAction.OnServerEvent:connect(function(player,eventName,eventValue)
	
		
		if this.Player == player and eventName == event_name then
			event_value = eventValue
		end
	end)
	local playerActionServer = workspace.TutorialService.PlayerAction.PlayerAction.Event:connect(function(player,eventName,eventValue)
		
		if this.Player == player and eventName == event_name then
			event_value = eventValue
		end
	end)
	while event_value == nil and not this.CancelListener do
		wait(.1)
	end
	
	this.CancelListener = false
	playerActionClient:disconnect()
	playerActionServer:disconnect()
	return event_value
end 


function makeTempOwner(obj,player)  --prevent other players from grabing the owner's objects temporily
	local tut = Instance.new("ObjectValue")
	tut.Value = player
	tut.Name = "Tutorial"
	tut.Parent = obj
	local remover = script.remover:clone()
	remover.Disabled = false
	remover.Parent = tut
end


--[[
function teleportToFloorArrow(player,path)  ---teleport player to begining of path if they are too far away
	if player and player.Character and player.Character:FindFirstChild("Torso") and (player.Character.Torso.Position - path.Begining.Position).magnitude > 25 then
		player.Character.Torso.CFrame = CFrame.new(path.Begining.Position + Vector3.new(0,2.5,0))
	end
end]]

function Tutorial:TeleportToClosestSpawn()
	
	local closest = nil
	local closest_distance = 200
	local character = self.Player.Character
	if character and character:FindFirstChild("HumanoidRootPart") then
		for _,spawn in ipairs(workspace:GetChildren()) do
			if spawn:IsA("SpawnLocation") and (spawn.Position-character.HumanoidRootPart.Position).magnitude < closest_distance then
				closest = spawn
				closest_distance = (spawn.Position-character.HumanoidRootPart.Position).magnitude
			end
		end
		if closest then
			self.Player.Character:MoveTo(closest.Position)
		end
	end
end


local indexToJobName = {"Cashier","Cook","Boxer","Delivery","Supplier"}

function nextPart(this,i)
	
	local jobIndex = this.JobIndex
	local index = this.Index
	local player = this.Player
	
	if not player or not player.Parent then this:Stop() return end
	
	this.TimeoutCounter = 60 --reset counter after one minute
	
	
	local message = this.TutorialData[jobIndex][index][1]
	local pattern = "{([%a%s.,'()]+)}{([%a%s.,'()]+)}{([%a%s.,'()]+)}" --.,'()
	for pc, mobile, console in message:gmatch(pattern) do --You see how gmatch returns the captures instead of the matches to the pattern here.
		local replaceValue
		if this.TouchEnabled then
			replaceValue = mobile
		elseif Enums.IsConsoleServer  then
			replaceValue = console
		else
			replaceValue = pc
		end
		
		message = string.gsub(message, "{" .. pc .. "}{" .. mobile .. "}{" .. console .. "}", replaceValue)

	end
	
	
	if this.TutorialData[jobIndex][index][2] == 1 then  --show message without buttons
		workspace.TutorialService.ShowMessage:FireClient(player,message) --1 = No Buttons, 2 = Continue button, 3 = Next job, 4 = STart/Skip buttons, 5 = OK button
	else--prompt the player with buttons
		local buttonName = workspace.TutorialService.PromptPlayer:InvokeClient(player,message,this.TutorialData[jobIndex][index][2]) --1 = No Buttons, 2 = Continue button, 3 = Next job, 4 = STart/Skip buttons, 5 = OK button
		if buttonName == "Delete" then --delete button
			
			
			Players[player]["Completed_Tutorials"][jobIndex] = true --save progress
			Players[player]["Tutorials_Left"] = Players[player]["Tutorials_Left"] - 1 
			this:Stop()
		
			return
		end
	end
	if this.QuitTutorial then return end
	
	
	this.TutorialData[jobIndex][index][3]()  --run function
	
	
	this.Index = this.Index + 1
	if this.Index > #this.TutorialData[jobIndex] then
		--this.JobIndex = this.JobIndex + 1
		--this.Index =  1
		this.QuitTutorial = true
	end
	
end

URLToName = {
["http://www.roblox.com/asset/?id=167850840"] = "Cheese",
["http://www.roblox.com/asset/?id=167850850"] = "Pepperoni",
["http://www.roblox.com/asset/?id=167850856"] = "Sausage",
["http://www.roblox.com/asset/?id=167850867"] = "TomatoSauce",

}




--Barrier 1 never disables
--Barrier 2 disables and enables
--Barrier 3 disables when enabled

function getIngredientBlock(name)  --draggable ingredients are parented to the ingredients so we need to find the block and not the draggable
	for _,ing in ipairs(workspace.Ingredients:GetChildren()) do
		if ing.Name == name and ing:FindFirstChild("Hand") then  --hand only appers in ingreident blocks
			return ing
		end
	end
end



function Tutorial:Start()
	--while self.JobIndex <= #self.TutorialData and self.JobIndex > 0 do
	--	while self.Index <= #self.TutorialData[self.JobIndex] and self.Index > 0 do
			--nextPart(self)
		--end
	--end

	--workspace.TutorialService.GuiEnabled:FireClient(self.Player,"Menu",false)
	
	spawn(function() 
		while not self.QuitTutorial do
			wait(1)
			self.TimeoutCounter = self.TimeoutCounter - 1
			if self.TimeoutCounter <= 0 then
				if self.Player then
					Dialog:ShowMessage(self.Player,"Tutorial expired","The tutorial ended because you took too long.","Ok")
					workspace.TutorialService.ShowButton:FireClient(self.Player,self.JobIndex)
					self:TeleportToClosestSpawn()
				end
				
				self:Stop()
			end
		end
	end)
	
	
	
	--record number of time player quit the tutorial - stop tutorial after too many times
	local jobIndex = self.JobIndex
	local playerData = Players[self.Player]
	local CompletedTutorials = playerData["Completed_Tutorials"]
	
	playerData["CurrentJob"] =  jobIndex--change
	
	if type(CompletedTutorials[jobIndex]) ~= "number" then --if boolean value
		CompletedTutorials[jobIndex] = 0
	end
	
	CompletedTutorials[jobIndex] = CompletedTutorials[jobIndex] + 1
	
	if CompletedTutorials[jobIndex] > 3 then  --if quit tutorial 3 times then stop tutorial
		CompletedTutorials[jobIndex] = true
		self:Stop()
	end
	
	
		
	
	while pcall(function() local a =self.TutorialData[self.JobIndex][self.Index] end) and not self.QuitTutorial do
		nextPart(self)
	end
end

function Tutorial:Stop()
	
	self.CancelListener = true
	self.QuitTutorial = true
	workspace.TutorialService.TutorialEnabled:FireClient(self.Player,false)
	workspace.TutorialService.QuitTutorial:FireClient(self.Player)
	
	
	
	if self.Index == 1 and self.JobIndex == 1 and Players[self.Player] and Players["IsNewPlayer"] then --show arrow keys even if player dosent want to do first tutorial
		workspace.TutorialService.ShowArrowKeys:FireClient(self.Player)
	end

	if self.Died then self.Died:disconnect() end
	self.Died = nil
	
	if self.TutorialPlayerOnly then self.TutorialPlayerOnly:Destroy() self.TutorialPlayerOnly = nil end
	
	if Players[self.Player] then
		Players[self.Player]["CurrentJob"] = 0 --stop auto resupply, pizza, and box spawning
		Players[self.Player].TutorialObject = nil
	end
end







function Tutorial.new(player,jobIndex)
	
	
	local this = {}
	setmetatable(this, Tutorial)
	this.Index = 1
	this.JobIndex = jobIndex or 1
	this.Player = player
	this.Dough = nil
	this.Pizza = nil
	this.Box = nil
	this.QuitTutorial = false
	this.TouchEnabled = false   pcall(function() this.TouchEnabled = workspace.TutorialService.IsTouchEnabled:InvokeClient(player) end)
	this.ClosedBox = nil
	this.TimeoutCounter = 0
	this.TutorialPlayerOnly = nil
	
	while player and player.Parent and not Players[player] do wait(.5) end
	if not player or not player.Parent then return end
	local playerData = Players[player]

	
	local backpackItemAdded = nil
	local doughWasStolen = false
	local doughDestroyed = nil
	local pizzaWeldAdded = nil
	local newPizza = nil
	local boxClosed = nil
	local boxWeldDestroyed = nil
	local newBox = nil
	local newDough  = nil
	local doughStolen = nil
	local doughIngredientAdded = nil
	local nameChanged = nil
	local ingredient = "TomatoSauce"
	local newTruck = nil
	local customerAdded = nil
	local tool = nil
	
	
	while player and (not player.Character or not player.Character:FindFirstChild("Humanoid")) do wait(.1) end
	if not player or not player.Parent then return end

	
	this.Died = player.Character.Humanoid.Died:connect(function()
		if this.Player then
			Dialog:ShowMessage(this.Player,"Tutorial expired","The tutorial has ended because you died.","Ok")
			workspace.TutorialService.ShowButton:FireClient(this.Player,this.JobIndex)
			
		end
		this:Stop()
	end)
	
	
	
	
	
	
	this.TutorialData = {   --- messsage, type of message, position message in the center of the screen?, function
		
	{
				-------------------------------Cashier-----------------------------
		{"   The cashier's job is to talk to the customer and submit their order using the cash register.", 4,function()
			
			
			workspace.TutorialService.TutorialEnabled:FireClient(player,true)
			--workspace.TutorialService.GuiEnabled:FireClient(player,"PlayerList",false)
			
			if game.PlaceId ~= 0 then--dont block front door while testing
				workspace.TutorialService.OpenBarrier:FireClient(player,"Cashier",true)
			end
			
		
		end},
	
		{"    Talk to a customer by {clicking the bubble above their head}{tapping the bubble above their head}{pressing the X button} ", 1,function()
			
			--point to customers
			for _,customer in ipairs(workspace.Customers:GetChildren()) do
				if customer:FindFirstChild("Head") and customer.Head:FindFirstChild("Dialog") then
					workspace.TutorialService.ShowArrow:FireClient(this.Player,customer.Head,5)
				end
			end
			
			customerAdded = workspace.Customers.ChildAdded:connect(function(customer)
				if customer:FindFirstChild("Head") and customer.Head:FindFirstChild("Dialog") then
					workspace.TutorialService.ShowArrow:FireClient(this.Player,customer.Head,5)
				end
			end)
			
			
			workspace.TutorialService.OnlyPepperoni:Fire(1,player)
			
			workspace.TutorialService.ShowArrowKeys:FireClient(this.Player)
			
			WaitForEvent("ClickedBubble",this) 
			
			customerAdded:disconnect()
			customerAdded = nil
				
			wait(1)
			
		end},
		
		{"    Choose the correct reply. Only one of the replies is the correct one.", 1,function()
			
				
			
			if WaitForEvent("TalkedToCustomer",this) then
				
			elseif not this.QuitTutorial then
				workspace.TutorialService.PromptPlayer:InvokeClient(this.Player,"You chose the wrong reply. Try again.",5)
				this.Index = 1
			end
		end},
		
		
		{"   The customer wants a pepperoni pizza. Press the pepperoni pizza button on the cash register.",1,function()
			workspace.TutorialService.ShowArrow:FireClient(this.Player,workspace.Register1.ButtonPepperoni)
			workspace.TutorialService.ShowArrow:FireClient(this.Player,workspace.Register2.ButtonPepperoni)
			workspace.TutorialService.ShowArrow:FireClient(this.Player,workspace.Register3.ButtonPepperoni)


			local order_index = WaitForEvent("PressedRegisterButton",this)
			if not order_index and not this.QuitTutorial then
				local items = {"cheese pizza","pepperoni pizza","sausage pizza","mountain dew"}
				workspace.TutorialService.PromptPlayer:InvokeClient(this.Player,"The customer wanted a pepperoni pizza. Try again.",5)
				this.Index = 1 
			end
			
		end},
		{"    You did it!",2,function()
			
				
			
			Players[player]["Completed_Tutorials"][jobIndex] = true
			Players[player]["Tutorials_Left"] = Players[player]["Tutorials_Left"] - 1 --change	
		
			
			workspace.TutorialService.PanToCFrame:FireClient(this.Player,CFrame.new(38.6705284, 9.66503048, 52.6079102, 0.998795152, 0.00153944828, 0.049049437, -0, 0.999507844, -0.0313702002, -0.0490735881, 0.0313324034, 0.998303652))
			wait(.7)
		end},
		{"    The pepperoni pizza order has been added to the order board.",2,function()
			
				
				workspace.TutorialService.TutorialEnabled:FireClient(player,false)
			--	workspace.TutorialService.ShowFloorArrows:FireClient(player,"Cook")
			--teleportToFloorArrow(player,game.ReplicatedStorage.FloorArrows.Cook)

		end},
		
		{"  Cashier tutorial complete. You have " .. Players[player]["Tutorials_Left"] - 1 .. " tutorials left to do.",5,function() --change
			
			
			workspace.TutorialService.OpenBarrier:FireClient(player,"Cashier",false) --change

			--workspace.TutorialService.GuiEnabled:FireClient(player,"PlayerList",true)
			
			this:Stop() --stop tutorial --change

		end},
		
		
		
		
	},
		
		-------------------------COOK----------------------------
		
		
	{
		
		{"    The cook's job is to put ingredients on pizza dough and then cook it.", 4,function()
			workspace.TutorialService.TutorialEnabled:FireClient(player,true)
			
			workspace.TutorialService.OpenBarrier:FireClient(player,"Cook",true)
			workspace.TutorialService.NeverEndingSupply:Fire("TomatoSauce",2,player)
			workspace.TutorialService.NeverEndingSupply:Fire("Cheese",2,player)
			workspace.TutorialService.NeverEndingSupply:Fire("Pepperoni",2,player)
			workspace.TutorialService.NeverEndingSupply:Fire("Sausage",2,player)
			workspace.TutorialService.NeverEndingSupply:Fire("Dough",2,player)
			
			workspace.TutorialService.GuiEnabled:FireClient(player,"PlayerList",false)
			
			
			workspace.TutorialService.TutorialObjects:Fire("Cook",2,player)

			workspace.TutorialService.PanToCFrame:FireClient(this.Player,CFrame.new(38.6705284, 9.66503048, 52.6079102, 0.998795152, 0.00153944828, 0.049049437, -0, 0.999507844, -0.0313702002, -0.0490735881, 0.0313324034, 0.998303652))
			wait(.7)
			workspace.TutorialService.HighlightOrder:FireClient(this.Player)
		end},
		
		
		
		
		
		{"   Look! A pepperoni pizza order is on the order board. Let's make one.",2,function()
			workspace.TutorialService.PanToCFrame:FireClient(this.Player,CFrame.new(54.6426163, 11.2930622, 65.8291931, -0.999005616, 0.0192920901, -0.0401954278, 1.86264537e-009, 0.901538134, 0.43269974, 0.0445853956, 0.432269484, -0.900641561))
			wait(.7)
		end},
		
	
		
		{"   This is the pizza dough dispenser.", 2,function()
			if newDough then newDough:disconnect() newDough = nil end
			if nameChanged then nameChanged:disconnect() nameChanged = nil end
			if doughStolen then doughStolen:disconnect() doughStolen = nil end
			newDough = workspace.TutorialService.NewDough.OnServerEvent:connect(function(Player,dough)
				if this.QuitTutorial then newDough:disconnect() return end
				
				if Player == player and dough and dough.Parent and dough:FindFirstChild("LastDragger") and dough ~= this.Dough then
					
					if this.Dough and this.Dough:FindFirstChild("Tutorial") then
						this.Dough.Tutorial:Destroy()
					end
					
					makeTempOwner(dough,player)
					this.Dough = dough

					
					if doughDestroyed then doughDestroyed:disconnect() end
					doughDestroyed = workspace.AllDough.ChildRemoved:connect(function(child)
						if this.QuitTutorial then doughDestroyed:disconnect() return end
						if this.Dough and child == this.Dough and child.Parent == nil then
						
							this.CancelListener = true
							this.Index = 3
							ingredient = "TomatoSauce"
							--workspace.TutorialService.PromptPlayer:InvokeClient(this.Player,"Oh no! Your pizzas disappeared. Grab another dough and try again.",5)

						end
					end)
					
					
					
					if doughStolen then doughStolen:disconnect() end
					doughStolen = dough.LastDragger.Changed:connect(function(value)
						if this.QuitTutorial then doughStolen:disconnect() return end
						if value ~= nil and value ~= player then
							
							doughIngredientAdded:disconnect()
							doughStolen:disconnect()
							doughWasStolen = true
							this.CancelListener = true --stops any waitfor events
							ingredient = "TomatoSauce"
							this.Index = 3 
							--workspace.TutorialService.PromptPlayer:InvokeClient(this.Player,"Someone took your pizza. Grab another pizza dough if you can't get it back.",5)

						end
					end)
					
					
					
					if doughIngredientAdded then doughIngredientAdded:disconnect() end
					doughIngredientAdded = dough.SG.Frame.ChildAdded:connect(function(ingredient)
					
						if this.QuitTutorial then doughIngredientAdded:disconnect() return end
						
						
						if nameChanged then nameChanged:disconnect() end
						nameChanged = ingredient.Changed:connect(function()
							if this.QuitTutorial then nameChanged:disconnect() return end
							if ingredient.Name ~= "ImageLabel" then
								nameChanged:disconnect()
								workspace.TutorialService.PlayerAction.PlayerAction:Fire(player,ingredient.Name .. "Added",true)
							end
						end)
						
						 
					end)
				elseif Player == player and dough and dough == this.Dough then  ---renew tutorial object
					pcall(function() dough.Tutorial:Destroy() end)
					makeTempOwner(dough,player)
	
				end
			end)

		end},
		
		{"   {Click and drag}{Tap and drag}{Drag} a pizza dough to the table{.}{.}{ by holding the RT button and moving the Right Thumb Stick.}", 1,function()
			for _,obj in ipairs(workspace.AllDough:GetChildren()) do
				if obj.LastDragger.Value == nil then
					workspace.TutorialService.ShowArrow:FireClient(this.Player,obj)
				end
			end
			this.TutorialData[this.JobIndex][5][1] = "{Click on}{Tap on}{Press RT on} the tomato sauce dispenser."
			this.TutorialData[this.JobIndex][6][1] = "Drag the tomato sauce to the pizza dough{.}{.}{ by holding the RT button and moving the Right Thumb Stick.}"
			ingredient = "TomatoSauce"
			WaitForEvent("DraggedToTable",this) 
		end},
		
		--////////////////////Repeat 3 times///////////////////////
		{"   {Click on}{Tap on}{Press RT on}  on the tomato sauce dispenser.", 1,function()
			
			if this.Dough and this.Dough.Parent and not this.Dough.SG.Frame:FindFirstChild(ingredient) then

				workspace.TutorialService.ShowArrow:FireClient(this.Player,getIngredientBlock(ingredient))
				WaitForEvent(ingredient,this)
				
			end

		end},
		{"  Drag the tomato sauce to the pizza dough{.}{.}{ by holding the RT button.}", 1,function()
			
			if not pcall(function () local a = this.Dough:FindFirstChild("SG") end) then return end

			
			if this.Dough and not this.Dough.SG.Frame:FindFirstChild(ingredient) then

				workspace.TutorialService.ShowArrow:FireClient(this.Player,this.Dough)
				if not WaitForEvent(ingredient .. "Added",this) then return end
			 
			end
			if ingredient == "TomatoSauce" then
				ingredient = "Cheese"
				this.TutorialData[this.JobIndex][5][1] = "    {Click on}{Tap on}{Press RT on} on the cheese dispenser."
				this.TutorialData[this.JobIndex][6][1] = "Drag the cheese to the pizza dough."
				this.Index = 4
			elseif ingredient == "Cheese" then
				ingredient = "Pepperoni"
				this.TutorialData[this.JobIndex][5][1] = "    {Click on}{Tap on}{Press RT on} on the pepperoni dispenser."
				this.TutorialData[this.JobIndex][6][1] = "Drag the pepperoni to the pizza dough."
				this.Index = 4
			elseif ingredient == "Pepperoni" then
				if this and this.Dough and (not this.Dough.SG.Frame:FindFirstChild("TomatoSauce")) or (not this.Dough.SG.Frame:FindFirstChild("Cheese")) then
					ingredient = "TomatoSauce"
					this.TutorialData[this.JobIndex][5][1] = " {Click on}{Tap on}{Press RT on} on the tomato sauce dispenser."
					this.TutorialData[this.JobIndex][6][1] = "Drag the tomato sauce to the pizza dough."
					this.Index = 4
				end
			end

		end},
		--//////////////////////////////////////////////////
		
		{"  Drag the pizza dough to the oven.", 1,function()
			workspace.TutorialService.ShowArrow:FireClient(this.Player,this.Dough)
			if not WaitForEvent("DraggedToOven",this) then return end
			if newDough then newDough:disconnect() end
			if nameChanged then nameChanged:disconnect() end
			if doughStolen then doughStolen:disconnect() end
			if doughDestroyed then doughDestroyed:disconnect() end

		end},
		
		{"    You did it! The pizza is now on its way to the boxing room.",2,function()
			Players[player]["Completed_Tutorials"][jobIndex] = true --save progress --change
			Players[player]["Tutorials_Left"] = Players[player]["Tutorials_Left"] - 1 --change
			

			workspace.TutorialService.ShowRecipes:FireClient(player)
			workspace.TutorialService.PanToCFrame:FireClient(this.Player,CFrame.new(44.2346268, 12.7867823, 47.1908989, 0.00351402792, 0.197684988, -0.980259359, 5.82076609e-011, 0.980265439, 0.197686195, 0.999993861, -0.000694674847, 0.00344467978))
			wait(.7)
		end},
		
		{"    Here are all the pizza recipes.",2,function()
			
			
				
			workspace.TutorialService.TutorialEnabled:FireClient(player,false)
			--workspace.TutorialService.ShowFloorArrows:FireClient(player,"Boxer")
			--teleportToFloorArrow(player,game.ReplicatedStorage.FloorArrows.Boxer)
		end},
		
		
		{"  Cook tutorial complete. You have " .. Players[player]["Tutorials_Left"] - 1 .. " tutorials left to do.",5,function() --change
			
			workspace.TutorialService.OpenBarrier:FireClient(player,"Cook",false) --change

			workspace.TutorialService.GuiEnabled:FireClient(player,"PlayerList",true)
			
			this:Stop() --stop tutorial --change

		end},
		
		
		
	},
	
	
	----------------------------------------------BOXER------------------------------------------
	
	
	{
		{"    The boxer's job is to put the customer's pizza in a box.", 4,function()
			
			workspace.TutorialService.TutorialEnabled:FireClient(player,true)
			
			workspace.TutorialService.OpenBarrier:FireClient(player,"Boxer",true)
			
			
			
			workspace.TutorialService.NeverEndingSupply:Fire("Box",3,player)

			workspace.TutorialService.GuiEnabled:FireClient(player,"PlayerList",false)
			
			
			workspace.TutorialService.TutorialObjects:Fire("Boxer",3,player)
			
			workspace.TutorialService.PanToCFrame:FireClient(this.Player,CFrame.new(52.259819, 11.0873528, 23.0167656, -0.736458659, 0.377384096, -0.56143564, -0, 0.829933643, 0.557862222, 0.676482618, 0.410842478, -0.611211717))
			wait(.7)


		end},
		
		{"    Pizzas that need to be put in boxes will show up here.", 2,function()
			if newPizza then newPizza:disconnect() end
			if newBox then newBox:disconnect() end
			--player grab a new pizza
			newPizza = workspace.TutorialService.NewPizza.OnServerEvent:connect(function(Player,pizza)
				if Player == player and pizza and pizza ~= this.Pizza then
					if this.QuitTutorial then newPizza:disconnect() return end
					if this.Pizza and this.Pizza:FindFirstChild("Tutorial") then this.Pizza.Tutorial:Destroy() end
		
					makeTempOwner(pizza,player)

					this.Pizza = pizza
					--[[pizzaWeldAdded = pizza.ChildAdded:connect(function(obj)
						if obj.Name == "PizzaWeld" and obj.Part0 then
							print("pizza weld")
							this.Box = obj.Part0
							workspace.TutorialService.PlayerAction.PlayerAction:Fire(player,"PlacedInBox",true)
						end
					end)]]
				end
			end)
			--player place pizza in a box
			newBox = workspace.TutorialService.NewBox.OnServerEvent:connect(function(Player,box)
				if Player == player and box and box ~= this.Box then
					if this.Box and this.Box:FindFirstChild("Tutorial") then this.Box.Tutorial:Destroy() end
					makeTempOwner(box,player)
				
					this.Box = box
					
					if boxWeldDestroyed then boxWeldDestroyed:disconnect() end
					boxWeldDestroyed  = box.ChildRemoved:connect(function(child)
						if this.QuitTutorial then boxWeldDestroyed:disconnect() boxWeldDestroyed = nil return end
						if child:IsA("Weld") then
							wait(.1)
							if box and box.Parent then
								this.CancelListener = true
								this.Index = 2
								
							end
						end
					end)
					
					
					
					if boxClosed then boxClosed:disconnect() end
					boxClosed = workspace.TutorialService.BoxClosed.Event:connect(function(closedPlayer,box,closedBox)
						if this.QuitTutorial then boxClosed:disconnect() return end
						if closedPlayer == player and box == this.Box then
							if this.ClosedBox and this.ClosedBox:FindFirstChild("Tutorial") then this.ClosedBox.Tutorial:Destroy() end
							makeTempOwner(closedBox,player)
							this.ClosedBox = closedBox
							workspace.TutorialService.PlayerAction.PlayerAction:Fire(player,"ClosedBox",true)
							boxClosed:disconnect()
							newBox:disconnect()
							newPizza:disconnect()
						else --someone else closed the box
							this.CancelListener = true
							this.Index = 3
						--	workspace.TutorialService.PromptPlayer:InvokeClient(this.Player,"Somebody else boxed your pizza. Try again.",5)

						end
					end)
				end
			end)
			

		end},
		{"    Drag a pizza to an open box{.}{.}{ by holding the RT button and moving the Right Thumb Stick.}", 1,function()
			for _,pizza in ipairs(workspace.BoxingRoom:GetChildren()) do
				if pizza.Name == "Pizza" then
					workspace.TutorialService.ShowArrow:FireClient(this.Player,pizza)
				end
			end
			if not WaitForEvent("ButtonUp",this) then return end
			
			if this.Box and this.Pizza and this.Box:FindFirstChild("PizzaWeld") and this.Box.PizzaWeld.Part1 == this.Pizza then
				
			else
				this.Index = this.Index - 1
			end
			

		end},
		{"     {Click}{Tap}{Press the RT button} on the box to close it.", 1,function()
			workspace.TutorialService.ShowArrow:FireClient(this.Player,this.Box)
			if not WaitForEvent("ClosedBox",this) then return end
			
		end},
		{"    Drag the boxed pizza to the lower convayor{.}{.}{ with the RT button.}", 1,function()
			workspace.TutorialService.ShowArrow:FireClient(this.Player,this.ClosedBox)
			if not WaitForEvent("DraggedToDelivery",this) then return end	

		end},
		{"    You did it! The pizza is now ready to be delivered.", 2,function()
				Players[player]["Completed_Tutorials"][jobIndex] = true
				Players[player]["Tutorials_Left"] = Players[player]["Tutorials_Left"] - 1 
				workspace.TutorialService.TutorialEnabled:FireClient(player,false)
				--workspace.TutorialService.ShowFloorArrows:FireClient(player,"Delivery")
				--teleportToFloorArrow(player,game.ReplicatedStorage.FloorArrows.Delivery)
				
				if newPizza then newPizza:disconnect() end
				if newBox then newBox:disconnect() end
				if boxWeldDestroyed then boxWeldDestroyed:disconnect() end
				if boxClosed then boxClosed:disconnect() end



		end},
		
		
		{"  Boxer tutorial complete. You have " .. Players[player]["Tutorials_Left"] - 1 .. " tutorials left to do.",5,function() 
			
			workspace.TutorialService.GuiEnabled:FireClient(player,"PlayerList",true)
			workspace.TutorialService.OpenBarrier:FireClient(player,"Boxer",false)

			

			this:Stop() --stop tutorial --change

		end},
		
		
		
	},
	
	--------------------------------------Delivery--------------------------------
	
	
	{
		
		
		
		{"    Delivery's job is to take the pizza to the customer's house.", 4,function()
			
			workspace.TutorialService.TutorialEnabled:FireClient(player,true)
			
			workspace.TutorialService.OpenBarrier:FireClient(player,"Delivery",true)
			
			
			workspace.TutorialService.GuiEnabled:FireClient(player,"PlayerList",false)
			
			workspace.TutorialService.TutorialObjects:Fire("Delivery",4,player)
			
			workspace.TutorialService.GuiEnabled:FireClient(player,"Backpack",true)
			

		end},
		
		{"   Grab a pizza off the table.", 1,function()
			if player:FindFirstChild("Backpack") and (not player.Backpack:FindFirstChild("PizzaTool")) and (not player.Character:FindFirstChild("PizzaTool")) then
				
				for _,obj in ipairs(workspace:GetChildren()) do
					if obj:FindFirstChild("PlayerCustomer") and obj:FindFirstChild("Handle") then --if is pizza tool
						workspace.TutorialService.ShowArrow:FireClient(this.Player,obj.Handle)
					end
				end
				
				WaitForEvent("GrabbedPizza",this)
			else
				
			end
			

			

			--[[workspace.TutorialService.PanToCFrame:FireClient(this.Player,CFrame.new(56.3462296, 10.5218115, 28.5572853, -0.789097905, 0.246659815, -0.562568605, 1.49011594e-008, 0.915836573, 0.401551187, 0.614267409, 0.316863209, -0.722684801))
			wait(1)]]

		end},
		{"   You need to deliver this pizza to the correct house.", 2,function()
			
			tool = this.Player.Backpack:FindFirstChild("PizzaTool") or  this.Player.Character:FindFirstChild("PizzaTool") 
			if tool then
				print("TOOLVALUE",tool.House.Value)
			
				workspace.TutorialService.ChangeHouseLabel:FireClient(this.Player,tool.House.Value.Address.Value)
			end
			
			workspace.TutorialService.PanToCFrame:FireClient(this.Player,CFrame.new(15.3470573, 6.99142218, -362.721588, 0.921191931, 0.104526073, -0.374806285, -0, 0.963243604, 0.268629611, 0.389108539, -0.247459427, 0.887332201))
			wait(.7)

		end},
		{"   Each house has a label on the mailbox.", 2,function()
			
			workspace.TutorialService.ChangeHouseLabel:FireClient(this.Player,"B2") --change label back

		end},

		
		{"  Find a car and drive to the correct house.", 1,function()
			
			--workspace.TutorialService.OpenBarrier:FireClient(player,"Delivery",false)
			
			for _,car in ipairs(workspace.Cars:GetChildren()) do
				if car:FindFirstChild("Driver") then
					workspace.TutorialService.ShowArrow:FireClient(this.Player,car.Driver)
				end
			end
			
			this.TimeoutCounter = 180 -- timout in 3 minutes instead of one
			
			WaitForEvent("DeliveredPizza",this) 
			

		end},
		{"  You did it! Now everyone working gets 15 Moneyz added to their paycheck!", 2,function()
			
			Players[player]["Completed_Tutorials"][jobIndex] = true
			Players[player]["Tutorials_Left"] = Players[player]["Tutorials_Left"] - 1 

		
			workspace.TutorialService.TutorialEnabled:FireClient(player,false)
			
		
		end},
	
		
		
		{"  Delivery tutorial complete. You have " .. Players[player]["Tutorials_Left"] - 1 .. " tutorials left to do.",5,function() 
			
			workspace.TutorialService.OpenBarrier:FireClient(player,"Delivery",false) 
			--workspace.TutorialService.GuiEnabled:FireClient(player,"PlayerList",true)

			

			this:Stop() --stop tutorial --change

		end},
		
		
		
		
	},
	----------------------------------------------Supplier----------------------------
	
	{
		
		{"    The Supplier's job is to keep the pizza place stocked with supplies", 4,function()
			
			workspace.TutorialService.TutorialEnabled:FireClient(player,true)

			--workspace.TutorialService.GuiEnabled:FireClient(player,"PlayerList",false)
			


		end},
		
		{"  Go to the supply truck and then sit in the driver's seat.", 1,function()
			
			
			
			newTruck = Vehicles:RespawnInactiveTruck() --respawn inactive trucks or create a new one
			
			this.TutorialPlayerOnly = script.TutorialPlayerOnly:clone() --disable other player from stealing truck
			this.TutorialPlayerOnly.Disabled = false
			this.TutorialPlayerOnly.Parent = newTruck.Driver
			this.TutorialPlayerOnly.Player.Value = this.Player
			
			workspace.TutorialService.ShowArrow:FireClient(this.Player,newTruck.Driver) --show arrows to closest inactive truck
			
			workspace.TutorialService.ShowFloorWire:FireClient(this.Player,newTruck.Driver,this.Player.Character.HumanoidRootPart) 
	

			WaitForEvent("InDriversSeat",this) 
			
			
		
			
		
		end},
	
		{"  Drive the truck into the supply factory.", 1,function()
			
			workspace.TutorialService.ShowArrow:FireClient(this.Player,workspace.TutorialGuider) 
			workspace.TutorialService.ShowArrow:FireClient(this.Player,workspace.TutorialGuider1)
			
			if not newTruck or not newTruck:FindFirstChild("Driver") then this:Stop() return end 
			
			workspace.TutorialService.ShowFloorWire:FireClient(this.Player,workspace.TutorialGuider, newTruck.Driver)
			workspace.TutorialService.ShowFloorWire:FireClient(this.Player,workspace.TutorialGuider1, newTruck.Driver)
			
			while newTruck:FindFirstChild("Driver") and not this.QuitTutorial and newTruck and this.TutorialPlayerOnly and  (newTruck.Driver.Position - workspace.TutorialGuider.Position).magnitude > 15 and (newTruck.Driver.Position - workspace.TutorialGuider1.Position).magnitude > 15 do
				wait(.1)
			end
			
			if this.QuitTutorial then return end
			workspace.TutorialService.PanToCFrame:FireClient(this.Player,CFrame.new(6.45414686, 21.7759361, -688.468384, 0.999970675, 0.00469931448, -0.00604617549, 2.32830616e-010, 0.789559007, 0.613674819, 0.00765766203, -0.613656819, 0.78953582))
			wait(.7)
		
		end},
		
		
		{"  These buttons create supply boxes when stepped on.", 2,function()
	
			
			workspace.TutorialService.PanToCFrame:FireClient(this.Player,CFrame.new(6.99375582, 21.5164871, -688.610229, 0.999899685, -0.000680542376, 0.0141488984, -0, 0.998845339, 0.0480430722, -0.0141652552, -0.0480382517, 0.998745084))
			wait(.7)
		
		end},
		
		{"  These counters show the number of items in stock at the pizza place. Your job is to keep these numbers above 0.", 2,function()
	
		
		end},
		
		{"  Jump out of the truck. {Press the space key/ /Press A} ", 1,function()
			
			if not newTruck or not newTruck:FindFirstChild("Driver") then this:Stop() return end 

			if player.Character.Humanoid.SeatPart  and player.Character.Humanoid.SeatPart == newTruck.Driver then --just in case player already jumped olut of seat
				WaitForEvent("SeatWeldDestroyed",this)
			end
			
		
		end},
		
		{"  Step on any of the supply buttons.", 1,function()
			
			for _,button in ipairs(workspace.SupplyButtons:GetChildren()) do
				workspace.TutorialService.ShowArrow:FireClient(this.Player,button.Ring)
			end
			
			if not WaitForEvent("SupplyButtonPressed",this) then return end
			
			workspace.TutorialService.PanToCFrame:FireClient(this.Player,CFrame.new(8.42557812, 23.1575394, -684.979736, -0.999977469, -0.00290139415, 0.00607006531, -0, 0.902231514, 0.431252152, -0.00672783703, 0.431242436, -0.90221101))

		
		end},
		
		{"  A supply box was created.", 2,function()

		
		end},
		
		
		{"  Drag the supply box into the truck{.}{.}{ by holding the RT button and moving the Right Thumb Stick.}", 1,function()
			
			for _,box in ipairs(workspace.AllSupplyBoxes:GetChildren()) do
				workspace.TutorialService.ShowArrow:FireClient(this.Player,box)
			end
			
			WaitForEvent("DraggedToTruck",this)
			
	
			
		
		end},
		
		{"  Continue to place boxes into the truck until it's filled. Sit in the driver's seat when you're done.", 1,function()
			
			if not newTruck or not newTruck:FindFirstChild("Driver") then this:Stop() return end 
			
			this.TimeoutCounter = 240 -- timout in 4 minutes instead of one

			workspace.TutorialService.ShowArrow:FireClient(this.Player,newTruck.Driver) --show arrows to closest inactive truck
			
			WaitForEvent("InDriversSeat",this) 
			

		
		end},
		
		{"  Drive to the pizza place.", 1,function()
			
			if not newTruck or not newTruck:FindFirstChild("Driver") then this:Stop() return end 

			workspace.TutorialService.ShowFloorWire:FireClient(this.Player,workspace.TutorialGuider2, newTruck.Driver)

			this.TimeoutCounter = 240 -- timout in 4 minutes instead of one
			
			while newTruck:FindFirstChild("Driver") and not this.QuitTutorial and newTruck and this.TutorialPlayerOnly and  (newTruck.Driver.Position - workspace.TutorialGuider2.Position).magnitude > 15 do
				wait(.1)
			end
			
		
		end},
		
		{"  Drag the supply boxes out of the supply truck {.}{.}{ using the RT button + hold.}", 1,function()
			
			this.TimeoutCounter = 180 -- timout in 3 minutes instead of one
			
			for _,obj in ipairs(workspace.AllSupplyBoxes:GetChildren()) do
				if obj:CanSetNetworkOwnership() and obj:GetNetworkOwner() == this.Player then
					workspace.TutorialService.ShowArrow:FireClient(this.Player,obj)
				end
			end
		
			WaitForEvent("DraggedToSupplyBelt",this) 
			
		
		end},
		
		{"  You did it! Continue to unload the truck.", 2,function()
			
			if this.TutorialPlayerOnly then this.TutorialPlayerOnly:Destroy() this.TutorialPlayerOnly = nil end
		
			Players[player]["Completed_Tutorials"][jobIndex] = true
	
			
			Players[player]["Tutorials_Left"] = Players[player]["Tutorials_Left"] - 1 
			
			workspace.TutorialService.TutorialEnabled:FireClient(player,false)
			
		
		end},
		
	
		{"  Supplier tutorial complete. You have " .. Players[player]["Tutorials_Left"] - 1 .. " tutorials left to do.",5,function() 
			
			--workspace.TutorialService.GuiEnabled:FireClient(player,"PlayerList",true)
			
			

			this:Stop() --stop tutorial --change

		end},
		
		


		
	},
	
	
	
	
	
	
	------------------FURNITURE PLACEMENT TUTORIAL------------------------------
	
	{
		{"    Would you like to put some furniture inside your house?", 4,function()
				
			workspace.TutorialService.TutorialEnabled:FireClient(player,true)

			

		end},	
		
		{"    Follow the arrows to your house.", 1,function()
			
			workspace.TutorialService.ShowFloorWire:FireClient(this.Player,playerData.House.GivePizza,player.Character.HumanoidRootPart)
			
			this.TimeoutCounter = 300 -- timout in 5 minutes instead of one
			
			WaitForEvent("EnteredHouse",this)

			wait(.5)
			
		end},
		
		{"    {Open your inventory}{Open your inventory}{ Press the Menu button on your controller and choose 'Inventory'}", 1,function()
			
			if Enums.IsConsoleServer then --wait for radial menu to open first
				workspace.TutorialService.ShowGamepadMenuHelp:FireClient(player,true)
				workspace.TutorialService.AnimatedArrowSprite:FireClient(player,"RadialMenu")
				WaitForEvent("RadialMenuOpened",this)
				workspace.TutorialService.ShowGamepadMenuHelp:FireClient(player,false)
			else
				workspace.TutorialService.AnimatedArrowSprite:FireClient(player,"Menu")
			end
			
			WaitForEvent("InventoryOpened",this)
	
			this:Stop()

		end}
		
		
	}
	
}
	
	
	
	
	return this
end
	



return Tutorial
