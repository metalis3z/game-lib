--!strict
-- LOCATION: ServerScriptService/Modules/CarrySystem

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Debris = game:GetService("Debris")

local CarrySystem = {}

-- [ MODULES ]
local ItemConfigurations = require(ReplicatedStorage.Modules.ItemConfigurations)
local PlayerController = require(ServerScriptService.Controllers.PlayerController) -- Added for Profile access
local ItemManager -- Lazy Loaded

-- [ ASSETS ]
local CollectionZone = Workspace:WaitForChild("CollectionZone")
local Templates = ReplicatedStorage:WaitForChild("Templates")
local CarryGUI_Template = Templates:WaitForChild("CarryGUI")
local Events = ReplicatedStorage:WaitForChild("Events")
local GlobalSounds = Workspace:WaitForChild("Sounds")

-- [ DATA ]
local carryingData: {[Player]: {any}} = {}
local playersInZone: {[Player]: boolean} = {}

-- [ CONFIG ]
local CHECK_INTERVAL = 0.2 

-- [ HELPERS ]

local function isInsideZone(position: Vector3, zonePart: BasePart): boolean
	local relativePos = zonePart.CFrame:PointToObjectSpace(position)
	local size = zonePart.Size
	return  math.abs(relativePos.X) <= size.X / 2 and
		math.abs(relativePos.Y) <= size.Y / 2 and
		math.abs(relativePos.Z) <= size.Z / 2
end

local function getCarryGUI(player: Player): BillboardGui?
	if not player.Character then return nil end
	local head = player.Character:FindFirstChild("Head")
	if not head then return nil end
	return head:FindFirstChild("CarryGUI") :: BillboardGui
end

local function updateCarryGUI(player: Player)
	local gui = getCarryGUI(player)
	if not gui then return end

	local items = carryingData[player] or {}
	local count = #items

	-- ## UPDATED: Get Max Carry from Profile dynamically ##
	local profile = PlayerController:GetProfile(player)
	local limit = profile and profile.Data.MaxCarry or 1

	-- 1. Update Count Label
	local limitLabel = gui:FindFirstChild("CarryLimit") :: TextLabel
	if limitLabel then
		limitLabel.Text = tostring(count) .. "/" .. tostring(limit)
	end

	-- 2. Update Image Grid
	local imagesFrame = gui:FindFirstChild("ItemImages")
	if imagesFrame then
		local folder = imagesFrame:FindFirstChild("Template")
		local template = folder and folder:FindFirstChild("ImageTemplate")

		if template then
			for _, child in ipairs(imagesFrame:GetChildren()) do
				if child:IsA("ImageLabel") and child ~= template then
					child:Destroy()
				end
			end

			for _, item in ipairs(items) do
				local conf = ItemConfigurations.GetItemData(item.Name)
				if conf then
					local newIcon = template:Clone()
					newIcon.Image = conf.ImageId or ""
					newIcon.Visible = true
					newIcon.Parent = imagesFrame
				end
			end
		end
	end
end

local function showCarryGUI(player: Player)
	if not player.Character then return end
	local head = player.Character:FindFirstChild("Head")
	if not head then return end

	if not head:FindFirstChild("CarryGUI") then
		local gui = CarryGUI_Template:Clone()
		gui.Name = "CarryGUI"
		gui.Adornee = head
		gui.Parent = head
		updateCarryGUI(player)
	end
end

local function hideCarryGUI(player: Player)
	if not player.Character then return end
	local head = player.Character:FindFirstChild("Head")
	if head then
		local gui = head:FindFirstChild("CarryGUI")
		if gui then gui:Destroy() end
	end
end

-- [ PUBLIC API ]

function CarrySystem.IsPlayerInZone(player: Player): boolean
	return playersInZone[player] == true
end

function CarrySystem.CanCarryMore(player: Player): boolean
	local current = carryingData[player] or {}
	local profile = PlayerController:GetProfile(player)
	local limit = profile and profile.Data.MaxCarry or 1
	return #current < limit
end

function CarrySystem.AddItemToCarry(player: Player, name: string, mutation: string, rarity: string)
	if not carryingData[player] then carryingData[player] = {} end

	if CarrySystem.CanCarryMore(player) then
		table.insert(carryingData[player], {
			Name = name,
			Mutation = mutation,
			Rarity = rarity
		})
		updateCarryGUI(player)
		return true
	end
	return false
end

-- [NEW] This function allows other scripts (like upgrades) to force the text to update
function CarrySystem.RefreshGUI(player: Player)
	updateCarryGUI(player)
end

-- [ ZONE LOGIC ]

local function processZoneExit(player: Player)
	local items = carryingData[player]

	if items and #items > 0 then
		for _, itemData in ipairs(items) do
			ItemManager.GiveItemToPlayer(player, itemData.Name, itemData.Mutation, itemData.Rarity, 1)
		end
		carryingData[player] = {}

		local successSound = GlobalSounds:FindFirstChild("Success")
		if successSound and successSound:IsA("Sound") then
			local newSound = successSound:Clone()
			newSound.Parent = player:WaitForChild("PlayerGui")
			newSound:Play()
			Debris:AddItem(newSound, newSound.TimeLength + 1)
		end
	end

	hideCarryGUI(player)
end

local function processZoneEnter(player: Player)
	if not carryingData[player] then carryingData[player] = {} end
	showCarryGUI(player)
end

function CarrySystem:Init()
	print("[CarrySystem] Initialized")
	local Modules = ServerScriptService:WaitForChild("Modules")
	ItemManager = require(Modules:WaitForChild("ItemManager"))

	local dropEvent = Events:FindFirstChild("RequestDropItem")
	if not dropEvent then
		dropEvent = Instance.new("RemoteEvent")
		dropEvent.Name = "RequestDropItem"
		dropEvent.Parent = Events
	end

	dropEvent.OnServerEvent:Connect(function(player)
		local character = player.Character
		local rootPart = character and character:FindFirstChild("HumanoidRootPart") :: BasePart

		if rootPart and isInsideZone(rootPart.Position, CollectionZone) then
			carryingData[player] = {}
			updateCarryGUI(player) -- Clears items but updates limit text
			local notif = Events:FindFirstChild("ShowNotification")
			if notif then notif:FireClient(player, "Items Dropped", "Success") end
		end
	end)
end

function CarrySystem:Start()
	task.spawn(function()
		while true do
			task.wait(CHECK_INTERVAL)

			local foundPlayers = {}

			for _, player in ipairs(Players:GetPlayers()) do
				local character = player.Character
				if character then
					local rootPart = character:FindFirstChild("HumanoidRootPart") :: BasePart
					if rootPart then
						if isInsideZone(rootPart.Position, CollectionZone) then
							foundPlayers[player] = true
						end
					end
				end
			end

			for player, _ in pairs(playersInZone) do
				if not foundPlayers[player] then
					playersInZone[player] = nil
					processZoneExit(player)
				end
			end

			for player, _ in pairs(foundPlayers) do
				if not playersInZone[player] then
					playersInZone[player] = true
					processZoneEnter(player)
				end
			end
		end
	end)

	Players.PlayerRemoving:Connect(function(player)
		carryingData[player] = nil
		playersInZone[player] = nil
	end)
end

return CarrySystem