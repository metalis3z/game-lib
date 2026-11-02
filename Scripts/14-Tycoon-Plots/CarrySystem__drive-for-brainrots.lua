-- Reference copy for study. Game: drive-for-brainrots
-- Original: ServerScriptService/Modules/CarrySystem.lua
-- What it does: Carry stack: picked-up items are kept as data and shown as massless, non-colliding models
--   welded in a stack above the player's head; walking into the CollectionZone (checked every 0.2s with a
--   point-in-box test) converts them to inventory tools. Carry limit comes from an upgrade value.

--!strict
-- CarrySystem
-- LOCATION: ServerScriptService/Modules/CarrySystem
--
-- Tracks items the player is carrying (as data entries) and VISUALLY welds
-- a stack of brainrot models onto their Head so everyone can see them.
-- When the player enters the CollectionZone (or fires RequestDropItem),
-- the carried items convert to tools via ItemManager.GiveItemToPlayer and
-- the welded models are destroyed.

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Debris = game:GetService("Debris")

local CarrySystem = {}

-- [ MODULES ]
local ItemConfigurations = require(ReplicatedStorage.Modules.ItemConfigurations)
local DataManager = require(ServerScriptService.Handlers.DataManager)
local ItemManager -- lazy-loaded in Init to avoid circular require

-- [ ASSETS ]
local CollectionZone = Workspace:WaitForChild("CollectionZone")
local Templates = ReplicatedStorage:WaitForChild("Templates")
local Events = ReplicatedStorage:WaitForChild("Events")
local GlobalSounds = Workspace:WaitForChild("Sounds")
local ItemsFolder = ReplicatedStorage:WaitForChild("Items")

-- [ DATA ]
-- carryingData[player] = {
--   [1] = { Name=..., Mutation=..., Rarity=..., Model=<welded model> },
--   ...
-- }
local carryingData: {[Player]: {any}} = {}
local playersInZone: {[Player]: boolean} = {}

-- [ CONFIG ]
local CHECK_INTERVAL = 0.2
local STACK_SPACING = 1.6    -- studs between stacked brainrots on head
local HEAD_OFFSET   = 1.5    -- studs above head for the first item

-- [ HELPERS ]

local function isInsideZone(position: Vector3, zonePart: BasePart): boolean
	local relativePos = zonePart.CFrame:PointToObjectSpace(position)
	local size = zonePart.Size
	return math.abs(relativePos.X) <= size.X / 2
		and math.abs(relativePos.Y) <= size.Y / 2
		and math.abs(relativePos.Z) <= size.Z / 2
end

local function getCarryLimit(player: Player): number
	-- Read from UpgradesData.CarryCapacity NumberValue (created by DataManager)
	local ud = player:FindFirstChild("UpgradesData")
	if ud then
		local cc = ud:FindFirstChild("CarryCapacity")
		if cc and cc.Value and cc.Value > 0 then
			return cc.Value
		end
	end
	return 1
end

-- Build a visual, welded copy of a brainrot model and attach it above the
-- player's head. Returns the model (or nil on failure).
local function buildCarriedModel(player: Player, itemName: string, mutation: string, stackIndex: number): Model?
	local char = player.Character
	if not char then return nil end
	local head = char:FindFirstChild("Head")
	if not head or not head:IsA("BasePart") then return nil end

	local mutFolder = ItemsFolder:FindFirstChild(mutation) or ItemsFolder:FindFirstChild("Normal")
	local template = mutFolder and mutFolder:FindFirstChild(itemName)
	if (not template) and mutation ~= "Normal" then
		local normal = ItemsFolder:FindFirstChild("Normal")
		template = normal and normal:FindFirstChild(itemName)
	end
	if not template then
		warn("[CarrySystem] No template for carried item: " .. itemName .. " (" .. mutation .. ")")
		return nil
	end

	local model = template:Clone()
	model.Name = "CarriedBrainrot"

	-- Ensure a PrimaryPart
	local primary = model:IsA("Model") and model.PrimaryPart or nil
	if not primary then
		local anyPart = model:FindFirstChild("Handle") or model:FindFirstChildWhichIsA("BasePart", true)
		if anyPart and anyPart:IsA("BasePart") then
			if model:IsA("Model") then
				model.PrimaryPart = anyPart
			end
			primary = anyPart
		end
	end
	if not primary then
		model:Destroy()
		return nil
	end

	-- Make every part fully inert: no collision, no physics response, no queries.
	-- CollisionGroup "CarriedItems" keeps them from interacting with anything else;
	-- without the group, CanCollide=false alone can still let physics engine nudge
	-- them when the player moves fast (e.g. driving).
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = false
			d.CanCollide = false
			d.CanTouch = false
			d.CanQuery = false
			d.Massless = true
			pcall(function() d.CollisionGroup = "CarriedItems" end)
			if d ~= primary then
				local w = Instance.new("WeldConstraint")
				w.Part0 = primary
				w.Part1 = d
				w.Parent = primary
			end
		end
	end

	-- Position above head: stack vertically
	local extents = model:GetExtentsSize()
	local yOffset = HEAD_OFFSET + (stackIndex - 1) * STACK_SPACING + extents.Y / 2
	model:PivotTo(head.CFrame * CFrame.new(0, yOffset, 0))

	-- Weld primary to head
	local weld = Instance.new("Weld")
	weld.Name = "HeadCarryWeld"
	weld.Part0 = head
	weld.Part1 = primary
	weld.C0 = CFrame.new(0, yOffset, 0)
	weld.C1 = CFrame.new()
	weld.Parent = primary

	model.Parent = char
	return model
