--!strict
-- LOCATION: ServerScriptService/Modules/RebirthSystem

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local RebirthSystem = {}

-- [ MODULES ]
local PlayerController
local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)

-- [ CONFIG ]
local BASE_SPEED_COST = 20
local BASE_WALKSPEED = 10
local BASE_JUMPPOWER = 50 -- salto base Roblox

-- [ HELPERS ]
function RebirthSystem.GetInfo(player: Player)
	local profile = PlayerController:GetProfile(player)
	if not profile then
		return math.huge, 1, 1
	end

	local reb = profile.Data.Rebirths or 0
	local cost = BASE_SPEED_COST * (2 ^ reb)
	local currentMult = 1 + (reb * 0.5)
	local nextMult = 1 + ((reb + 1) * 0.5)

	return cost, currentMult, nextMult
end

-- [ INTERNAL: DO REBIRTH ]
local function executeRebirth(player: Player, profile: any)
	-- Increment rebirth
	profile.Data.Rebirths += 1

	-- Reset speed
	profile.Data.Speed = BASE_WALKSPEED

	-- 🔥 TRIPLICAR SALTO
	local rebirths = profile.Data.Rebirths
	local newJumpPower = BASE_JUMPPOWER * (1.5^ rebirths)
	profile.Data.JumpPower = newJumpPower

	-- Leaderstats
	if player:FindFirstChild("leaderstats") then
		player.leaderstats.Rebirths.Value = rebirths
		player.leaderstats.Speed.Value = BASE_WALKSPEED

		if player.leaderstats:FindFirstChild("JumpPower") then
			player.leaderstats.JumpPower.Value = newJumpPower
		end
	end

	-- Apply to character
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		local humanoid = player.Character.Humanoid
		humanoid.UseJumpPower = true
		humanoid.WalkSpeed = BASE_WALKSPEED
		humanoid.JumpPower = newJumpPower
	end

	-- Notification
	local Events = ReplicatedStorage:FindFirstChild("Events")
	local notif = Events and Events:FindFirstChild("ShowNotification")
	if notif then 
		notif:FireClient(player, "Rebirth Successful! Jump x3 🔥", "Success") 
	end

	-- Update UI
	local updateEvent = Events:FindFirstChild("UpdateRebirthUI")
	if updateEvent then
		updateEvent:FireClient(player)
	end

	-- Refresh Speed UI
	local SpeedSystem = require(ServerScriptService.Modules.SpeedSystem)
	if SpeedSystem and SpeedSystem.UpdateClientUI then
		SpeedSystem.UpdateClientUI(player)
	end
end

-- [ PUBLIC API ]

-- Robux / Admin rebirth
function RebirthSystem.ForceRebirth(player: Player)
	local profile = PlayerController:GetProfile(player)
	if profile then
		executeRebirth(player, profile)
	end
end

-- Client rebirth attempt
function RebirthSystem.AttemptRebirth(player: Player)
	local profile = PlayerController:GetProfile(player)
	if not profile then return end

	local currentSpeed = profile.Data.Speed or BASE_WALKSPEED
	local cost = RebirthSystem.GetInfo(player)

	if currentSpeed >= cost then
		profile.Data.Speed -= cost
		executeRebirth(player, profile)
	else
		local Events = ReplicatedStorage:FindFirstChild("Events")
		local notif = Events and Events:FindFirstChild("ShowNotification")
		if notif then 
			notif:FireClient(player, "Not enough Speed!", "Error") 
		end
	end
end

-- [ INIT ]
function RebirthSystem:Init(controllers)
	print("[RebirthSystem] Initialized")
	PlayerController = controllers.PlayerController

	local Events = ReplicatedStorage:WaitForChild("Events")

	if not Events:FindFirstChild("RequestRebirth") then
		local re = Instance.new("RemoteEvent")
		re.Name = "RequestRebirth"
		re.Parent = Events
	end

	if not Events:FindFirstChild("UpdateRebirthUI") then
		local re = Instance.new("RemoteEvent")
		re.Name = "UpdateRebirthUI"
		re.Parent = Events
	end

	Events.RequestRebirth.OnServerEvent:Connect(function(player)
		if not player:IsDescendantOf(Players) then return end
		RebirthSystem.AttemptRebirth(player)
	end)
end

function RebirthSystem:Start()
	-- No loop needed
end

return RebirthSystem
