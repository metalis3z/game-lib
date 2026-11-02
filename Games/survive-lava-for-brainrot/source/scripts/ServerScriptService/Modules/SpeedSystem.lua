--!strict
-- LOCATION: ServerScriptService/Modules/SpeedSystem

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local SpeedSystem = {}

-- [ MODULES ]
local PlayerController 
local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)

-- [ CONFIGURATION ]
local BASE_PRICE = 50       
local PRICE_MULTIPLIER = 1.25 
local BASE_WALKSPEED = 16   

-- [ HELPER: CUMULATIVE PRICE ]
local function getBulkPrice(currentSpeed: number, amount: number): number
	local totalPrice = 0
	local tempSpeed = currentSpeed

	for i = 1, amount do
		local upgradesBought = math.max(0, tempSpeed - BASE_WALKSPEED)
		local cost = BASE_PRICE * (PRICE_MULTIPLIER ^ upgradesBought)
		totalPrice += cost
		tempSpeed += 1
	end

	return math.floor(totalPrice)
end

-- [ INTERNAL: APPLY SPEED ]
-- Shared logic for both Money and Robux purchases
local function applySpeedUpgrade(player: Player, amount: number, profile: any)
	local currentSpeed = profile.Data.Speed or BASE_WALKSPEED
	local newSpeed = currentSpeed + amount
	profile.Data.Speed = newSpeed

	-- Update Character
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.WalkSpeed = newSpeed
	end

	-- Update Leaderstats
	if player:FindFirstChild("leaderstats") then
		player.leaderstats.Speed.Value = newSpeed
	end

	-- Refresh UI
	SpeedSystem.UpdateClientUI(player)
end

-- [ PUBLIC API ]

-- Called by Client (Money Purchase)
function SpeedSystem.PurchaseUpgrade(player: Player, amount: number)
	if amount ~= 1 and amount ~= 5 and amount ~= 10 then return end

	local profile = PlayerController:GetProfile(player)
	if not profile then return end

	local currentSpeed = profile.Data.Speed or BASE_WALKSPEED
	local price = getBulkPrice(currentSpeed, amount)

	if PlayerController:DeductMoney(player, price) then
		applySpeedUpgrade(player, amount, profile)

		local Events = ReplicatedStorage:FindFirstChild("Events")
		local notif = Events and Events:FindFirstChild("ShowNotification")
		if notif then notif:FireClient(player, "+" .. amount .. " Speed Upgraded!", "Success") end
	else
		local Events = ReplicatedStorage:FindFirstChild("Events")
		local notif = Events and Events:FindFirstChild("ShowNotification")
		if notif then notif:FireClient(player, "Not enough money!", "Error") end
	end
end

-- ## ADDED: Called by MonetizationController (Robux Purchase) ##
function SpeedSystem.GrantSpeed(player: Player, amount: number)
	local profile = PlayerController:GetProfile(player)
	if not profile then return end

	applySpeedUpgrade(player, amount, profile)
end

function SpeedSystem.UpdateClientUI(player: Player)
	local profile = PlayerController:GetProfile(player)
	if not profile then return end

	local currentSpeed = profile.Data.Speed or BASE_WALKSPEED

	-- Use String Keys
	local priceData = {
		["1"] = getBulkPrice(currentSpeed, 1),
		["5"] = getBulkPrice(currentSpeed, 5),
		["10"] = getBulkPrice(currentSpeed, 10)
	}

	local Events = ReplicatedStorage:FindFirstChild("Events")
	local updateEvent = Events and Events:FindFirstChild("UpdateSpeedUI")

	if updateEvent then
		updateEvent:FireClient(player, priceData, currentSpeed)
	end
end

-- [ INIT ]
function SpeedSystem:Init(controllers)
	print("[SpeedSystem] Initialized")
	PlayerController = controllers.PlayerController

	local Events = ReplicatedStorage:WaitForChild("Events")

	if not Events:FindFirstChild("PurchaseSpeed") then
		local re = Instance.new("RemoteEvent"); re.Name = "PurchaseSpeed"; re.Parent = Events
	end
	if not Events:FindFirstChild("UpdateSpeedUI") then
		local re = Instance.new("RemoteEvent"); re.Name = "UpdateSpeedUI"; re.Parent = Events
	end

	Events.PurchaseSpeed.OnServerEvent:Connect(function(player, amount)
		SpeedSystem.PurchaseUpgrade(player, amount)
	end)
end

function SpeedSystem:Start()
	local function onPlayerAdded(player)
		task.wait(1) 
		SpeedSystem.UpdateClientUI(player)

		player.CharacterAdded:Connect(function(char)
			local profile = PlayerController:GetProfile(player)
			if profile then
				local hum = char:WaitForChild("Humanoid", 10)
				if hum then hum.WalkSpeed = profile.Data.Speed or BASE_WALKSPEED end
			end
		end)
	end

	Players.PlayerAdded:Connect(onPlayerAdded)
	for _, p in ipairs(Players:GetPlayers()) do task.spawn(onPlayerAdded, p) end
end

return SpeedSystem