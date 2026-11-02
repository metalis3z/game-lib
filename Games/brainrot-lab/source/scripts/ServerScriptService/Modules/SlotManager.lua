--!strict
-- LOCATION: ServerScriptService/Modules/SlotManager

local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")

local SlotManager = {}

-- [ MODULES ]
local ItemConfigurations = require(ReplicatedStorage.Modules.ItemConfigurations)
local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)
local PlayerController 
local ItemManager 

-- [ ASSETS ]
local Templates = ReplicatedStorage:WaitForChild("Templates")
local UpgradeGUI_Template = Templates:WaitForChild("UpgradeGUI")
local CollectGUI_Template = Templates:WaitForChild("CollectGUI")
local MoneyTemplate = Templates:WaitForChild("Money")
local Events = ReplicatedStorage:WaitForChild("Events")

-- [ CONSTANTS ]
local UPGRADE_COST_MULTIPLIER = 1.5
local DEBOUNCE_TIME = 0.5 
local INTERACTION_COOLDOWN = 0.8 

-- [ STATE ]
local lastUpgradeTime = {} 

-- [ HELPERS ]

local function getUpgradeCost(baseIncome: number, level: number): number
	return math.floor(baseIncome * 20 * (UPGRADE_COST_MULTIPLIER ^ (level - 1)))
end

local function updateSlotVisuals(slotModel: Model, itemData: any?, level: number, stored: number, rebirths: number, isVip: boolean?)
	-- 1. Collect GUI
	local collectPart = slotModel:FindFirstChild("CollectTouch") :: BasePart
	if collectPart then
		local gui = collectPart:FindFirstChild("CollectGUI") :: SurfaceGui
		if not gui then
			gui = CollectGUI_Template:Clone(); gui.Name = "CollectGUI"; gui.Parent = collectPart
		end

		local frame = gui:FindFirstChild("CollectFrame")
		local label = frame and frame:FindFirstChild("Price") :: TextLabel

		if itemData then
			gui.Enabled = true
			if label then label.Text = "$" .. NumberFormatter.Format(stored) end
		else
			gui.Enabled = false
		end
	end

	-- 2. Upgrade GUI
	local upgradePart = slotModel:FindFirstChild("UpgradePart") :: BasePart
	if upgradePart then
		local gui = upgradePart:FindFirstChild("UpgradeGUI") :: SurfaceGui
		if not gui then
			gui = UpgradeGUI_Template:Clone(); gui.Name = "UpgradeGUI"; gui.Parent = upgradePart
			gui:SetAttribute("SlotName", slotModel.Name); gui:SetAttribute("FloorName", slotModel.Parent and slotModel.Parent.Parent.Name)
		end

		local button = gui:FindFirstChild("UpgradeButton") :: TextButton
		if itemData and button then
			gui.Enabled = true
			local levelsLabel = button:FindFirstChild("Levels") :: TextLabel
			local priceLabel = button:FindFirstChild("Price") :: TextLabel
			local itemConf = ItemConfigurations.GetItemData(itemData.Name)
			local baseIncome = itemConf and itemConf.Income or 10
			local cost = getUpgradeCost(baseIncome, level)
			if levelsLabel then levelsLabel.Text = "Level " .. tostring(level) .. " > Level " .. tostring(level + 1) end
			if priceLabel then priceLabel.Text = "$" .. NumberFormatter.Format(cost) end
		else
			gui.Enabled = false
		end
	end

	-- 3. Item Model & Prompt
	local spawnPart = slotModel:FindFirstChild("Spawn") :: BasePart
	if spawnPart then
		local existingItem = spawnPart:FindFirstChild("VisualItem")
		local currentName = existingItem and existingItem:GetAttribute("OriginalName")
		local currentMutation = existingItem and existingItem:GetAttribute("Mutation") 

		if itemData then
			if not existingItem or currentName ~= itemData.Name or currentMutation ~= itemData.Mutation then 
				if existingItem then existingItem:Destroy() end
				ItemManager.SpawnVisualItem(spawnPart, itemData.Name, itemData.Mutation, itemData.Rarity, level, rebirths, isVip, itemData.IngredientBonus, itemData.AppliedIngredients)
				-- Restore ActiveEvent mutations (from Aura Infinita) after spawning
				if itemData.ActiveEvent and itemData.ActiveEvent ~= "" then
					local newItem = spawnPart:FindFirstChild("VisualItem")
					if newItem then
						ItemManager.RestoreActiveEvents(newItem, itemData.ActiveEvent)
						if itemData.EventMultiplier then
							newItem:SetAttribute("EventMultiplier", itemData.EventMultiplier)
						end
						if itemData.BaseEarn then
							newItem:SetAttribute("BaseEarn", itemData.BaseEarn)
						end
					end
				end
			else
				ItemManager.UpdateVisualItem(existingItem, level, rebirths, isVip)
			end
		else
			if existingItem then existingItem:Destroy() end
		end

		local prompt = spawnPart:FindFirstChild("ProximityPrompt") :: ProximityPrompt
		if prompt then
			prompt.ActionText = itemData and "Pick Up / Swap" or "Place Item"
		end
	else
		if slotModel.Parent then 
			warn("[SlotManager] Visual Update Failed: 'Spawn' part missing in " .. slotModel.Name)
		end
	end