end

local function destroyCarriedModels(player: Player)
	local items = carryingData[player]
	if not items then return end
	for _, entry in ipairs(items) do
		if entry.Model and entry.Model.Parent then
			entry.Model:Destroy()
		end
		entry.Model = nil
	end
end

local function rebuildCarriedModels(player: Player)
	-- Destroy existing visuals, rebuild from data (keeps stack positions correct)
	destroyCarriedModels(player)
	local items = carryingData[player]
	if not items then return end
	for i, entry in ipairs(items) do
		entry.Model = buildCarriedModel(player, entry.Name, entry.Mutation, i)
	end
end

-- [ PUBLIC API ]

function CarrySystem.IsPlayerInZone(player: Player): boolean
	return playersInZone[player] == true
end

function CarrySystem.CanCarryMore(player: Player): boolean
	local current = carryingData[player] or {}
	return #current < getCarryLimit(player)
end

function CarrySystem.AddItemToCarry(player: Player, name: string, mutation: string, rarity: string): boolean
	if not carryingData[player] then carryingData[player] = {} end
	if not CarrySystem.CanCarryMore(player) then return false end

	local idx = #carryingData[player] + 1
	local entry = {
		Name = name,
		Mutation = mutation,
		Rarity = rarity,
		Model = nil,
	}
	table.insert(carryingData[player], entry)
	entry.Model = buildCarriedModel(player, name, mutation, idx)
	return true
end

function CarrySystem.GetCarrying(player: Player): {any}
	return carryingData[player] or {}
end

-- [ ZONE LOGIC ]

local function processZoneEnter(player: Player)
	-- Convert everything carried into tools, destroy visuals
	local items = carryingData[player]
	if items and #items > 0 then
		for _, itemData in ipairs(items) do
			ItemManager.GiveItemToPlayer(player, itemData.Name, itemData.Mutation, itemData.Rarity, 1)
		end
		destroyCarriedModels(player)
		carryingData[player] = {}

		local successSound = GlobalSounds:FindFirstChild("Success")
		if successSound and successSound:IsA("Sound") then
			local s = successSound:Clone()
			s.Parent = player:WaitForChild("PlayerGui")
			s:Play()
			Debris:AddItem(s, (s.TimeLength or 2) + 1)
		end
	end
end

local function processZoneExit(_player: Player)
	-- Nothing to clean up on leaving the zone; carried items build up again as player pickus things.
end

function CarrySystem:Init()
	print("[CarrySystem] Initialized")
	ItemManager = require(ServerScriptService.Modules.ItemManager)
	_G.__CarrySystem = CarrySystem

	-- Register the CarriedItems collision group so welded brainrots never
	-- collide with anything (default group, self, or other CarriedItems).
	local PhysicsService = game:GetService("PhysicsService")
	local ok = pcall(function()
		PhysicsService:RegisterCollisionGroup("CarriedItems")
	end)
	if ok then
		pcall(function()
			PhysicsService:CollisionGroupSetCollidable("CarriedItems", "CarriedItems", false)
			PhysicsService:CollisionGroupSetCollidable("CarriedItems", "Default", false)
		end)
	end

	local dropEvent = Events:FindFirstChild("RequestDropItem")
	if not dropEvent then
		dropEvent = Instance.new("RemoteEvent")
		dropEvent.Name = "RequestDropItem"
		dropEvent.Parent = Events
	end

	-- Manual drop (e.g. hit a hazard, timer expired in a zone script, etc.)
	dropEvent.OnServerEvent:Connect(function(player: Player)
		destroyCarriedModels(player)
		carryingData[player] = {}
		local notif = Events:FindFirstChild("ShowNotification")
		if notif then notif:FireClient(player, "Items Dropped", "Success") end
	end)

	-- Rebuild visuals on respawn so they re-attach to the new Head
	Players.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(function()
			task.wait(0.5) -- let character assemble
			if carryingData[player] and #carryingData[player] > 0 then
				-- On death, items are lost. Clear the data too.
				carryingData[player] = {}
			end
		end)
	end)
	for _, p in ipairs(Players:GetPlayers()) do
		p.CharacterAdded:Connect(function()
			task.wait(0.5)
			if carryingData[p] and #carryingData[p] > 0 then
				carryingData[p] = {}
			end
		end)
	end
end

function CarrySystem:Start()
	task.spawn(function()
		while true do
			task.wait(CHECK_INTERVAL)

			local foundPlayers = {}
			for _, player in ipairs(Players:GetPlayers()) do
				local character = player.Character
				if character then
					local rootPart = character:FindFirstChild("HumanoidRootPart")
					if rootPart and rootPart:IsA("BasePart") then
						if isInsideZone(rootPart.Position, CollectionZone) then
							foundPlayers[player] = true
						end
					end
				end
			end

			-- Left the zone
			for player, _ in pairs(playersInZone) do
				if not foundPlayers[player] then
					playersInZone[player] = nil
					processZoneExit(player)
				end
			end

			-- Entered the zone -> deposit items
			for player, _ in pairs(foundPlayers) do
				if not playersInZone[player] then
					playersInZone[player] = true
					processZoneEnter(player)
				end
			end
		end
	end)

	Players.PlayerRemoving:Connect(function(player)
		destroyCarriedModels(player)
		carryingData[player] = nil
		playersInZone[player] = nil
	end)
end

return CarrySystem
