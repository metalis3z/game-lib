local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local DataModules = ReplicatedStorage:WaitForChild("DataModules")
local Craft = require(DataModules.Craft)
local Pets = require(DataModules.Pets)
local Rarities = require(DataModules.Rarities)
local DataManager = require(game:GetService("ServerScriptService").Engine.Scripts.Data.DataManager)
local PetSystem = require(ReplicatedStorage.Engine.Modules.PetSystem)
local luckModule = require(ReplicatedStorage.Engine.Modules.Luck)
local notificationModule = require(ReplicatedStorage.Engine.Modules.NotificationModule)

local CraftSystem = {}
CraftSystem.playersCrafting = {}

local function updateAmount(player: Player, textLabel, petName, neededAmount)
	coroutine.wrap(function()
		while wait() do
			if player then
				local data = DataManager.profiles[player]
				if data then
					local Pets = data.Data["Pets"]
					local amount = 0
					for _, pet in pairs(Pets) do
						if pet == petName then
							amount += 1
						end
					end
					if amount >= neededAmount then
						textLabel.TextColor3 = Color3.fromRGB(0, 170, 0)
					else
						textLabel.TextColor3 = Color3.fromRGB(255, 75, 75)
					end
					textLabel.Text = amount.."/"..neededAmount
				end
			end
		end
	end)()
end

local function checkRequiredPets(player, item)
	for _, pet in pairs(item.pets) do
		local petName = pet[1]
		local petAmount = pet[2]
		
		local Pets = DataManager.profiles[player].Data["Pets"]
		local amount = 0
		for _, aPet in pairs(Pets) do
			if aPet == petName then
				amount += 1
			end
		end
		
		if amount >= petAmount then
			continue
		else
			return
		end
	end
	
	return true
end

local function craftItem(player: Player, item, noCheck) 
	if checkRequiredPets(player, item) == true and not table.find(CraftSystem.playersCrafting, player) or noCheck then
		if player.PlayerGui.GUI.Frames.Craft.Holder.InfoFrame.ItemName.Text == item.name or noCheck then
			table.insert(DataManager.profiles[player].Data["Items"], item.name)
			for _, pet in pairs(item.pets) do
				local petName = pet[1]
				local amount = pet[2]

				for i = 1,amount do
					if not noCheck then
						table.remove(DataManager.profiles[player].Data["Pets"], table.find(DataManager.profiles[player].Data["Pets"], petName))
					end
				end
			end

			if item.name == "Luck Aura" then
				local frame = player.PlayerGui.GUI.Frames.Craft.Holder.HolderScroll:FindFirstChild("Luck Aura")
				if frame then
					frame:Remove()
				end
			end
			if item.name == "Electro Bubble" then
				local frame = player.PlayerGui.GUI.Frames.Craft.Holder.HolderScroll:FindFirstChild("Electro Bubble")
				if frame then
					frame:Remove()
				end
			end
			if item.name == "Burst Aura" then
				local frame = player.PlayerGui.GUI.Frames.Craft.Holder.HolderScroll:FindFirstChild("Burst Aura")
				if frame then
					frame:Remove()
				end
			end
			if item.name == "Shining Star" then
				local frame = player.PlayerGui.GUI.Frames.Craft.Holder.HolderScroll:FindFirstChild("Shining Star")
				if frame then
					frame:Remove()
				end
			end
			if item.name == "Foggy Aura" then
				local frame = player.PlayerGui.GUI.Frames.Craft.Holder.HolderScroll:FindFirstChild("Foggy Aura")
				if frame then
					frame:Remove()
				end
			end
			if item.name == "Bubble Burst" then
				local frame = player.PlayerGui.GUI.Frames.Craft.Holder.HolderScroll:FindFirstChild("Bubble Burst")
				if frame then
					frame:Remove()
				end
			end
			if item.name == "Recharged Aura" then
				local frame = player.PlayerGui.GUI.Frames.Craft.Holder.HolderScroll:FindFirstChild("Recharged Aura")
				if frame then
					frame:Remove()
				end
			end

			table.remove(CraftSystem.playersCrafting, table.find(CraftSystem.playersCrafting, player))
			PetSystem.UpdatePets(player)
			CraftSystem.UpdateItems(player)
			local info = player.PlayerGui.GUI.Frames.Craft.Holder.InfoFrame

			info.Icon.Image = "???"
			info.Description.Text = "???"
			info["Description Shadow"].Text = "???"
			info.ItemName.Text = "???"
			info["ItemName Shadow"].Text = "???"
			coroutine.wrap(function()
				notificationModule.Notify(player, "Crafted a " .. item.name)
			end)()
		end
	end