end

-- [ ACTIONS ]

-- Sync ActiveEvent (and related attributes) from visual items to the player's profile.
-- This catches mutations applied by ALL event modules (not just AuraInfinita) so they
-- persist across rejoin.
function SlotManager.SyncActiveEvents(player: Player)
	local profile = PlayerController:GetProfile(player)
	if not profile then return end
	if not profile.Data.Plots then return end

	local plot = Workspace:FindFirstChild("Plot_" .. player.Name)
	if not plot then return end

	for floorName, floorSlots in pairs(profile.Data.Plots) do
		local floorModel = plot:FindFirstChild(floorName)
		local slotsFolder = floorModel and floorModel:FindFirstChild("Slots")
		if slotsFolder then
			for slotName, slotData in pairs(floorSlots) do
				if slotData.Item then
					local slotModel = slotsFolder:FindFirstChild(slotName)
					local spawnPart = slotModel and slotModel:FindFirstChild("Spawn")
					local visualItem = spawnPart and spawnPart:FindFirstChild("VisualItem")
					if visualItem then
						local activeEvent = visualItem:GetAttribute("ActiveEvent") or ""
						local eventMultiplier = visualItem:GetAttribute("EventMultiplier")
						local baseEarn = visualItem:GetAttribute("BaseEarn")
						local ingredientBonus = visualItem:GetAttribute("IngredientBonus")
						local appliedIngredients = visualItem:GetAttribute("AppliedIngredients")
						slotData.Item.ActiveEvent = activeEvent
						if eventMultiplier then
							slotData.Item.EventMultiplier = eventMultiplier
						end
						if baseEarn then
							slotData.Item.BaseEarn = baseEarn
						end
						if ingredientBonus then
							slotData.Item.IngredientBonus = ingredientBonus
						end
						if appliedIngredients then
							slotData.Item.AppliedIngredients = appliedIngredients
						end
					end
				end
			end
		end
	end
end

function SlotManager.RefreshAllSlots(player: Player)
	local profile = PlayerController:GetProfile(player)
	if not profile then return end

	if not profile.Data.Plots then profile.Data.Plots = {} end

	local rebirths = profile.Data.Rebirths or 0
	local isVip = PlayerController:IsVIP(player)
	local plot = Workspace:FindFirstChild("Plot_" .. player.Name)
	if not plot then return end

	for floorName, floorSlots in pairs(profile.Data.Plots) do
		local floorModel = plot:FindFirstChild(floorName)
		local slotsFolder = floorModel and floorModel:FindFirstChild("Slots")

		if slotsFolder then
			for slotName, slotData in pairs(floorSlots) do
				local slotModel = slotsFolder:FindFirstChild(slotName)
				if slotModel then
					if type(slotData.Stored) ~= "number" then slotData.Stored = 0 end
					local data = slotData.Item and slotData or {Item=nil, Level=1, Stored=0}
					updateSlotVisuals(slotModel, data.Item, data.Level, data.Stored, rebirths, isVip)
				end
			end
		end
	end
