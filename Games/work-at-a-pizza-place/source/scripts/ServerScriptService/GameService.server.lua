local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
if Enums.IsPartyServer then
	script:Destroy()
	return
end


local Global = require(script.Parent.Global)
local Players = Global.Players
local Houses = Global.Houses
local Manager = Global.Manager
local Timer = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Timer"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))

local Tutorial = require(script.Parent:WaitForChild("Tutorial"))



local Dialogs = {}




--pizza, lane
--forms - customer, orderboad, phyiscal food, pre-box, post box, tool

--Phase = 1, House = "a1", Object = workspace.Box, Order = 3, Player = game.Players.Dued1, Lane = workspace.Lane1

--[[{Phase = 3, House = workspace.Houses.House1, Object = game.Workspace.Pizza, Order = 1, Player = nil, Lane = workspace.Lane1},
	{Phase = 3, House =  workspace.Houses.House1, Object = game.Workspace.Dew, Order = 4, Player = nil, Lane = workspace.Lane1},
	{Phase = 5, House =  workspace.Houses.House1, Object = game.Workspace.PizzaTool, Order = 4, Player = nil, Lane = workspace.Lane1}]]
orders = {
	--{Phase = 2, House = workspace.Houses.House1, Object = game.Workspace.Orders, Order = 1, Player = nil, Lane = workspace.Lane1},
	--{Phase = 3, House =  workspace.Houses.House1, Object = game.Workspace.Dew, Order = 4, Player = nil, Lane = workspace.Lane1},
--	{Phase = 3, House =  workspace.Houses.House1, Object = workspace.BoxingRoom.Pizza, Order = 2, Player = nil, Lane = workspace.Lane1},
}

local Customers = require(script.Parent:WaitForChild("Customers"))

game.Players.PlayerAdded:connect(function(player) 
	if player.Name == "Dued1" and Enums.IsOnline and #game.Players:GetPlayers() > 1 then return end
	Customers:AddOutfit(player) 
end)

local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))

Customers:Initialize(orders)



print("GameService Started")

--lanes_occupied = {[workspace.Lane1] = nil,[workspace.Lane2] = nil}

player_models = {}--game.ServerStorage.Customers.PlayerModelStorage.CustomerTemplate

items = {"cheese pizza","pepperoni pizza","sausage pizza","mountain dew"}

houses = workspace.Houses:GetChildren()


customer_negative_index = 50



player_negative_index = 30

			
--house_numbers = {"a1","a2","a3","b4","b5","b6","b1","b2","b3","c1","c2","c3"}







--cheese,pepperoni,sausage,mtn dew
order_board_decals = {"http://www.roblox.com/Thumbs/Asset.ashx?Width=110&Height=110&AssetID=168541857",
	"http://www.roblox.com/Thumbs/Asset.ashx?Width=110&Height=110&AssetID=168540808",
	"http://www.roblox.com/Thumbs/Asset.ashx?Width=110&Height=110&AssetID=168541778",
	"http://www.roblox.com/Thumbs/Asset.ashx?Width=110&Height=110&AssetID=168143658",
}


--[[
spawn(function()
	while true do
		wait(65)
		for _,pizza in ipairs(workspace.BoxingRoom:GetChildren()) do
			if pizza.Position.Y >= 15 or (pizza.Position - workspace.MiddlePad.Position).magnitude > 70 then
				pizza.Position = Vector3.new(62.5, 9.5, 43.2)
				wait(1)
			end
		end
	end
end)]]


board_objects = game.Workspace.Orders:GetChildren()



GameService = workspace.GameService

function findOrder(key,value,phase)
	for i,val in pairs(orders) do
		if val[key] == value and val.Phase == phase then
			return val,i
		end
	end
	return nil
end

function printOrderFields(...)
	local fields = {...}
	local str = ""
	for index,order in pairs(orders) do
		
		str = "{"
		for i, field in pairs(fields) do
			local getName =  order[field]
			if getName == nil then getName = "nil" end
			pcall(function() getName = order[field].Name end)
			str = str .. field .. "=" .. getName .. " "
		end
		str = str .. "}"
		print(str)
	
	end
	
end

local inactivityTimer = {}

function updateJobsCompleted(player,job)
	if player ~= nil and Players[player] ~= nil then
		local player_data = Players[player]
		
		local jobs = player_data["Jobs_Completed"]
		if jobs[job] ~= nil then
			jobs[job] = jobs[job] + 1
		else
			jobs[job] = 1
		end
		
		--if player doesnt work for 5 mintues, then put them on break except for managers
		if player ~= Manager.CurrentManager then
			local timer = inactivityTimer[player]
			if timer == nil then
				timer = Timer.new()
				timer:Start(300)
				timer:OnFinish(function()
					inactivityTimer[player] = nil
					if player and player.Parent and player ~= Manager.CurrentManager then
						Players[player]:SetJob("On Break")
					end
				end)
				inactivityTimer[player] = timer
			else
				timer:Reset()
			end
		end


		game.workspace.Main.RefreshJobsCompleted:FireClient(player,jobs)
		
		return jobs
	end
end


workspace.Main.RefreshJobsCompleted.OnServerEvent:connect(function(player)
	game.Workspace.Main.RefreshJobsCompleted:FireClient(player,Players[player].Jobs_Completed)
end)