end

local function displayItem(player: Player, item)
	local playerGui = player.PlayerGui
	local gui = playerGui:WaitForChild("GUI")
	local frames = gui:WaitForChild("Frames")
	local craft = frames:WaitForChild("Craft")
	local holder = craft:WaitForChild("Holder")
	local info = holder:WaitForChild("InfoFrame")
	local requirments = craft:WaitForChild("Requirments")
	local scroll = requirments:WaitForChild("ScrollingFrame")
	local template = scroll:WaitForChild("template")
	
	for _, object in pairs(scroll:GetChildren()) do
		if object:IsA("Frame") then
			if object.Visible == true then
				object:Remove()
			end
		end
	end
	
	info.Description.Text = item.description
	info["Description Shadow"].Text = item.description
	info.ItemName.Text = item.name
	info["ItemName Shadow"].Text = item.name
	for _, pet in pairs(item.pets) do
		local petName = pet[1]
		local petAmount = pet[2]
		
		local petInfo
		for _, pet in pairs(Pets) do
			if pet.name == petName then
				petInfo = pet
			end
		end
		
		local new = template:Clone()
		new.Rarity.Text = petName
		new.Rarity.TextColor3 = Rarities[petInfo.title].color
		updateAmount(player, new.Number, petName, petAmount)
		new.Visible = true
		new.Parent = template.Parent
		
		
		
		if petInfo then
			new.Icon:ClearAllChildren()
			local petModel = petInfo.pet:Clone()
			local multi = 1
			if petModel:GetAttribute("big") then
				multi = 2
			end
			petModel.Parent = new.Icon
			petModel:PivotTo(CFrame.new(0,0,-4*multi) * CFrame.Angles(0, math.rad(100), math.rad(-10)))
		end
	end
end

local function displayCraftedItem(player: Player, item, frame)
	local playerGui = player.PlayerGui
	local gui = playerGui:WaitForChild("GUI")
	local frames = gui:WaitForChild("Frames")
	local craftFrame = frames:WaitForChild("Items")
	local holder = craftFrame:WaitForChild("Holder")
	local info = holder:WaitForChild("InfoFrame")
	
	info.Icon.Image = item.image
	info.Description.Text = item.description
	info["Description Shadow"].Text = item.description
	info.Title.Text = item.name
	info["Title Shadow"].Text = item.name
	info["You Have"].Text = "You have " .. frame:GetAttribute("amount")
end

local function useItem(player, itemName)
	local item
	for _, aItem in pairs(Craft) do
		if aItem.name == itemName then
			item = aItem
		end
	end
	
	if item then
		table.remove(DataManager.profiles[player].Data["Items"], table.find(DataManager.profiles[player].Data["Items"], itemName))
		CraftSystem.UpdateItems(player)
		local playerGui = player.PlayerGui
		local gui = playerGui:WaitForChild("GUI")
		local frames = gui:WaitForChild("Frames")
		local craftFrame = frames:WaitForChild("Items")
		local holder = craftFrame:WaitForChild("Holder")
		local info = holder:WaitForChild("InfoFrame")

		info.Icon.Image = "???"
		info.Description.Text = "???"
		info["Description Shadow"].Text = "???"
		info.Title.Text = "???"
		info["Title Shadow"].Text = "???"
		info["You Have"].Text = "???"
		luckModule.GiveLuck(player, itemName)
	end