end

function SlotManager.HandleInteraction(player: Player, floorName: string, slotName: string, slotModel: Model)
	local profile = PlayerController:GetProfile(player)
	if not profile then warn("[SlotManager] No profile for " .. player.Name); return end

	if not profile.Data.Plots then profile.Data.Plots = {} end
	if not profile.Data.Plots[floorName] then profile.Data.Plots[floorName] = {} end
	local floorData = profile.Data.Plots[floorName]

	local currentSlotData = floorData[slotName]
	local isOccupied = (currentSlotData and currentSlotData.Item ~= nil)

	local character = player.Character
	local heldTool = character and character:FindFirstChildWhichIsA("Tool")
	local heldItemName = heldTool and heldTool:GetAttribute("OriginalName")

	if isOccupied then
		-- Collect Money
		if currentSlotData.Stored > 0 then
			PlayerController:AddMoney(player, math.floor(currentSlotData.Stored))
			currentSlotData.Stored = 0
		end

		-- Return Old Item (preserve ActiveEvent, IngredientBonus, AppliedIngredients from visual item)
		local visualItem = slotModel:FindFirstChild("Spawn") and slotModel.Spawn:FindFirstChild("VisualItem")
		local savedActiveEvent = visualItem and visualItem:GetAttribute("ActiveEvent") or ""
		local savedIngredientBonus = visualItem and visualItem:GetAttribute("IngredientBonus") or 1
		local savedAppliedIngredients = visualItem and visualItem:GetAttribute("AppliedIngredients") or ""
		ItemManager.GiveItemToPlayer(
			player, 
			currentSlotData.Item.Name, 
			currentSlotData.Item.Mutation, 
			currentSlotData.Item.Rarity,
			currentSlotData.Level,
			nil,
			savedActiveEvent,
			savedIngredientBonus,
			savedAppliedIngredients
		)

		if heldTool and heldItemName then
			-- SWAP
			currentSlotData.Item = {
				Name = heldItemName,
				Mutation = heldTool:GetAttribute("Mutation"),
				Rarity = heldTool:GetAttribute("Rarity"),
				ActiveEvent = heldTool:GetAttribute("ActiveEvent") or "",
				IngredientBonus = heldTool:GetAttribute("IngredientBonus") or 1,
				AppliedIngredients = heldTool:GetAttribute("AppliedIngredients") or "",
			}
			currentSlotData.Level = heldTool:GetAttribute("Level") or 1
			heldTool:Destroy()
		else
			-- PICK UP (Clear)
			floorData[slotName] = { Item = nil, Level = 1, Stored = 0 }
		end

	else
		-- PLACE
		if heldTool then
			if heldItemName then
				floorData[slotName] = {
					Item = {
						Name = heldItemName,
						Mutation = heldTool:GetAttribute("Mutation"),
						Rarity = heldTool:GetAttribute("Rarity"),
						ActiveEvent = heldTool:GetAttribute("ActiveEvent") or "",
						IngredientBonus = heldTool:GetAttribute("IngredientBonus") or 1,
						AppliedIngredients = heldTool:GetAttribute("AppliedIngredients") or "",
					},
					Level = heldTool:GetAttribute("Level") or 1,
					Stored = 0
				}
				heldTool:Destroy()
			else
				warn("[SlotManager] Tool held has no 'OriginalName' Attribute! Cannot place.")
				local notif = Events:FindFirstChild("ShowNotification")
				if notif then notif:FireClient(player, "Invalid Item! (No Data)", "Error") end
				return
			end
		else
			local notif = Events:FindFirstChild("ShowNotification")
			if notif then notif:FireClient(player, "Equip an item to place it!", "Error") end
			return
		end
	end

	local isVip = PlayerController:IsVIP(player)
	local newData = floorData[slotName]
	updateSlotVisuals(slotModel, newData and newData.Item, newData and newData.Level or 1, newData and newData.Stored or 0, profile.Data.Rebirths or 0, isVip)