--spawn order out of thin air for tutorial
function CreateOrderForPlayer(jobName,player)
	local new_order = {}
	new_order.House = houses[math.random(1,#houses)]
	new_order.Order = 2
	table.insert(orders,new_order)
	if jobName == "Cook" then
		new_order.Phase = 2
		new_order.Object = workspace.Orders
		refreshOrderBoard()
	elseif jobName == "Boxer" then
		new_order.Phase = 3
		local pizza = game.ServerStorage.Supplies.PizzaTemplate:clone()
		pizza.Locked = false
		pizza.Name = "Pizza"
		pizza.Tutorial.remover.Disabled = false
		pizza.Tutorial.Value = player
		pizza.Parent = workspace.BoxingRoom
		pizza.Position = Vector3.new(60.801, 6.5, 37.7)
		new_order.Object = pizza
	elseif jobName == "Delivery" then
		new_order.Phase = 5
		local pizza = game.ServerStorage.Supplies.PizzaToolTemplate:clone()
		pizza.Handle.Locked = false
		pizza.TextureId = house_numbers_decals[new_order.House.Address.Value]
		pizza.Name = "PizzaTool"
		pizza.House.Value = new_order.House
		pizza.Handle.Tutorial.remover.Disabled = false
		pizza.Handle.Tutorial.Value = player
		pizza.Parent = workspace
		pizza.Handle.Position = pizza.Handle.Position+ Vector3.new(0,.05,0)
		pizza.BringToHouse.Text = "Bring to house " .. new_order.House.Address.Value
		pizza.Changed:connect(function(prop)
			if prop == "Parent" then
				
			end
		end)
		new_order.Object = pizza
		
	end
end

--spawn order for testing
delay(8,function() pcall(function() CreateOrderForPlayer("Boxer",game.Players.Player1) end) end)
delay(8,function() pcall(function() CreateOrderForPlayer("Boxer",game.Players.Player) end) end)

--fabricates orders for the tutorial
workspace.TutorialService.TutorialObjects.Event:connect(function(jobName,jobIndex,player)
	
	while player and player.Parent and Players[player]["CurrentJob"] == jobIndex and player do --while player is doing same job
			
		if jobName == "Cook" then  --put an new order on the order board
			local order,order_index = findOrder("Order",2,2)
			
			if order == nil or order.Object == nil then
			
				--find number of orders on the order board
				local numOrdersOnBoard = 0
				local lastOrderIndex = 0
				for i,order in ipairs(orders) do
					if order.Phase == 2 then
						numOrdersOnBoard = numOrdersOnBoard + 1
						lastOrderIndex = i
					end
				end

				--if order board is full
				if numOrdersOnBoard < 18 then
					CreateOrderForPlayer("Cook",player)
					
				else
					--change existing order to pepperoni
					local changeOrder = orders[lastOrderIndex]
					changeOrder.Order = 2
					refreshOrderBoard()
				end
				
				
				
				wait(20)
			end
			
		elseif jobName == "Boxer" then  --spawn a pizza in the boxing room if there are no boxes
			--[[local order,order_index = findOrder("Phase",3,3)
			if order == nil or order.Object == nil or (order.Object:FindFirstChild("Tutorial") or order.Object.Tutorial.Value ~= player) then
				CreateOrderForPlayer("Boxer",player)
			end]]
			local Order = nil
			for _,order in ipairs(orders) do --find pizza in boxing area
				
				if order.Phase == 3 and order.Object and (order.Object:FindFirstChild("Tutorial") == nil or order.Object.Tutorial.Value == player) and (order.Object.Position - workspace.MiddlePad.Position).magnitude < 60 then
					Order = order
					break
				end
			end
			if Order == nil then
				CreateOrderForPlayer("Boxer",player)
				wait(20)--wait longer so dont exploit and keep boxing new pizzas
			end
			
			
			
		elseif jobName == "Delivery" then
			local Order = nil
			for _,order in ipairs(orders) do --check if there is a pizza on the table
				if order.Phase == 5 and order.Object and ((order.Object.Parent == player.Backpack) or (order.Object.Parent == player.Character) or (order.Object.Parent == workspace and (order.Object.Handle.Position - workspace.DeliveryTable.Position).magnitude < 10)) then
					Order = order
					break
				end
			end
			if Order == nil then
				CreateOrderForPlayer("Delivery",player)
			end
		end
		wait(2)
	end
end)
--[[
	Phases
	1 = Customer
	2 = Order board
	3 = Boxing room
	4 = Closed box
	5 = Delivery room
]]

--order.Object = game.Workspace.Orders
				--order.Phase = 2
--{Phase = 3, House = workspace.Houses.House1, Object = game.Workspace.Pizza, Order = 1, Player = nil, Lane = workspace.Lane1},




function check(hit)
	local g = hit.Parent:GetChildren()
	for i = 1 ,#g do
		if g[i].className == "Tool" then
			return g[i]
		end
	end
	return nil
end


--workspace.GameService.PrintInfo:Invoke()
--local l = game.Workspace.Houses.House10[""]:GetChildren() for i,v in ipairs(l) do print(v) end
function game.Workspace.GameService.PrintInfo.OnInvoke()
	--[[print("Lanes occupied",lanes_occupied[workspace.Lane1] or "nil",lanes_occupied[workspace.Lane2] or "nil")
	print("Number of orders on board",num_orders_on_board)
	print("death count",death_count)
	print("remove_count",remove_count)
	print("Num customer",#workspace.Customers:GetChildren())
	printOrderFields("Object","Phase","Lane")
	]]
end



--update amount of points to award players

	
--award points every 45 min to an hour
--double time
multiplier = 1
--[[delay(0,function()
	while true do
		wait(math.random(2400,3600)) --every 40-60 min
		multiplier = 2
		game.Workspace.MessageService.DialogAll:FireAllClients("Double Time! Every delivery is worth double!","Start","",2)
		game.workspace.Main.PizzaPriceChange:FireAllClients(pizza_price * multiplier)
		--speed up cusomters respawn rate during double time
		script.IsDoubleTime.Value = true	
		wait(240)
		multiplier = 1
		script.IsDoubleTime.Value = false		
		Dialog:ShowMessage("Double time is now over.","Ok")
	
		game.workspace.Main.PizzaPriceChange:FireAllClients(pizza_price * multiplier)
	end
end)]]
	
SPEED = 10
pizza_price = 15
delivery_rate = 0
	
	--update value of each pizza every 30 seconds

--[[delay(15,function()
	while true do
		wait(30)
			
		if delivery_rate > 2 then delivery_rate = 2 end
			
		local price = pizza_price - 10
		if delivery_rate * 2 > price then
			pizza_price = pizza_price + 1
		elseif delivery_rate * 2 < price then
			pizza_price = pizza_price - 1
		end
			
		if pizza_price > 15 then pizza_price = 15 end
		if pizza_price < 10 then pizza_price = 10 end
	
	
	
		delivery_rate = 0
		--game.workspace.Main.PizzaPriceChange:FireAllClients(pizza_price * multiplier)
	end
end)]]





-----Cashier---------------------------------------------------------------------------------------------------------------------------------------------------------




--[[
function GameService.GetCustomerOrder.OnServerInvoke(player,customer)
	if customer.TalkingTo.Value ~= nil then return nil end
	local order,order_index = findOrder("Object",customer,1)
	if order ~= nil then
		
		
		delay(1, function() chat_service:Chat(customer.Head,string.gsub(customer_dialogs[math.random(1,#customer_dialogs)],"ordername",items[order.Order]),0) end)
		customer.TalkingTo.Value = player
		GameService.RefreshAllChatboxes:FireAllClients()
		return order.Order
	end
	return nil
end
]]
--[[function removeOrderFromCustomer(customer,lane)
	
	if lanes_occupied[workspace.Lane1] == customer then
		lanes_occupied[workspace.Lane1] = nil
		
	end
	if lanes_occupied[workspace.Lane2] == customer then
		lanes_occupied[workspace.Lane2] = nil
		
	end
	customer:Destroy()
end]]
spawn_rate = 30
--[[function gatherJoints(torso,customer)
	local parts = {}
	for i,v in ipairs(torso:GetChildren()) do
		if v:IsA("Motor6D") then
			parts[v.Name] = {v:clone(),customer[v.Name].Part0,customer[v.Name].Part1}
		end
	end
	return parts
end]]


function changeOrder(customer,newOrder)
	for _,order in ipairs(orders) do
		if order.Object == customer then
			order.Order = newOrder
		end
	end
end

death_count = 0
remove_count = 0

local onlyPepperoni = false
local timeoutFunction = nil
local countDown = 0


workspace.TutorialService.OnlyPepperoni.Event:connect(function(jobIndex,player)
	if Players[player] then
		while player and player.Parent and Players[player]["CurrentJob"] == jobIndex and player do 
			for _,customer in ipairs(workspace.Customers:GetChildren()) do
				if customer:FindFirstChild("RightOrder") and customer:FindFirstChild("Head") and customer.Head:FindFirstChild("Dialog") then
					customer.Head.Dialog.Correct.ResponseDialog = "I would like to order a pepperoni pizza."
					changeOrder(customer,2)
				end
			end
			wait(3)
		end
	end
end)




--[[function spawnCustomer(lane)
	game.ServerStorage.Customers.PlayerModelStorage:WaitForChild("CustomerTemplate")--remove in final version
	while #player_models == 0 do
		wait(.1)
	end

	
	
	if lanes_occupied[lane] == nil then
		lanes_occupied[lane] = true --will become a object value
		 -- primer
		playSoundEffect("EntranceTone",game.ServerStorage.Ranges.Range1)
		local new_order = {}
		new_order.House = houses[math.random(1,#houses)]
		--if onlyPepperoni then
			--new_order.Order = 2
		--else
			new_order.Order = math.random(1,4)
		--end
		
		new_order.Phase = 1
		new_order.Lane = lane
		
		local num = #player_models
		local random_player_model = player_models[math.random(1,num)]
		
		local customer  = random_player_model:clone()
		lanes_occupied[lane] = customer
		local remove_debounce = false
		if customer:FindFirstChild("Torso") == nil then  removeOrderFromCustomer(customer,lane) return end
		customer.Torso.Anchored = false
		
		--local parts = gatherJoints(game.ServerStorage.Customers.CustomerTemplate.Torso,customer.Torso)
		--local partsRoot = gatherJoints(game.ServerStorage.Customers.CustomerTemplate.HumanoidRootPart,customer.HumanoidRootPart)
		
		local connect = customer.ChildRemoved:connect(function(part)
			if part.Name == "Head" then
				wait()
				removeOrderFromCustomer(customer,lane)
				remove_count = remove_count + 1
			end
		end)
		
	
	
	
		
		local h = Instance.new("Humanoid",customer)
		
		h.Died:connect(function()
			wait()
			removeOrderFromCustomer(customer,lane)
			death_count = death_count + 1
		end)
		--h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		
		--h:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
		
		customer.Animate.Disabled = false
		customer.Head.Emotion.Disabled = false
		customer.Jumper.Disabled = false
		customer.Parent = game.Workspace.Customers
		customer:MakeJoints()
	
		--customer.Head.Dialog.InitialPrompt = string.gsub(customer_dialogs[math.random(1,#customer_dialogs)],"ordername", items[new_order.Order])
		local order_name = items[new_order.Order]
		local right_index = math.random(1,3)
		
	
		for i,choice in ipairs(customer.Head.Dialog:GetChildren()) do
			
			if choice.Name ~= "Response" then
				if right_index == i then  --right answer
					local random_customer_dialog = customer_dialogs[math.random(1,customer_negative_index-1)]
					--if onlyPepperoni then
						--choice.ResponseDialog = "I would like to order a pepperoni pizza."
					--else
						choice.ResponseDialog =  string.gsub(random_customer_dialog,"ordername", order_name)
					--end
					choice.Name = "Correct"
					choice.UserDialog =  player_dialogs[math.random(1,player_negative_index-1)]
					
					customer.RightOrder.Value = choice
				else --wrong answer
	
					local random_customer_dialog = customer_dialogs[math.random(customer_negative_index,#customer_dialogs)]
					choice.ResponseDialog =  string.gsub(random_customer_dialog,"ordername", order_name)
					  
					choice.UserDialog =   player_dialogs[math.random(player_negative_index,#player_dialogs)]
					
				end
			end
		end
		--customer.Head.Dialog.DialogChoiceSelected:connect(function (player,dialog) talked(player,dialog,new_order,customer) end) 
		customer.Head.Dialog.InUse = true
		customer.Torso.Anchored = true
		
		customer.HumanoidRootPart.CFrame = CFrame.new(workspace.Entrance.Position + Vector3.new(0,2.5,0))
		customer.Humanoid.AutoRotate = false
		customer.Humanoid.WalkToPart = lane
		local cus = customer.Humanoid
		delay(.3,function() if cus ~= nil then cus:MoveTo(lane.Position,lane)   end end)
		
	
		
		
		customer.Humanoid.WalkToPoint = Vector3.new(0,0,0)
		
		--h:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
		
		h:ChangeState(Enum.HumanoidStateType.Running)
		
		delay(.1,function() 
			if customer and customer:FindFirstChild("Torso") then 
				customer.Torso.Anchored = false 
				h:ChangeState(Enum.HumanoidStateType.Running) 
			end 
		end)
		
		delay(240,function()   --customer waited too long
			delay(240,function()
				removeOrderFromCustomer(customer,lane)
			end)
			if customer ~= nil and customer:FindFirstChild("Humanoid") and customer:FindFirstChild("Head") and customer.Head:FindFirstChild("Dialog") and customer:FindFirstChild("Torso") and (customer.Humanoid.WalkToPart == workspace.Lane1 or customer.Humanoid.WalkToPart == workspace.Lane2) and not Dialogs[customer.Head].CurrentPlayer then
				
				local random_customer_dialog = customer_dialogs[math.random(customer_negative_index,#customer_dialogs)]
				chat_service:Chat(customer.Head,random_customer_dialog,0) --make customer say somthing negative
				
				orderCompleted(nil,customer,true)
				if customer:FindFirstChild("Head") ~= nil and customer.Head:FindFirstChild("Dialog") ~= nil then
					DestroyDialog(customer.Head)
				end
				
			end
			
		end)
		
		new_order.Object = customer
		
		
			
		table.insert(orders,new_order)
		
		--wait(math.random(1,spawn_rate))
	end
end






function moveHumanoid(humanoid,part)
	humanoid.WalkSpeed = 16
	humanoid.WalkToPart = part
	humanoid:MoveTo(part.Position,part)

	humanoid.WalkToPoint = Vector3.new(0,0,0)
	humanoid.AutoRotate = true
	if part ~= workspace.Entrance then
		delay(math.random(80,150),function()
			if humanoid ~= nil then 
				humanoid.WalkToPart = workspace.Entrance
				humanoid.WalkToPoint = Vector3.new(0,0,0)
				humanoid:MoveTo(workspace.Entrance.Position,workspace.Entrance)
				humanoid.Sit = false
				humanoid.Jump = true
				wait(1)
				local emote = math.random(1,4)
				if emote == 1 and humanoid ~= nil and humanoid.Parent ~= nil then
					humanoid.Parent.InvokeEmotion:Fire("Bye")
				end
				local human = humanoid.Parent
				delay(10,function()
					if human ~= nil then
						human:Destroy()
					end
				end)
			end
		end)
	end
end

--change obj to newobj

seating = workspace.Seating:GetChildren()
function seatCustomer(customer)
	for i=1,6 do
		local rand = math.random(1,#seating)
		if seating[rand].Seat:FindFirstChild("SeatWeld") == nil then
			moveHumanoid(customer.Humanoid,seating[rand].Seat)
			return
		end
	end
	for i,v in ipairs(seating) do
		if v.Seat:FindFirstChild("SeatWeld") == nil then
			moveHumanoid(customer.Humanoid,v.Seat)
			return
		end
	end
	moveHumanoid(customer.Humanoid,game.Workspace.Entrance)
	wait(1)
	local emote = math.random(1,4)
	if emote == 1 then
		customer.InvokeEmotion:Fire("Bye")
		
	end
end]]


num_orders_on_board = 0

function findPlayerHouse(player)
	for i,v in ipairs(houses) do
		if v:FindFirstChild(player.Name) then
			return v
		end
	end
end

--[[delay(0,function()
	while true do
		wait(15)

	end
end)]]

function orderCompleted(player,customer,failed_order)
	--[[if customer:IsA("Player") then
		order_submitted = true 
		
		local new_order = {}
		new_order.House = findPlayerHouse(player)
		new_order.Order = failed_order
		new_order.Phase = 2
		num_orders_on_board = num_orders_on_board + 1
		table.insert(orders,new_order)
		return
	end]]
	local customerData = Customers[customer]
	
	
	local order,order_index = findOrder("Object",customer,1)
	
	
	
	
	if order ~= nil then
		--[[delay(1.5,function()
			local lane = string.sub(order.Lane.Name,5)
			local register = workspace["Register" .. lane]
			register.ButtonCheese.SG.Frame.ImageLabel.ImageTransparency = .5
			register.ButtonPepperoni.SG.Frame.ImageLabel.ImageTransparency = .5
			register.ButtonSausage.SG.Frame.ImageLabel.ImageTransparency = .5
			register.ButtonMountainDew.SG.Frame.ImageLabel.ImageTransparency = .5
			
		end)]]
		
		
		
		--lanes_occupied[order.Lane] = nil
		
		--order.Lane = nil
		if not failed_order then
			SoundFX:PlaySoundInsideZone("Correct","Cashier")
			DestroyDialog(customer.Head)
			updateJobsCompleted(player,"Cashier")
			
			
			workspace.TutorialService.PlayerAction.PlayerAction:Fire(player,"PressedRegisterButton",true)

			customerData:OrderComplete(false)
			
			if num_orders_on_board < 18 then
		
				order.Object = game.Workspace.Orders
				order.Phase = 2
				refreshOrderBoard()
				 
				num_orders_on_board = num_orders_on_board + 1
			else
				table.remove(orders,order_index)
			end

		else
			SoundFX:PlaySoundInsideZone("Incorrect","Cashier")
			
			workspace.TutorialService.PlayerAction.PlayerAction:Fire(player,"PressedRegisterButton",false)

			customerData:OrderComplete(true)
			
			table.remove(orders,order_index)

			wait(1)
			
			pcall(function()
				DestroyDialog(customer.Head)
			end) 
			
			
		end
	end
end
	


GameService.OrderCompleted.OnServerEvent:connect(function(player, customer,failed_order)
	print("Ordercompete",failed_order)
	if customer == nil or customer:FindFirstChild("Head") == nil then print("CUSTOMER DOES NOT EXIST") return end
	--[[if failed_order then
		local random_customer_dialog = customer_dialogs[math.random(customer_negative_index,#customer_dialogs)]
		chat_service:Chat(customer.Head,random_customer_dialog,0)
	end]]
	orderCompleted(player,customer,failed_order)
	pcall(function() Dialogs[customer.Head]:DisabledDialog(false) end)
end)

chat_service = 	game:GetService("Chat")
--[[
phone_in_use=false
caller = nil
phone_picked_up_by=nil
order_submitted = false



function playersStillExist(player,player2)
	if player == nil or player2 == nil  then
		chat_service:Chat(phone.Head, "Player has left the game.")
		phone_in_use=false
		caller = nil
		phone_picked_up_by=nil
		order_submitted = false
		return false
	end
	return true
end]]

--[[
telephone_ringing = false
telephone = workspace.Phone
function ringTelephone()
	delay(0,function()
		telephone_ringing = true
		while telephone_ringing do
			wait(1)
			playSoundEffect("Telephone",game.ServerStorage.Ranges.Range1)
			local cframe =  telephone.HandlePhone.CFrame
			telephone.HandlePhone.Position = Vector3.new(telephone.Head.Position.x,telephone.Head.Position.y+1,telephone.Head.Position.z)
			for i=1,4 do
				wait(.13)
				telephone.HandlePhone.Rotation = Vector3.new(0,0,-10)
				wait(.13)
				telephone.HandlePhone.Rotation = Vector3.new(0,0,10)
			end
			telephone.HandlePhone.CFrame = cframe
		end
		
	end)
end
--delay(5,function() ringTelephone() end)

function resetPhone(connection,cframe)
	phone_in_use=false
	phone_picked_up_by=nil
	order_submitted = false
	caller =  nil
	telephone_ringing = false
	if cframe ~= nil then
		telephone.HandlePhone.CFrame = cframe
	end
	if connection ~= nil then
		connection:disconnect()
	end
end
function GameService.CallPizzaPlace.OnInvoke(player,phone)
	
	if caller == player then return end
	chat_service:Chat(phone.Head, "Calling the pizza place...")
	wait(1)
	if phone_in_use then
	chat_service:Chat(phone.Head, "Sorry, the line is busy right now.")
		return
	end
	caller =  player
	phone_in_use = true
	
	ringTelephone()
	
	--wait for cashier to pick up
	local timer = 0
	while not phone_picked_up_by and timer < 20 do
		wait(.5)
		chat_service:Chat(phone.Head, "Calling the pizza place...")
	end
	
	telephone_ringing = false
	
	if not playersStillExist(phone_picked_up_by,player) then resetPhone(nil,cframe)  return end
	
	
	
	if timer > 20 then
		chat_service:Chat(phone.Head, "No one answered the phone")
		resetPhone(nil,cframe)
		return
	end
	
	---cashier pick up
	
	local cframe =  telephone.HandlePhone.CFrame
	telephone.HandlePhone.Position = Vector3.new(telephone.Head.Position.x,telephone.Head.Position.y+1,telephone.Head.Position.z)
	
	
	chat_service:Chat(workspace.Phone.Head, phone_picked_up_by.Name  .. " is about to tell you what he/she wants to order.")

	
	local connection = player.Chatted:connect(function(msg,recipient) 
		chat_service:Chat(workspace.Phone.Head, msg)
	end)
	
	chat_service:Chat(phone.Head, phone_picked_up_by.Name .. " is on the line with you. Use chat to tell him/her what you would like.")

	
	--wait for cashier to put in order
	while not order_submitted do
		if not playersStillExist(phone_picked_up_by,player) then resetPhone(connection,cframe) end
	end
	
	
	if order_submitted then 
		chat_service:Chat(phone.Head, "Order complete. Your food will be here soon.")
		
		chat_service:Chat(workspace.Phone.Head, "Order complete")
	end
	
	script.Parent.LeaderboardService.UpdateJobsCompleted:Invoke(player,"Cashier")

	resetPhone(connection,cframe)
	
end



function GameService.PickUpPhone.OnServerInvoke(player)
	if phone_in_use then
		phone_picked_up_by = player
		return caller
	end
	return nil
end]]
function clearGuy(guy)
	--[[for i,v in ipairs(guy:GetChildren()) do
		if v:IsA("Accessory") or v:IsA("CharacterMesh") then
			v:Destroy()
		elseif v:IsA("Pants") then
			v.PantsTemplate = ""
		
		elseif  v:IsA("Shirt") then
			v.ShirtTemplate = ""
		end
	end]]
	for i,v in ipairs(guy:GetChildren()) do
		if v:IsA("Accessory") or v:IsA("Hat") or v:IsA("CharacterMesh") or v:IsA("Pants")  or v:IsA("Shirt") and v.Name ~="Uniform" then
			v:Destroy()
		end
	end
	if guy.Head:FindFirstChild("face") ~= nil then
		guy.Head.face:Destroy()
	end
end
function findGuyInHouse(house)
	for i,v in ipairs(house:GetChildren()) do
		if v:FindFirstChild("Player") ~= nil then
			clearGuy(v)
			return v
		end
	end
end



					--morinng       --miday      --afternoon          --night                 --chirstmas night
--[[local customer_rates = {["07:00:00"] = 24,["12:00:00"] =25 ,["07:50:00"] = 24,["15:00:00"] = 30,["21:00:00"] = 20,["11:59:00"] = 20}
delay(0,function() 
	 while true do
		local rate = customer_rates[game.Lighting.TimeOfDay]
		if rate ~= nil then
			if script.Parent.LeaderboardService.IsDoubleTime.Value then
				rate = rate / 2
			end
			wait(math.random(1,rate))
			math.randomseed(tick())
			math.random()
			if math.random(1,2) == 1 then
				spawnCustomer(workspace.Lane1)
			else
				spawnCustomer(workspace.Lane2)
			end
		end
	end
end)]]




----------Cook------------------------------------------------------------------------------------------------------------------------------------------------------


function refreshOrderBoard()
	if refreshLock then return end
	local index = 1
	for i,v in pairs(orders) do
		if v.Phase == 2 then
			board_objects[index].SG.ImageLabel.Image = order_board_decals[v.Order]
			index = index + 1
			if index == 19 then return end
		end
	end
	for i=index,#board_objects do
		board_objects[i].SG.ImageLabel.Image = ""
	end
end

all_draggers = workspace.Draggers:GetChildren()
draggers = {}
for i,v in ipairs(all_draggers) do
	draggers[i] = v
end

--[[function GameService.RequestDragger.OnServerInvoke()
	local d = draggers[1]
	draggers[#draggers+1] = draggers[1]
	table.remove(draggers,1)
	delay(10, function() d.Position = Vector3.new(0,1000,0) end)
	return d
end]]





--cheese, pepperoni, sausage, tomatosauce, cooked
local dough_data = {}
local box_data = {}







function smoke(obj)
	obj.Anchored = true
	local p = Instance.new("Part")
	p.FormFactor = "Custom"
	p.Size = Vector3.new(.1,.1,.1)
	p.Transparency = 1
	p.CanCollide = false
	p.Anchored = true
	p.Locked = true
	p.Parent = game.Workspace
	p.CFrame = CFrame.new(Vector3.new(obj.Position.x,obj.Position.y,obj.Position.z))
	local s  = Instance.new("Smoke")
	s.Color = obj.BrickColor.Color
	s.RiseVelocity = 1
	s.Parent = p
	game:GetService("Debris"):AddItem(p,10)
	delay(1,function() 
		if obj ~= nil and obj.Parent ~= nil then
			changeSupply(string.sub(obj.Parent.Name,4),1)
			obj:Destroy() 
			
			s.Enabled = false
			wait(4)
			 p:Destroy() 
		end
	end)
end

--[[function smokeSupplyBox(obj)
	--obj.Anchored = true
	obj.Locked = true
	local p = Instance.new("Part")
	p.FormFactor = "Custom"
	p.Size = Vector3.new(.1,.1,.1)
	p.Transparency = 1
	p.CanCollide = false
	p.Anchored = true
	p.Locked = true
	p.Parent = game.Workspace
	p.CFrame = CFrame.new(Vector3.new(obj.Position.x,obj.Position.y,obj.Position.z))
	local s  = Instance.new("Smoke")
	s.Color = obj.BrickColor.Color
	s.RiseVelocity = 1
	s.Parent = p
	delay(.3,function() 
		if obj ~= nil then
			
			
			s.Enabled = false
			wait(4)
			 p:Destroy() 
		end
	end)
end]]

function wrongOrder(obj,checker)
	local x = game.ServerStorage.XBillboard:clone()
	x.Parent = obj
	x.Adornee = obj
	if checker == "PizzaChecker" then
		
			obj.Velocity = Vector3.new(-100,obj.Velocity.y,obj.Velocity.z)
		
		workspace.PizzaConvayor.Velocity = Vector3.new(-10,0,0)
		wait(.4)
		workspace.PizzaConvayor.Velocity = Vector3.new(0.01,0,0)
		wait(1)
		workspace.PizzaConvayor.Velocity = Vector3.new(10,0,0)
	end
	smoke(obj)
end




refresh_lock = true
last_hit = nil

order_checker_debounce = false
function orderCheckerTouched(hit)
	
	
	local function changeIngredientSupply(amount,toppings,hit)
		if hit.Name == "Dough" then
			if toppings:FindFirstChild("MeltedCheese") or toppings:FindFirstChild("Cheese") then
				changeSupply("Cheese",amount)
			end
			if toppings:FindFirstChild("TomatoSauce") then
				changeSupply("TomatoSauce",amount)
			end
			if toppings:FindFirstChild("Sausage") then
				changeSupply("Sausage",amount)
			end
			if toppings:FindFirstChild("Pepperoni") then
				changeSupply("Pepperoni",amount)
			end
		elseif hit.Name == "MountainDew" then
			changeSupply("MountainDew",amount)
		end
	end
	
	
	 if not order_checker_debounce and hit ~= nil and hit.Parent ~= nil and last_hit ~= hit and not hit.Parent:FindFirstChild("Humanoid") then
		order_checker_debounce = true
		delay(.3,function() order_checker_debounce = false end)
		last_hit = hit
		local toppings = nil
		if hit.Name == "Dough" then
			toppings = hit.SG.Frame
		else--if mountain dew
			toppings = hit
		end
		if (hit.Name == "Dough" and toppings:FindFirstChild("MeltedCheese") and toppings:FindFirstChild("TomatoSauce")) or hit.Name == "MountainDew" then
			
			local pepperoni = toppings:FindFirstChild("Pepperoni")
			local sausage = toppings:FindFirstChild("Sausage")
			
			if not pepperoni and not sausage and hit.Name ~= "MountainDew" then
				order_type = 1
			elseif pepperoni and not sausage then
				order_type = 2
			elseif not pepperoni and sausage then
				order_type = 3
			elseif hit.Name == "MountainDew" then
				order_type = 4
			end
			local order,order_index = findOrder("Order",order_type,2)
			if order ~= nil then
				changeIngredientSupply(-1,toppings,hit)
				updateJobsCompleted(hit.LastDragger.Value,"Cook")

				refreshLock = true  --stop order board from refreshing
				if hit.Name == "Dough" then  --move to boxing model
					hit.Name = "Pizza"
					hit.Parent = workspace.BoxingRoom
				else
					hit.Name = "Dew"
					hit.Parent = workspace.BoxingRoom
					delay(1,function () hit.Size = Vector3.new(2,1.2,2) end)
				end
				num_orders_on_board = num_orders_on_board - 1

				SoundFX:PlaySoundInsideZone("Correct","Cook")

				local order_image = order_board_decals[order.Order]
				local img = nil
				for i,v in ipairs(board_objects) do--find anything that matches on order board and show check mark
					if v.SG.ImageLabel.Image == order_image then
						img = v.SG.ImageLabel
						v.SG.ImageLabel.Image = "http://www.roblox.com/asset/?id=168401336"
						v.Sparkles.Enabled = true
						break
					end
				end
				order.Phase = 3
				order.Object = hit
				wait(2)
				if img ~= nil then --remove the check mark
					img.Image = ""
					img.Parent.Parent.Sparkles.Enabled = false
				end
				refreshLock = false
				refreshOrderBoard()
				last_hit = nil
				return
			end
		end
		
		
		SoundFX:PlaySoundInsideZone("Incorrect","Cook")

		game:GetService("Debris"):AddItem(hit,30)
		
		local x = game.ServerStorage.XBillboard:clone()
		x.Parent = hit
		x.Adornee = hit
			
		hit.Velocity = Vector3.new(-100,hit.Velocity.y,hit.Velocity.z)
			
		workspace.PizzaConvayor.Velocity = Vector3.new(-10,0,0)
		wait(.4)
		workspace.PizzaConvayor.Velocity = Vector3.new(0.01,0,0)
		wait(1)
		workspace.PizzaConvayor.Velocity = Vector3.new(10,0,0)
		x:Destroy()
		smoke(hit)
		
	end
	
end
workspace.Hole.Touched:connect(orderCheckerTouched)

ovenCountDown = 0
isOn = false
function turnOnOven()
	ovenCountDown = 20
	if not isOn then
		isOn = true
		delay(0,function()
			workspace.OvenLight.PointLight.Enabled = true
			while ovenCountDown ~= 0 do
				wait(1)
				ovenCountDown = ovenCountDown - 1
			end
			isOn = false
			workspace.OvenLight.PointLight.Enabled = false
			
		end)
	end
end

--oven code
cookBounce = false
function cookPizza(hit)
	if not cookBounce and hit ~= nil and hit.Parent ~= nil and hit:FindFirstChild("Fire") == nil then
		SoundFX:PlaySoundInsideZone("CookPizza","Cook")
		cookBounce = true
		delay(.1,function() cookBounce = false end)
		turnOnOven()
		if hit:FindFirstChild("BeingCooked") and hit.BeingCooked.Value == false and hit.BrickColor == BrickColor.new("Brick yellow") then
		
			hit.BeingCooked.Value = true
			hit.Steam.Enabled = true
			delay(5,function()
				if hit and hit.Parent and hit:FindFirstChild("Steam") then
					hit.Steam.Enabled = false
				end
			end)
			
			--[[local fire  = Instance.new("Fire")
			fire.Parent = hit
			game:GetService("Debris"):AddItem(fire,10)]]
			

			wait(math.random(5,8)/10)
			if hit:FindFirstChild("SG") ~= nil and hit.SG.Frame:FindFirstChild("Cheese") then
				hit.SG.Frame.Cheese.Image = "http://www.roblox.com/asset/?id=167850823"
				hit.SG.Frame.Cheese.Name = "MeltedCheese"
			end
			wait(math.random(5,8)/10)		
			hit.BrickColor = BrickColor.new(106)
			wait(math.random(5,8)/10)
			local cframe = hit.CFrame
			hit.Size = Vector3.new(5,.4,5)
			hit.CFrame = cframe + Vector3.new(0,.1,0)
			if hit:FindFirstChild("BeingCooked") then
				hit.BeingCooked.Value = false
			end
			
		elseif hit:FindFirstChild("Fire") == nil and hit:FindFirstChild("BeingCooked") == nil then
			local fire  = Instance.new("Fire")
			fire.Parent = hit
			game:GetService("Debris"):AddItem(fire,10)
			wait(1)
			hit.BrickColor = BrickColor.new(1003)
			if hit:FindFirstChild("Mesh") ~= nil then
				hit.Mesh.VertexColor = Vector3.new(0,0,0)
			end
			wait(2)
			smoke(hit)

		end
	end
end
workspace.CookPizza.Touched:connect(cookPizza)





--------------------------------Boxer------------------------------------------------------------------------------------------------------------------------

local box_debounce = {}
GameService.CloseBox.OnServerEvent:connect(function(player,box) 
	if box == nil then return end
	if box_debounce[box] ~= nil then return end
	box_debounce[box] = true
	
	local closedBox = game.ServerStorage.Supplies.BoxClosed:clone()
	
	closedBox.LastDrag.Value = workspace.DistributedGameTime

	closedBox.Parent = workspace.AllBox
	closedBox.CFrame = box.CFrame - Vector3.new(0,2,0)
	
	if box:FindFirstChild("Tutorial") then
		box.Tutorial.Parent = closedBox
	end
	
	SoundFX:PlaySoundInsideZone("BoxClose","Boxer")

	if box:FindFirstChild("PizzaWeld") ~= nil then
		
		local pizza = box.PizzaWeld.Part1
				
		if pizza ~= nil then
			local order,order_index = findOrder("Object",pizza,3)
			
			if order ~= nil then
				order.Object = closedBox
				order.Phase = 4
				closedBox.Decal.Transparency = 0
				
				
			end
			pizza:Destroy()
		end
	else
		local x = game.ServerStorage.XBillboard:clone()
		x.Parent = closedBox
		x.Adornee = closedBox
		box:Destroy()
		wait(1)
		smoke(closedBox)
	end
	if box ~= nil then
		box:Destroy()
	end
	workspace.TutorialService.BoxClosed:Fire(player,box,closedBox)
end)

box_positions = {
	Vector3.new(69.8, 4, -6.5),
	Vector3.new(65.2, 4, -6.5),
	Vector3.new(60.6, 4, -6.5),
	Vector3.new(69.8, 4, -11.1),
	Vector3.new(65.2, 4, -11.1),
	Vector3.new(60.6, 4, -11.1)
}

dew_positions = {
	Vector3.new(57.8, 3.7, -12.9),Vector3.new(57.8, 3.7, -11.7),Vector3.new(57.8, 3.7, -11.1),
	Vector3.new(57.8, 3.7, -10.5),Vector3.new(57.8, 3.7, -9.9),Vector3.new(57.8, 3.7, -9.3),
	Vector3.new(57.8, 3.7, -8.7),Vector3.new(57.8, 3.7, -8.1),Vector3.new(57.8, 3.7, -7.5),
	Vector3.new(57.8, 3.7, -6.9),Vector3.new(57.8, 3.7, -6.3),Vector3.new(57.8, 3.7, -5.7),
	Vector3.new(57.8, 3.7, -5.1),Vector3.new(57.8, 3.7, -4.5)
}

house_numbers_decals = {
	A1 = "http://www.roblox.com/asset/?id=168771465",
	A2 = "http://www.roblox.com/asset/?id=168772610",
	A3 = "http://www.roblox.com/asset/?id=168772626",
	B1 = "http://www.roblox.com/asset/?id=168772634",
	B2 = "http://www.roblox.com/asset/?id=168772640",
	B3 = "http://www.roblox.com/asset/?id=168772648",
	B4 = "http://www.roblox.com/asset/?id=168772663",
	B5 = "http://www.roblox.com/asset/?id=168772676",
	B6 = "http://www.roblox.com/asset/?id=168772694",
	C1 = "http://www.roblox.com/asset/?id=168772702",
	C2 = "http://www.roblox.com/asset/?id=168772707",
	C3 = "http://www.roblox.com/asset/?id=168772718"
}
box_check_bounce = false
check_mark_bounce = false



function processBoxDew(hit,phase,toolname,positions)
	local order,order_index = findOrder("Object",hit,phase)
	if order ~= nil then
		SoundFX:PlaySoundInsideZone("Correct","Boxer")
		updateJobsCompleted(hit.LastDragger.Value,"Pizza Boxer")

		local tool = game.ServerStorage.Supplies[toolname]:clone()
		tool.Parent = workspace
		tool.Handle.Locked = false
		tool.Handle.Position = positions[math.random(1,#positions )]
		tool.Handle.Rotation = Vector3.new(0,0,0)
		tool.Order.Value = order.Order
		game:GetService("Debris"):AddItem(tool,3600)
		local equip = nil
		equip = tool.Equipped:connect(function() 
			if tool and tool:FindFirstChild("Handle") then 
				tool.Handle.Locked = true 
			end 
			equip:disconnect()
		end)
		
		if order.House then
			tool.House.Value = order.House
			tool.BringToHouse.Text = "Bring to house " .. order.House.Address.Value
			tool.TextureId = order.House and house_numbers_decals[order.House.Address.Value]
			
		else --if player's pizza
			tool.Name = "Pizza"
			tool.PlayerCustomer.Value = order.Customer
			tool.CanBeDropped = false
			tool.BringToHouse.Text = "Deliver to " .. order.Customer.Name
			tool.TextureId = order_board_decals[order.Order]
			local connection = nil
			connection = tool.Handle.Touched:connect(function(hit) PizzaTouched(hit,tool,connection) end)
		end
		order.Object = tool
		order.Phase = 5
		--
		hit:Destroy()
		if not workspace.CheckMark.SG.Enabled then
			workspace.CheckMark.SG.Enabled = true
			workspace.CheckMark.Sparkles.Enabled = true
			delay(2,function() workspace.CheckMark.SG.Enabled = false workspace.CheckMark.Sparkles.Enabled = false end)
		end
				
		return true
	end

	return false
end
last_touch = nil
function checkBox(hit)
	if hit ~= last_touch and hit ~= nil and hit.Parent ~= nil and not hit.Parent:FindFirstChild("Humanoid") and not hit.Parent.Parent:FindFirstChild("Humanoid") then
		--box_check_bounce = true
		last_touch = hit
		if hit.Name == "BoxClosed" then
			if processBoxDew(hit,4,"PizzaTool",box_positions) then
				return
			else
				changeSupply(string.sub(hit.Parent.Name,4),1)
			end
		elseif hit.Name == "Dew" then
			if processBoxDew(hit,3,"DewTool",dew_positions) then
				return
			end
		elseif hit.Parent.Name == "DewTool" or  hit.Parent.Name == "PizzaTool" then
			return
		end
		
		SoundFX:PlaySoundInsideZone("Incorrect","Boxer")
		local x = game.ServerStorage.XBillboard:clone()
		x.Parent = hit
		x.Adornee = hit
		
		game:GetService("Debris"):AddItem(hit,30)
			
		hit.Velocity = Vector3.new(hit.Velocity.x,hit.Velocity.y,100)
			
		workspace.BoxBelt.Velocity = Vector3.new(0,0,10)
		wait(.6)
		
		workspace.BoxBelt.Velocity = Vector3.new(0,0,0.1)
		wait(1)
		workspace.BoxBelt.Velocity = Vector3.new(0,0,-10)
		if hit.Name == "Pizza" then
			local b = Instance.new("BodyPosition")
			b.position = Vector3.new(59.401, 6.7, 31.1)
			b.Parent = hit
			wait(1)
			
			b:Destroy()
		elseif hit.Name == "BoxClosed" or hit:IsA("Accessory") or hit:IsA("Hat") or hit.Name == "MountainDew" or hit.Name == "Dough"  then

			smoke(hit)	
		end
		x:Destroy()
	end
end

game.Workspace.BoxChecker.Touched:connect(checkBox)



----------------------------DElivery----------------------



total_deliveries = 0
BONUS_AMOUNT = 100  --reward moneyz
BONUS_MULTIPLE = 50 --round to the nearst
all_pizzas = {}
debounce= {}



function DeliveryComplete(tool)
	local order,order_index = findOrder("Object",tool,5)
	if order ~= nil then
		table.remove(orders,order_index)
	end
end


right_dialogs = {
	"Thanks!",
	"Have a good day!",
	"See ya!",
	"Yay pizza!",
	"Alright! The pizza is here!",
	"Thanks! Sorry that I don't have money for a tip.",
	"Woah thank you! That's some fast delivery!",
	"You did good",
	"Nice job. You got over here fast!",
	"See ya later pizza person",
	"Why thank you!",
	"Wow! Thanks a lot!",
	"Wow! That was fast!",
	"OMG, I'm starving!",
	"Yay it's here!",
	"OMG food!",
	"This looks delicious! Thank you.",
	"I am going to devour this.",
}

wrong_dialogs = {
	"I didn't order any pizza.",
	"Wrong house",
	"I didn't order anything!",
	"Sorry, you have the wrong house.",
	"No one here ordered pizza.",
	"I don't think we ordered pizza.",
	"You have the wrong house.",
	"You woke me up....I didn't order pizza...",
	"I didn't order this but I'll eat it.",
}

--when you give pizza to guy
function givePizza(hit,house,givepizza,guy)
	
	
	
	-- house = upgrdae house not upgrade container

	if not debounce[guy] and hit ~= nil and hit.Parent ~= nil and hit.Parent:FindFirstChild("Humanoid") ~= nil then
		debounce[guy] = true
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if player == nil or Players[player] == nil then debounce[guy] = false return end
		local playerData = Players[player]
		
		local houseData = Houses[house]
		local frontDoor = houseData.FrontDoor
		
				
		local tool = check(hit)
		if tool ~= nil and (tool.Name == "PizzaTool" or tool.Name == "DewTool") and tool.PlayerCustomer.Value == nil then
			
			
			if playerData.Job ~= "Delivery" then
				if playerData.Job == "Manager" then
					Manager:FireManager()
				else
					playerData:SetJob("Delivery")
				end
			end
			
			--make sure at right house
			local right_house = false
			local order,order_index = findOrder("Object",tool,5)
			if order ~= nil and order.House == house then
				right_house = true
			end

			
			local character = hit.Parent
			character.Humanoid.WalkSpeed = 0
			--copyCharacterOfPlayer(owner,guy)
			workspace.GameService.ChangeCamera:FireClient(player,givepizza,houseData.Inverted)
			SoundFX:PlaySound(player,"Doorbell")
			--wait(1)
			--ding dong sounds
			frontDoor:SetDoorbellEnabled(false)		
			
			wait(math.random(13,25)/10)
			
			guy.Parent = house
		
			guy.HumanoidRootPart.CFrame = (givepizza.CFrame *CFrame.Angles(0, math.pi, 0)) + ((givepizza.CFrame.lookVector.unit *5)  + Vector3.new(0,2.5,0))--CFrame.new(Vector
			
			local originalState = frontDoor.IsOpen
			if not frontDoor.IsOpen then
				frontDoor:SetState(true,true)
			end
			
			
			
			if right_house then
				if guy.HumanoidRootPart:FindFirstChild("Right Shoulder") then
					guy.Torso["Right Shoulder"].DesiredAngle = 1.6
				end
				wait(.5)
				if tool ~= nil and tool.Parent ~= nil then
					tool.Parent = guy
				end
			end

			local dialog = nil
			if right_house then
				dialog = right_dialogs[math.random(1,#right_dialogs)]
			else
				dialog = wrong_dialogs[math.random(1,#wrong_dialogs)]
				SoundFX:PlaySound(player,"Incorrect")
			end
			--
			game:GetService("Chat"):Chat(guy.Torso,dialog,0)
			
		--	wait(12000)
			character.Humanoid.WalkSpeed = 16
			
			
			if right_house then
				if tool ~= nil and tool.Parent ~= nil then
					DeliveryComplete(tool)
					workspace.TutorialService.PlayerAction.PlayerAction:Fire(player,"DeliveredPizza",true)
				end
				
				total_deliveries = total_deliveries + 1
				delivery_rate = delivery_rate + 1
				
				workspace.TotalDeliveries.Counter.SG.Counter.Text = tostring(total_deliveries)
				workspace.Tada:Play()
	
	
				
				--give everybody moneyz
				--local bonus = 0
				--if round(total_deliveries,BONUS_MULTIPLE) == total_deliveries then
					--bonus = (pizza_price * multiplier) * 10--100 + (10 - pizza_price) * 10
					--Dialog:ShowMessage("Total Deliveries has reached " .. total_deliveries .. " pizzas! Everybody gets a " .. bonus .. " Moneyz bonus!")
				--else
				--	game.workspace.Main.DeliveryMade:FireAllClients()
	
				--end
				for _,player in ipairs(game.Players:GetPlayers()) do
					if Players[player] ~= nil and player.TeamColor ~= BrickColor.new(194) then
						--dont give money to managers inside houses
						if player.TeamColor == BrickColor.new("Bright green") and Players[player].LocationHouse ~= nil then  
						
						else
							Players[player]["Paycheck"] = Players[player]["Paycheck"] + (pizza_price * multiplier) 
						end
						--[[players[player]["HatProgress"] = players[player]["HatProgress"] + 1
						if players[player]["HatProgress"] == 30 then
							game:GetService("BadgeService"):AwardBadge(player.userId, 290718583)

							workspace.MessageService.Dialog:InvokeClient(player,"You earned the pizza hat! Put the hat on your Roblox character from the website.", "OMG YES!!!","") 
						end]]
						
							
							
							
							
			
					end
				end
				
				
				wait(3)
				if tool ~= nil and tool.Parent ~= nil then
					tool:Destroy()
				end
			else
				wait(3)
			end
			workspace.GameService.ChangeCamera:FireClient(player,nil)
			
			--close if originaly closed
			if not originalState then
				frontDoor:SetState(false,false)
			end
			
			if guy.Torso:FindFirstChild("Right Shoulder") then
				guy.Torso["Right Shoulder"].CurrentAngle = 0
			end
			
			guy.Torso.CFrame = CFrame.new(Vector3.new(0,10000+math.random(1,1000),0))
			
			updateJobsCompleted(player,"Delivery")
			frontDoor:SetDoorbellEnabled(true)			
			
			if guy.Torso:FindFirstChild("Right Shoulder") then
				guy.Torso["Right Shoulder"].DesiredAngle = 0
			end
		
			
			
			
		end
		wait(2)
		debounce[guy] = false
	end
	
end

workspace.Main.GivePizzaTouched.Event:connect(givePizza)



--pizza given to player
local debounces = {}
function PizzaTouched(hit,tool,connection)
	if hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") and not debounces[hit.Parent] then
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if player and player:FindFirstChild("Backpack") and tool:FindFirstChild("PlayerCustomer") and tool.PlayerCustomer.Value == player and tool.Parent ~= player.Character then
			
			debounces[hit.Parent] = true

			local playerGiver = game.Players:GetPlayerFromCharacter(tool.Parent)
			
			tool.Parent = player.Backpack
			
			delay(.2,function()
				player.Character.Humanoid:EquipTool(tool)
				debounces[hit.Parent] = nil
			end)

			DeliveryComplete(tool)
			workspace.TutorialService.PlayerAction.PlayerAction:Fire(playerGiver,"DeliveredPizza",true)
	
			game.Workspace.Tada:Play()
			--game.Workspace.Main.DeliveryMade:FireAllClients()
			
			
			for _,play in ipairs(game.Players:GetPlayers()) do
				if play ~= player and Players[play] ~= nil and play.TeamColor ~= BrickColor.new(194) then
					if play:FindFirstChild("leaderstats") ~= nil and play.leaderstats:FindFirstChild("Moneyz") ~= nil  then
									
						Players[play]["Paycheck"] = Players[play]["Paycheck"]  + 10 
						play.leaderstats.Moneyz.Value = Players[play]["Moneyz"]
									
					end
				end
			end
			
			connection:disconnect()
		end
	end
end




function GameService.GetOrderFromObject.OnServerInvoke(player,object,phase)
	if Players[player] and Players[player]["Jobs_Completed"]["Delivery"] > 20 then return nil end
	local order,order_index = findOrder("Object",object,phase)
	if order ~= nil then
		return order
	else 
		return nil
	end
end




------------------------------------------------------------------Supplier--------------------------------------------------------------
--colors = 21 = red,23 = blue,24 = yellow, 208 = white,28 = dark green,5= brick yellow, 38 = brown
colors = {21,23,24,208,28,5,38}
supplies = {TomatoSauce = 20, Cheese = 20, Pepperoni = 20, Sausage = 20, MountainDew = 20, Dough = 20, Box = 20}
color_to_ingredient = {[21] = "TomatoSauce", [23] = "Pepperoni", [24] = "Cheese", [208] = "Box", [28] = "MountainDew", [5] = "Dough", [38] = "Sausage" }
local counters = workspace.SupplyCounters:GetChildren()

 --for tutorial. Keep supply above 5 durring tutorial until player switches jobs
workspace.TutorialService.NeverEndingSupply.Event:connect(function(name,jobIndex,player)
	while player and player.Parent and Players[player]["CurrentJob"] == jobIndex and player do 
		if supplies[name] < 5 then
			supplies[name] = 5
			refreshCounters()
		end
		wait(10)
	end
end)

--flash counters red when 0
for i,v in ipairs(counters) do
	delay(0,function()
		local counter = v.a.SG.Counter
		local counter_text_color = v.a.SG.Counter.TextColor3
		while true do 
			wait(5)
			if tonumber(counter.Text) == 0 then
				while tonumber(counter.Text) == 0 do
					wait(1)
					counter.TextColor3 = Color3.new(1,0,0)
					wait(1)
					counter.TextColor3 = counter_text_color
				end
				counter.TextColor3 = counter_text_color
			end
		end
	end)
	
end

for i,v in ipairs(workspace.SupplyButtons:GetChildren()) do
	v.Unpressed.Touched:connect(function(hit) supplyButtonTouched(hit,v) end)
end


function supplyNotZero(type)
	if supplies[type] > 0  then 
		return true
	else
		return false
	end
end
function changeSupply(type,amount)
	if supplies[type] ~= nil then
		supplies[type] = supplies[type] + amount
		if supplies[type] < 0 then supplies[type] = 0 return end
		refreshCounters()
		
	end
end


function supplyButtonTouched(hit,button)
	if button.Unpressed.CanCollide and hit ~= nil and hit.Parent ~= nil and hit.Parent:FindFirstChild("Humanoid") then
		
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if player then
			workspace.TutorialService.PlayerAction.PlayerAction:Fire(player,"SupplyButtonPressed",true)
			SoundFX:PlaySoundInsideZone("ButtonPress","Supplier2",button.Unpressed)
			
			if #workspace.AllSupplyBoxes:GetChildren() < 75 then
				
				local playerData = Players[player]
				if playerData and playerData.Job ~= "Supplier" then
					if playerData.Job == "Manager" then
						Manager:FireManager()
					else
						playerData:SetJob("Supplier")
					end
				end
				
				button.Unpressed.CanCollide = false
				button.Unpressed.Transparency = 1
				
				delay(1,function() 
					local newbox = game.ServerStorage.Supplies.SupplyBox:clone()
					newbox.Locked = false
					newbox.BrickColor = button.Unpressed.BrickColor
					newbox.Parent = workspace.AllSupplyBoxes
					newbox.LastDrag.Value =  workspace.DistributedGameTime
					newbox.CFrame = newbox.CFrame + Vector3.new(math.random(-82,82)/10,0,0)
					button.Unpressed.CanCollide = true
					button.Unpressed.Transparency = 0
				end)
	
			end
		end
	end
end



function getIngreidentPlateByName(name)
	for _,ingredient in ipairs(workspace.Ingredients:GetChildren()) do
		if ingredient.Name == name and ingredient:FindFirstChild("Plate") then
			return ingredient
		end
	end
end
	
function refreshCounters()

	for i,v in ipairs(counters) do
		if supplies[string.sub(v.Name,8)] > 99 then
			supplies[string.sub(v.Name,8)] = 99
		end
		v.a.SG.Counter.Text = tostring(supplies[string.sub(v.Name,8)])
	end
	for ing,supply in pairs(supplies) do
		local ing_plate = getIngreidentPlateByName(ing)
		if ing_plate ~= nil then
			if supply > 0 then
				ing_plate.Transparency = 0
				ing_plate.CanCollide = true
				ing_plate.Locked = false
				ing_plate.SG.ImageLabel.Visible = true
			else
				ing_plate.Transparency = 1
				ing_plate.CanCollide = false
				ing_plate.Locked = true
				ing_plate.SG.ImageLabel.Visible = false
			end
		end
	end
end


local supply_particles = {}
local particle_index = 1
MAX_PARTICLES = 15
for i=1,MAX_PARTICLES do
	local p = game.ServerStorage.SupplyParticle:clone()
	table.insert(supply_particles,p)
end
last_hit = nil
--when a supply boxs goes under the tube
function processSupplyBox(hit)
	if hit ~= nil and hit.Parent ~= nil and hit ~= last_hit and hit.Name == "SupplyBox" then
		last_hit = hit
		updateJobsCompleted(hit.LastDragger.Value,"Supplier")
		local ingredient = color_to_ingredient[hit.BrickColor.Number]
		local amount = math.random(4,5)
		-- smokeSupplyBox(hit)
		hit.Locked = true
		for i=1,amount do
			wait(math.random(3,6)/10)
			local current = supply_particles[particle_index]
			if current.Parent == nil then
				supply_particles[particle_index] = game.ServerStorage.SupplyParticle:clone()
				current = supply_particles[particle_index]
			end
			current.BrickColor = hit.BrickColor
			current.Parent = workspace.SupplyParticles
			current.CFrame  = hit.CFrame + Vector3.new(math.random(-15,15)/10,1,math.random(-15,15)/10)
			delay(2,function()
				if current.Parent ~= nil then
					particleHit(current)
				end
			end)
			pcall(function() current.SG.ImageLabel.Image= Enums.IngredientImages[ingredient] end)
			particle_index = particle_index + 1
			if particle_index > MAX_PARTICLES then
				particle_index = 1
			end
		end
		
		hit:Destroy()
		last_hit = nil
		
	end
end
workspace.SupplyLift.Touched:connect(processSupplyBox)

--when a supply hits the roof
function particleHit(hit)
	if hit ~= nil and hit.Parent ~= nil and hit.Parent == workspace.SupplyParticles then
		SoundFX:PlaySoundInsideZone("Pop2","Supplier1")
		local ingredient = color_to_ingredient[hit.BrickColor.Number]
		if supplies[ingredient] then
			supplies[ingredient] = supplies[ingredient] + 1
			hit.Parent = workspace.RemovingParticles
			refreshCounters()
			hit.Parent = nil
		else
			hit:Destroy()
		end
	end
end
--workspace.Tube.Collector.Touched:connect(particleHit)








--------------------------------------------------------Ingriedient resupply--------------------------------------


EXPIRE_TIME = 300

function checkExpired(group)
	for i,v in ipairs(group:GetChildren()) do
		if not v:IsA("StringValue") and v:FindFirstChild("LastDrag") and (workspace.DistributedGameTime - v.LastDrag.Value) > EXPIRE_TIME then
			if group ~= workspace.AllSupplyBoxes then
				changeSupply(string.sub(group.Name,4),1)
			end
			if group == workspace.AllBox then
				box_debounce[v] = nil
			end
			
			v:Destroy()
		end
	end
end




delay(0,function()
	while true do
		wait(15)
		checkExpired(workspace.AllDough)
		checkExpired(workspace.AllMountainDew)
		checkExpired(workspace.AllBox)
		checkExpired(workspace.AllSupplyBoxes)
	end
end)

--check to see if there is enough of each supply object in the game
delay(0,function()
	while true do
		wait(3)
		
		if #workspace.AllDough:GetChildren() < 6 and supplyNotZero("Dough") then 
			changeSupply("Dough",-1)
			local dough = game.ServerStorage.Supplies.Dough:clone()	
			dough.Locked = false		
			dough.LastDrag.Value = workspace.DistributedGameTime
			dough.Parent = workspace.AllDough
			workspace.DoughDoor.Transparency = 1
			delay(2,function() workspace.DoughDoor.Transparency = 0 end) 
		end
		
		if #workspace.AllMountainDew:GetChildren() < 11 and supplyNotZero("MountainDew") then 
			changeSupply("MountainDew",-1)
			local dew = game.ServerStorage.Supplies.MountainDew:clone()
			dew.Locked = false
			dew.Parent = workspace.AllMountainDew 
			if math.random(1,2) == 1 then
				dew.CFrame  = game.Workspace.DewPos1.CFrame + Vector3.new(math.random(-20,20)/10,0,0)
			else
				dew.CFrame  = game.Workspace.DewPos2.CFrame + Vector3.new(math.random(-20,20)/10,0,0)
			end
			--dew.BodyGyro.cframe = dew.CFrame
		--	dew.Velocity = Vector3.new(math.random(-1,1),math.random(-1,1),math.random(-1,1))
			dew.LastDrag.Value = workspace.DistributedGameTime
		end
	
		if #workspace.AllBox:GetChildren() < 5 and supplyNotZero("Box") then 
			
			changeSupply("Box",-1)
			local boxes = game.ServerStorage.Supplies.Box:clone()
			boxes.Locked = false
			boxes.LastDrag.Value = workspace.DistributedGameTime
			boxes.Parent = workspace.AllBox
			workspace.BoxDoor.Transparency = 1
			delay(2,function() workspace.BoxDoor.Transparency = 0 end)
			-- wait(1)
		--	boxes.Base.CFrame = game.Workspace.BoxOpenz.CFrame--boxes.Base.CFrame  + Vector3.new(0,3,0)
		end

	end
end)




--[[
delay(12,function()
	
GameService.GivePaycheck:FireClient(game.Players.Player1,155)
wait(20)
GameService.GivePaycheck:FireClient(game.Players.Player1,155)
end)

]]


---------------------------------------------------------------MISC-----------------------------------------------

--workspace.Customers.ChildAdded:connect(function(obj) wait(.5) GameService.RefreshAllChatboxes:FireAllClients() end)

team_colors = {[21] = "Cashier", [24] = "Cook", [23] = "Delivery", [37] = "Manager", [194] = "On Break", [106] = "Pizza Boxer",[1] = "Supplier"}
--range1 = Doorbell, range2 = cashier, range3 = cook, range 4 = boxer, range5 = supply room, range6 = supply buttons



--if an order's object has been removed from workspace
delay(0,function()
	while true do
		wait(10)
		for i=1,#orders do
			if orders[i] ~= nil and (orders[i]["Object"] == nil or orders[i]["Object"].Parent == nil) then
				print("removed order")
				table.remove(orders,i)
			end
		end
	end
end)








------Filtering---------------------------------------------------------------------------------------------------------------

workspace.GameService.DropTool.OnServerEvent:connect(function(player,tool)
	if tool and tool.Parent then
		tool.Parent = workspace
	end
end)

workspace.GameService.AddPizzaToBackpack.OnServerEvent:connect(function(player,tool)
	if tool and tool.Parent and player:FindFirstChild("Backpack") then
		tool.Parent = player.Backpack
		player.Character.Humanoid:EquipTool(tool)
	end
end)

workspace.GameService.PutInBox.OnServerEvent:connect(function(player,pizza,box,size)
	if pizza and box then
		pizza.Size = size
		pizza.CFrame = box.CFrame - Vector3.new(0,2,0)--box.CFrame * CFrame.Angles(0,0,math.pi/2) - Vector3.new(0,2,0)
		Weld(box,pizza)
	end
end)


local timeoutCounters = {}
workspace.GameService.UpdateObjectProperty.OnServerEvent:connect(function(player,object,property,value)
	local possibleProperties = {Anchored = true, Name = true, CFrame = true, Size = true, Parent = true}
	if object and object.Parent and possibleProperties[property] and (object:IsA("ImageLabel") or object:FindFirstChild("SG") or object:FindFirstChild("CurrentDragger"))  then
		object[property] = value
		
		if property == "Anchored" then
			if value == true then
				if object:CanSetNetworkOwnership() then
					object:SetNetworkOwner(player)
					wait(1)
					if object and object.Parent then 
						object:SetNetworkOwnershipAuto()
					end
				end
				object.CurrentDragger.Value = player
				
			else
				object.CurrentDragger.Value = nil
			end
			
		end
	end
end)

workspace.GameService.DraggingStarted.OnServerEvent:connect(function(player,object)
	if object and object.Parent and object:FindFirstChild("LastDrag") and object:FindFirstChild("LastDragger") then
		object.LastDragger.Value = player
		object.LastDrag.Value = game.Workspace.DistributedGameTime
	end
end)

function Weld(x,y) --workspace.GameService.WeldObject.OnServerEvent:connect(function(player,x,y)
	x:BreakJoints()
	y:BreakJoints()
	y.Anchored = false
	while y.Size ~= Vector3.new(4.6,.4,4.6) do wait() end
	y.CFrame = x.CFrame - Vector3.new(0,2,0)--x.CFrame * CFrame.Angles(0,0,math.pi/2) - Vector3.new(0,2,0)
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


local ingredient_z_indexes ={
	Cheese = 2,
	Pepperoni = 3,
	Sausage = 3,
	TomatoSauce = 1
}

function workspace.GameService.RequestIngredientObject.OnServerInvoke(player,target)
	if target == nil  then return end
	

	local ingredient = game.ServerStorage.Supplies.Dragger:clone()
	ingredient.Name = target.Name
	ingredient.Locked = false
	ingredient.Parent = workspace.Ingredients
	ingredient.LastDragger.Value = player
	ingredient.CurrentDragger.Value = player
	ingredient.LastDrag.Value = game.Workspace.DistributedGameTime
	if ingredient:FindFirstChild("CurrentDragger") then ingredient.CurrentDragger.Value = player end --if clicking on draggalbe ingriendt
	
	local image = ingredient.SG.Frame.ImageLabel
	image.Image = Enums.IngredientImages[target.Name]
	image.ZIndex = ingredient_z_indexes[target.Name]
	
	if target:FindFirstChild("CurrentDragger") then --player clicked on in ingredient instance and not the one of the 4 ingredient panels
		target:Destroy()
	end
	
	--game:GetService("Debris"):AddItem(ingredient, 180) --if player leaves while dragging
	return ingredient
end

--despawn ingreidnets
spawn(function()
	while true do
		wait(5)
		for _,ingredient in ipairs(workspace.Ingredients:GetChildren()) do
			if ingredient:FindFirstChild("LastDrag") and workspace.DistributedGameTime - ingredient.LastDrag.Value  > 10 then
				ingredient:Destroy()
			end
		end
	end
end)

workspace.GameService.ReleaseOwnership.OnServerEvent:connect(function(player,ingredient)
	if ingredient and ingredient.Parent and ingredient:FindFirstChild("CurrentDragger") then
		ingredient.CurrentDragger.Value = nil
	end
end)


workspace.GameService.DestroyIngredient.OnServerEvent:connect(function(player,ingredient,isDelay)
	if ingredient then
		if isDelay then
			game:GetService("Debris"):AddItem(ingredient, 10)
		else
			ingredient:Destroy()
		end
	end
end)





----Dialog--------------------------------------------------------Dialog-------------------------------------------------------------------------


--attach dialog object to cusomer
function ChildAdded(customer)
	wait()
	if customer:FindFirstChild("Head") then
		local head = customer.Head
		local dialogObject =  {
			CurrentDialog = head.Dialog,
			Head = head,
			CurrentPlayer = nil	
		}
		Dialogs[head] = dialogObject
		
		customer.ChildRemoved:connect(function(obj)
			
			if obj == head then
				Dialogs[head] = nil
				
				
			end
		end)
	else
		error("Could not find head")
	end
end
workspace.Customers.ChildAdded:connect(ChildAdded)




--local clerk1 = workspace.Clerk1
--local clerk2 =  workspace.Clerk2
local jordan = workspace.Island2.Jordan

--Dialogs[clerk1.Head] =   {CurrentDialog = clerk1.Head.Dialog, Head = clerk1.Head, CurrentPlayer = nil}
--Dialogs[clerk2.Head] =   {CurrentDialog = clerk2.Head.Dialog, Head = clerk2.Head, CurrentPlayer = nil}
Dialogs[jordan.Head] =   {CurrentDialog = jordan.Head.Dialog, Head = jordan.Head, CurrentPlayer = nil}

--clerk1.Name = "Clerk"
--clerk2.Name = "Clerk"

--clerk1.Head.Dialog.InUse = true
--clerk2.Head.Dialog.InUse = true



function script.GetCustomerDialog.OnInvoke(customer)
	if customer and customer:FindFirstChild("Head") and Dialogs[customer.Head] then
		return Dialogs[customer.Head]
	end
end


--delete cutomers dialog data when removed

function ChildRemoved(customer)
	
	if customer:FindFirstChild("Head") then
		
		Dialogs[customer.Head] = nil
	end
end
workspace.Customers.ChildRemoved:connect(ChildRemoved)


function CheckEndConversation(player)
	for head,dialog in pairs(Dialogs) do
		if dialog.CurrentPlayer and dialog.CurrentPlayer == player then
			EndConversation(head)
		end
	end
end


function PlayerAdded(player)
	player.CharacterAdded:connect(function(character)
		character.Humanoid.Died:connect(function()
			CheckEndConversation(player)
		end)
	end)
end

function PlayerRemoving(player)
	CheckEndConversation(player)
end

game.Players.PlayerRemoving:connect(PlayerRemoving)
game.Players.PlayerAdded:connect(PlayerAdded)





--make customer respond and then show new player responses
function ShowResponses(player,head,choice)

	local Dialog = Dialogs[head]
	if Dialog then
		local CurrentDialog = Dialog.CurrentDialog
	
		--gather dialog choice objects
		local choices  = {}
		for _,obj in ipairs(CurrentDialog:GetChildren()) do
			table.insert(choices,obj)
		end
		
		
		if #choices > 0 then --if there are not more options left
			
			
			workspace.Dialog:FireClient(player,"ShowResponseOptions",choices)
		
		else
			
			EndConversation(head)
			
		end

	end
	
end





function ClickedBubble(player,head)
	local Dialog = Dialogs[head]
	if Dialog and Dialog.CurrentPlayer == nil and Dialog.CurrentDialog then
		
		workspace.Dialog:FireAllClients("BubbleClicked",head)
		Dialog.CurrentPlayer = player
		Dialog.CurrentDialog = head.Dialog
		head.InUse.Value = true
		
		--reset dialog if player leaves during conversation
		spawn(function()
			while Dialog and Dialog.CurrentPlayer ~= nil do
				if Dialog.CurrentPlayer.Parent == nil then
					EndConversation(head)
				end
				wait(5)
			end
		end)
		
		
		
		if Dialog.CurrentDialog.Value ~= "" then --INITIALPROMPT
			game:GetService("Chat"):Chat(head,Dialog.CurrentDialog.Value)
			wait(2)
		else
			wait(.5)
		end
		
		--dont show rest of conversation if player isnt holding pizza
	--[[	if head and head.Parent and head.Parent.Name == "Jordan" and not player.Character:FindFirstChild("PizzaTool") then
			EndConversation(head)
			return
		end]]
		
		ShowResponses(player,head,nil)
		
	elseif Dialog then
		workspace.Dialog:FireClient(player,"AlreadyInConversation")
	end
end


--[[if order == nil then
			local str = "order == nil "
			if head then str = str .. "Head exists" else str = str .. "Head == nil" end
			if head and head.Parent then str = str .. "Head parent exists" else str = str .. "Head parent == nil" end
		
			error( .. head
		end ]]

--player responded
function ResponseSelected(player,choice,head)
	if not head or not head.Parent or not Dialogs[head] then return end
	--player chose "Goodbye!"
	if choice == nil then
		EndConversation(head)
		game:GetService("Chat"):Chat(player.Character.Head,"Goodbye!")
		return
	end
	
	Dialogs[head].CurrentDialog = choice

	--player chat
	game:GetService("Chat"):Chat(player.Character.Head,choice.UserDialog)
	
	wait(2)
	
	if not head or not head.Parent or not Dialogs[head] then return end

	
	if head.Parent.Parent == workspace.Customers then --customer
		local customerData = Customers[head.Parent]
		if customerData == nil then
			error("Couldn find customer data")
		end
		local order = customerData.Order--findOrder("Object",head.Parent,1) --find the customer's order
		if order == nil then
			local str = ""
			if not head then str = " head = nil " elseif not head.Parent then str = " head.Parent = nil " end
			if not Customers[head.Parent] then str = str .. " customer data doseing exist " end
			error("Order doesnt exist " .. str)
			
		end
		
		local customer = order.Object
		if order ~= nil and customer ~= nil then
			if choice == customer.RightOrder.Value  then
				workspace.TutorialService.PlayerAction.PlayerAction:Fire(player,"TalkedToCustomer",true)
				print(order.Order,customer,"OrderCustomer")
				GameService.RecivedCustomerOrder:FireClient(player,order.Order,customer)
			else
				workspace.TutorialService.PlayerAction.PlayerAction:Fire(player,"TalkedToCustomer",false)
		
				spawn(function()
					orderCompleted(nil,customer,true)
				end)
			end
		end
		
		
	elseif head.Parent.Name == "Clerk" then --if clerk
		script.Parent.PurchaseService.ClerkTalked:Fire(player,choice)
		
	
	end
	
	--NPC chat
	game:GetService("Chat"):Chat(head,choice.ResponseDialog)
	
	
	
	--[[if head and head.Parent and head.Parent.Name == "Jordan" and choice.Name == "GiveJordanPizza" then
		if player.Character:FindFirstChild("PizzaTool") then 
			player.Character.PizzaTool:Destroy()
		elseif player.Backpack:FindFirstChild("PizzaTool") then 
			player.Backpack.PizzaTool:Destroy() 
		end
	end]]
	
	wait(2)
	
	if head and head.Parent and head.Parent.Name == "Jordan" and choice.Name == "Accept" then
		workspace.Main.SellItemsMode:FireClient(player)
	end
	
	if not head or not head.Parent or not Dialogs[head] then return end


	--show player new responses
	ShowResponses(player,head,choice)
	
	
end



function DestroyDialog(head)
	if head and head.Parent and head:FindFirstChild("Dialog") then
		workspace.Dialog:FireAllClients("ConversationFinished",head)
		head.Dialog:Destroy()
		Dialogs[head] = nil
	end
end





function EndConversation(head)
	local dialog = Dialogs[head]
	if dialog then
		dialog.CurrentDialog = dialog.Head.Dialog --start dialog over
		dialog.CurrentPlayer = nil
		head.InUse.Value = false
		workspace.Dialog:FireAllClients("ConversationFinished",head)
	end
	
end





workspace.Dialog.OnServerEvent:connect(function(player,action,...)
	local args = {...}
	if player and player.Character and player.Character:FindFirstChild("Head") then
		
		if action == "ClickedBubble" then
			ClickedBubble(player,args[1])
			
		elseif action == "ResponseSelected" then
			ResponseSelected(player,args[1],args[2])
			
		elseif action == "EndConversation" then
			EndConversation(args[1])
		
		end
	
	end
end)





--/-/-/-/-/-/-/-/ORDERING PIZZA\-\-\-\-\-\-\-\-\-\-\-\





function InFrontOfCashReigster(player,areaBlock)
	if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local sizeX = areaBlock.Size.X
		local sizeZ = areaBlock.Size.Z
		local positionX = areaBlock.Position.X
		local positionZ = areaBlock.Position.Z
		local torsoPos = player.Character.HumanoidRootPart.Position
		
		if torsoPos.x > positionX - (sizeX/2) then
		if torsoPos.x < positionX + (sizeX/2) then
		if torsoPos.z > positionZ - (sizeZ/2) then
		if torsoPos.z < positionZ + (sizeZ/2) then
			return true
		end
		end
		end
		end
	end
	return false
end

local playerOrders = {}

function GetClosestPlayerAtRegisterWithOrder(cashier)
	
	local insideBounds = {}
	for _,player in ipairs(game.Players:GetPlayers()) do
		if (player ~= cashier or player.Name == "Player1" or player.Name == "Player" or player.Name == "Player2" or player.Name == "Dued1") then
			if playerOrders[player] and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.userId > -3 then
				if InFrontOfCashReigster(player,workspace.CustomerBlock1) or InFrontOfCashReigster(player,workspace.CustomerBlock2) then
					table.insert(insideBounds,player)	
				end
			end
		end
	end
	
	local distance = 100000
	local closestPlayer = nil
	for _,player in ipairs(insideBounds) do
		local dis = player:DistanceFromCharacter(cashier.Character.HumanoidRootPart.Position)
		if dis < distance then
			closestPlayer = player
			distance = dis
		end
	end
	return closestPlayer
end




local atRegister = {}
local numOrdersPlaced = {}

function Touched(hit,block)
	if hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if player and not atRegister[player] and player.userId > -3 then
			
			atRegister[player] = true
			
			local enoughMoney = false
			if Players[player] and  Players[player]["Moneyz"] > 100 then 
				enoughMoney = true
			end
			
			local reachedOrderLimit = false
			if numOrdersPlaced[player] and numOrdersPlaced[player] >= 3 then
				reachedOrderLimit = true
			end
			
			workspace.GameService.FoodMenuVisible:FireClient(player,true,enoughMoney,reachedOrderLimit)
			
			while InFrontOfCashReigster(player,block) do wait(1) end
			
			atRegister[player] = nil
			
			if playerOrders[player] then playerOrders[player] = nil end
			
			workspace.GameService.FoodMenuVisible:FireClient(player,false,nil,nil)
			
		end
	end
end

workspace.CustomerBlock1.Touched:connect(function(hit) Touched(hit,workspace.CustomerBlock1) end)
workspace.CustomerBlock2.Touched:connect(function(hit) Touched(hit,workspace.CustomerBlock2) end)





--when player click on a register button when not talking to customer
workspace.GameService.RegisterButtonPressedNoCustomer.OnServerEvent:connect(function(cashier,order,button)
	
	local playerCustomer = GetClosestPlayerAtRegisterWithOrder(cashier)
	if playerCustomer == nil then return end
	
	
	if playerOrders[playerCustomer] == order and Players[playerCustomer] then
			
		SoundFX:PlaySoundInsideZone("Correct","Cashier")	
			
			
		local orderNew = {}
		orderNew.Object = game.Workspace.Orders
		orderNew.Phase = 2
		orderNew.Order = order
		orderNew.Customer = playerCustomer
		
		num_orders_on_board = num_orders_on_board + 1
		
		table.insert(orders,1,orderNew)
		
		refreshOrderBoard()
		
		playerOrders[playerCustomer] = nil
		
		if not numOrdersPlaced[playerCustomer] then numOrdersPlaced[playerCustomer] = 0 end
		numOrdersPlaced[playerCustomer] = numOrdersPlaced[playerCustomer] + 1
		
		workspace.GameService.NofityFoodOrderComplete:FireClient(playerCustomer,false,nil,numOrdersPlaced[playerCustomer] >= 3) --notify food order menu
		workspace.GameService.NofityFoodOrderComplete:FireClient(cashier,false,button,nil) --notify work tool
		
		
		
		delay(600,function()
			if not playerCustomer or numOrdersPlaced[playerCustomer] == 0 then numOrdersPlaced[playerCustomer] = nil end
			numOrdersPlaced[playerCustomer] = numOrdersPlaced[playerCustomer] - 1
		end)
		
		
		delay(.5,function()
			
			SoundFX:PlaySoundInsideZone("CashRegister","Cashier")
			print("Remover")
			Players[playerCustomer]:RemoveMoneyz(100)

		end)
	
	else --cashier pressed wrong button
		

		SoundFX:PlaySoundInsideZone("Incorrect","Cashier")
			
		playerOrders[playerCustomer] = nil
		
		local reached = numOrdersPlaced[playerCustomer] and numOrdersPlaced[playerCustomer] >= 3
		
		workspace.GameService.NofityFoodOrderComplete:FireClient(playerCustomer,true,nil,reached)
		workspace.GameService.NofityFoodOrderComplete:FireClient(cashier,true,button)

			
	end
	
end)



local buttons = {
	Cheese = 1,
	Pepperoni = 2,
	Sausage = 3,
	MountainDew = 4
}


workspace.GameService.OrderChosen.OnServerEvent:connect(function(player,orderName)
	playerOrders[player] = buttons[orderName]
end)




---------Tutorial--------------------


workspace.Main.StartTutorial.OnServerEvent:connect(function(player,jobIndex)
	while Players[player] == nil do wait(.4) end
	Players[player]["TutorialObject"] = Tutorial.new(player,jobIndex)
	if Players[player]["TutorialObject"] then
		Players[player]["TutorialObject"]:Start()
	end
end)

function workspace.Main.GetCompletedTutorials.OnServerInvoke(player)
	
	while Players[player] == nil do wait(.1) end
	if player.Name == "Dued1" then
		Players[player]["Completed_Tutorials"] = {false,false,false,false,false,false}
	end

	return Players[player]["Completed_Tutorials"]
end

workspace.Main.QuitTutorial.OnServerEvent:connect(function(player)
	local tutorialObject = Players[player]["TutorialObject"]
	if tutorialObject then
		if tutorialObject.JobIndex ~= 6 then --furniture placment tutorial should teleport players back
			tutorialObject:TeleportToClosestSpawn()
		end
		tutorialObject:Stop()
	end
end)

function workspace.Main.IsNewPlayer.OnServerInvoke(player) --show locks during job choosing if new player
	if Players[player] and Players[player]["IsNewPlayer"] then 
		return true
	else
		return false
	end
end



print("GameService Loaded")