end

CraftSystem.UpdateItems = function(player: Player)
	local playerGui = player.PlayerGui
	local gui = playerGui:WaitForChild("GUI")
	local frames = gui:WaitForChild("Frames")
	local craftFrame = frames:WaitForChild("Items")
	local holder = craftFrame:WaitForChild("Holder")
	local scroll = holder:WaitForChild("HolderScroll")
	local template = scroll:WaitForChild("ItemTemplate")
	
	repeat wait() until DataManager.profiles[player]
	local items = DataManager.profiles[player].Data["Items"]
	
	for _, object in pairs(scroll:GetChildren()) do
		if object:IsA("ImageButton") and object.Name ~= "ItemTemplate" then
			object:Remove()
		end
	end
	
	for _, item in pairs(items) do
		local frame = scroll:FindFirstChild(item)
		if not frame then

			local itemInfo

			for _, aItem in pairs(Craft) do
				if aItem.name == item then
					itemInfo = aItem
				end
			end

			if itemInfo then
				local itemName = itemInfo.name
				local itemImage = itemInfo.image

				local new = template:Clone()
				new.Name = itemName
				new.SelectItem.Image = itemImage
				new.ItemName.Text = itemName
				new:SetAttribute("amount", new:GetAttribute("amount") + 1)
				new.Amount.Text = "x" .. new:GetAttribute("amount")
				new.Parent = scroll
				new.Visible = true
				
				new.MouseButton1Click:Connect(function()
					displayCraftedItem(player, itemInfo, new)
				end)
			end
		else
			frame:SetAttribute("amount", frame:GetAttribute("amount") + 1)
			frame.Amount.Text = "x" .. frame:GetAttribute("amount")
		end	
	end
end

CraftSystem.Load = function(player: Player)
	local playerGui = player.PlayerGui
	local gui = playerGui:WaitForChild("GUI")
	local frames = gui:WaitForChild("Frames")
	local craft = frames:WaitForChild("Craft")
	local itemsFrame = frames:WaitForChild("Items")
	local holder = craft:WaitForChild("Holder")
	local info = holder:WaitForChild("InfoFrame")
	local craftButton = info:WaitForChild("Craft")
	local scroll = holder:WaitForChild("HolderScroll")
	local template = scroll:WaitForChild("ItemTemplate")
	local itemsFrame = itemsFrame:WaitForChild("Holder")
	local infoFrame = itemsFrame:WaitForChild("InfoFrame")
	local Use = infoFrame:WaitForChild("Use")
	
	local currentItem
	
	for i, item in pairs(Craft) do
		
		if item.name == "Luck Aura" or item.name == "Electro Bubble" or item.name == "Burst Aura" or item.name == "Shining Star" or item.name == "Foggy Aura" or item.name == "Bubble Burst" or item.name == "Recharged Aura" then
			
			repeat wait() until DataManager.profiles[player]
			if DataManager.profiles[player].Data["Boosts"][item.name] == true then
				print(item.name)
				continue
			end
		end
		
		local new = template:Clone()
		new.Name = item.name
		new.Parent = scroll
		new.SelectItem.Image = item.image
		new.LayoutOrder = i
		new.ItemName.Text = item.name
		new.Visible = true
		
		new.MouseButton1Click:Connect(function()
			currentItem = item
			displayItem(player, item)
		end)
	end
	
	craftButton.MouseButton1Click:Connect(function()
		if currentItem then
			craftItem(player, currentItem)
		end
	end)
	
	Use.MouseButton1Click:Connect(function()
		local itemName = infoFrame.Title.Text
		useItem(player, itemName)
	end)
	
	CraftSystem.UpdateItems(player)
end

game.ReplicatedStorage.Engine.RemotesEvents.Claim.OnServerEvent:Connect(function(player, itemName)
	
	local item
	for _, aItem in pairs(Craft) do
		if aItem.name == itemName then
			item = aItem
		end
	end
	
	if item then
		print("a")
		craftItem(player, item, true)
	end
end)

return CraftSystem