end

function SlotManager.UpgradeItem(player: Player, floorName: string, slotName: string)
	local debounceKey = player.Name .. "_" .. floorName .. "_" .. slotName
	local now = tick()
	if lastUpgradeTime[debounceKey] and (now - lastUpgradeTime[debounceKey] < DEBOUNCE_TIME) then
		return 
	end
	lastUpgradeTime[debounceKey] = now

	local profile = PlayerController:GetProfile(player)
	if not profile then return end
	if not profile.Data.Plots then profile.Data.Plots = {} end
	local floorData = profile.Data.Plots[floorName]
	if not floorData then return end
	local slotData = floorData[slotName]
	if not slotData or not slotData.Item then return end

	local itemConf = ItemConfigurations.GetItemData(slotData.Item.Name)
	local baseIncome = itemConf and itemConf.Income or 10
	local cost = getUpgradeCost(baseIncome, slotData.Level)

	if PlayerController:DeductMoney(player, cost) then
		slotData.Level += 1
		local plot = Workspace:FindFirstChild("Plot_" .. player.Name)
		if plot then
			local floor = plot:FindFirstChild(floorName)
			local slots = floor and floor:FindFirstChild("Slots")
			local slotModel = slots and slots:FindFirstChild(slotName)
			local isVip = PlayerController:IsVIP(player)
			if slotModel then
				updateSlotVisuals(slotModel, slotData.Item, slotData.Level, slotData.Stored, profile.Data.Rebirths or 0, isVip)
			end
		end

		local notif = Events:FindFirstChild("ShowNotification")
		if notif then 
			notif:FireClient(player, "Slot Upgraded!", "Success") 
		end
	else
		local notif = Events:FindFirstChild("ShowNotification")
		if notif then 
			notif:FireClient(player, "Not enough money!", "Error") 
		end
	end
end

function SlotManager.CollectMoney(player: Player, floorName: string, slotName: string, slotModel: Model)
	local profile = PlayerController:GetProfile(player)
	if not profile then return end
	if not profile.Data.Plots then profile.Data.Plots = {} end
	local slotData = profile.Data.Plots[floorName] and profile.Data.Plots[floorName][slotName]
	if not slotData then return end
	if type(slotData.Stored) ~= "number" then slotData.Stored = 0 end
	if slotData.Stored <= 0 then return end

	local amount = math.floor(slotData.Stored)
	slotData.Stored = 0

	PlayerController:AddMoney(player, amount)

	local collectPart = slotModel:FindFirstChild("CollectTouch")
	if collectPart then
		local gui = collectPart:FindFirstChild("CollectGUI")
		local frame = gui and gui:FindFirstChild("CollectFrame")
		local label = frame and frame:FindFirstChild("Price") :: TextLabel
		if label then
			label.Text = "$0"
		end
	end

	local popupEvent = Events:FindFirstChild("ShowCashPopUp")
	if popupEvent then
		popupEvent:FireClient(player, amount)
	end

	if collectPart then
		local moneyEffect = MoneyTemplate:Clone()
		moneyEffect.Parent = collectPart
		for _, child in ipairs(moneyEffect:GetChildren()) do
			if child:IsA("ParticleEmitter") then
				child:Emit(child:GetAttribute("EmitCount") or 10)
			end
		end
		Debris:AddItem(moneyEffect, 3)
	end
end

function SlotManager.RefreshSlot(player: Player, floorName: string, slotName: string)
	local profile = PlayerController:GetProfile(player)
	if not profile then return end

	if not profile.Data.Plots then profile.Data.Plots = {} end
	local slotData = profile.Data.Plots[floorName] and profile.Data.Plots[floorName][slotName]

	local plot = Workspace:FindFirstChild("Plot_" .. player.Name)
	if plot then
		local isVip = PlayerController:IsVIP(player)
		local floor = plot:FindFirstChild(floorName)
		local slots = floor and floor:FindFirstChild("Slots")
		local slotModel = slots and slots:FindFirstChild(slotName)
		if slotModel then
			if slotData then
				updateSlotVisuals(slotModel, slotData.Item, slotData.Level, slotData.Stored, profile.Data.Rebirths or 0, isVip)
			else
				updateSlotVisuals(slotModel, nil, 1, 0, profile.Data.Rebirths or 0, isVip)
			end
		end
	end
end

-- [ SETUP LOGIC ]

-- Resolves the player who CURRENTLY owns the plot that a given slot belongs to.
-- Plots are permanent, reused physical objects (Workspace.Plots.1-8) that get
-- renamed to "Plot_<PlayerName>" and reparented to Workspace while occupied,
-- then handed back to the next player when the previous one leaves. Resolving
-- ownership dynamically (instead of capturing the player in a closure at setup
-- time) ensures interactions keep working correctly after a plot is recycled
-- to a new player, instead of staying permanently bound to whoever first used
-- that physical slot.
local function getPlotOwner(slotModel: Instance): Player?
	local current: Instance? = slotModel.Parent
	while current do
		if current.Name:match("^Plot_") then
			local ownerName = current.Name:sub(6)
			return Players:FindFirstChild(ownerName) :: Player?
		end
		if current == Workspace then
			return nil
		end
		current = current.Parent
	end
	return nil
end

local function setupSingleSlot(player: Player, floorName: string, slotName: string, slotModel: Model)
	local spawnPart = slotModel:WaitForChild("Spawn", 5)
	local upgradePart = slotModel:WaitForChild("UpgradePart", 5)
	local collectPart = slotModel:WaitForChild("CollectTouch", 5)

	if not spawnPart or not upgradePart or not collectPart then 
		warn("[SlotManager] Slot Setup Failed for: " .. slotName .. " (Missing Parts)")
		return 
	end

	if not spawnPart:FindFirstChild("ProximityPrompt") then
		local prompt = Instance.new("ProximityPrompt")
		prompt.ActionText = "Place Item"
		prompt.ObjectText = "Slot"
		prompt.RequiresLineOfSight = false
		prompt.HoldDuration = 0 
		prompt.MaxActivationDistance = 8
		prompt.Style = Enum.ProximityPromptStyle.Custom
		prompt.Parent = spawnPart

		prompt.Enabled = slotModel:GetAttribute("IsUnlocked") == true

		slotModel:GetAttributeChangedSignal("IsUnlocked"):Connect(function()
			prompt.Enabled = slotModel:GetAttribute("IsUnlocked") == true
		end)

		local lastTriggerTime = 0

		prompt.Triggered:Connect(function(triggerPlayer)
			local owner = getPlotOwner(slotModel)
			if owner and triggerPlayer == owner then
				local now = tick()
				if now - lastTriggerTime < INTERACTION_COOLDOWN then return end
				lastTriggerTime = now

				SlotManager.HandleInteraction(owner, floorName, slotName, slotModel)
			end
		end)
	end

	if not collectPart:GetAttribute("Connected") then
		collectPart:SetAttribute("Connected", true)
		local db = false
		collectPart.Touched:Connect(function(hit)
			if db then return end
			local char = hit.Parent
			local hum = char and char:FindFirstChild("Humanoid")
			local touchingPlayer = hum and Players:GetPlayerFromCharacter(char)
			if touchingPlayer then
				local owner = getPlotOwner(slotModel)
				if owner and touchingPlayer == owner then
					db = true
					SlotManager.CollectMoney(owner, floorName, slotName, slotModel)
					task.wait(0.5)
					db = false
				end
			end
		end)
	end

	task.spawn(function()
		local profile = PlayerController:GetProfile(player)
		local retries = 0
		while not profile and retries < 20 do
			task.wait(0.5)
			profile = PlayerController:GetProfile(player)
			retries += 1
		end

		if profile then
			local isVip = PlayerController:IsVIP(player)
			if not profile.Data.Plots then profile.Data.Plots = {} end
			if not profile.Data.Plots[floorName] then 
				profile.Data.Plots[floorName] = {} 
			end
			local data = profile.Data.Plots[floorName][slotName]
			if data and data.Item then
				if type(data.Stored) ~= "number" then data.Stored = 0 end
				updateSlotVisuals(slotModel, data.Item, data.Level, data.Stored, profile.Data.Rebirths or 0, isVip)
			else
				updateSlotVisuals(slotModel, nil, 1, 0, profile.Data.Rebirths or 0, isVip)
			end
		end
	end)
end

local function monitorFloor(player: Player, floorModel: Model)
	local slotsFolder = floorModel:WaitForChild("Slots", 5)
	if not slotsFolder then return end

	for _, slot in ipairs(slotsFolder:GetChildren()) do
		setupSingleSlot(player, floorModel.Name, slot.Name, slot)
	end
	slotsFolder.ChildAdded:Connect(function(child)
		setupSingleSlot(player, floorModel.Name, child.Name, child)
	end)
end

function SlotManager.MonitorPlot(player: Player, plot: Model)
	for _, child in ipairs(plot:GetChildren()) do
		if child.Name:match("Floor%d+") then
			monitorFloor(player, child)
		end
	end
	plot.ChildAdded:Connect(function(child)
		if child.Name:match("Floor%d+") then
			monitorFloor(player, child)
		end
	end)
end

-- [ INITIALIZATION ]

function SlotManager:Init(controllers)
	PlayerController = controllers.PlayerController
	local Modules = ServerScriptService:WaitForChild("Modules")
	ItemManager = require(Modules:WaitForChild("ItemManager"))

	local upgradeEvent = Events:FindFirstChild("RequestSlotUpgrade")
	if not upgradeEvent then
		upgradeEvent = Instance.new("RemoteEvent")
		upgradeEvent.Name = "RequestSlotUpgrade"
		upgradeEvent.Parent = Events
	end

	if not SlotManager._connected then
		SlotManager._connected = true
		upgradeEvent.OnServerEvent:Connect(function(player, floorName, slotName)
			SlotManager.UpgradeItem(player, floorName, slotName)
		end)
	end

	local popupEvent = Events:FindFirstChild("ShowCashPopUp")
	if not popupEvent then
		popupEvent = Instance.new("RemoteEvent")
		popupEvent.Name = "ShowCashPopUp"
		popupEvent.Parent = Events
	end
end

-- [ START ]

local function setupPlayerMonitoring(player: Player)
	local plotName = "Plot_" .. player.Name
	local existingPlot = Workspace:FindFirstChild(plotName)
	if existingPlot then
		SlotManager.MonitorPlot(player, existingPlot)
	end

	Workspace.ChildAdded:Connect(function(child)
		if child.Name == plotName then
			SlotManager.MonitorPlot(player, child)
		end
	end)
end

function SlotManager:Start()
	Players.PlayerAdded:Connect(setupPlayerMonitoring)

	for _, player in ipairs(Players:GetPlayers()) do
		setupPlayerMonitoring(player)
	end

	-- Periodic sync: save ActiveEvent from visual items to profile every 5 seconds
	-- This catches mutations from ALL event modules (not just AuraInfinita)
	task.spawn(function()
		while true do
			task.wait(5)
			for _, player in ipairs(Players:GetPlayers()) do
				pcall(SlotManager.SyncActiveEvents, player)
			end
		end
	end)

	-- Sync before player leaves so mutations are saved to the profile
	Players.PlayerRemoving:Connect(function(player)
		pcall(SlotManager.SyncActiveEvents, player)
	end)
end

return SlotManager