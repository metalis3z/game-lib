local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlotService = require(ServerScriptService.Source.Services.PlotService)

local TeleportService = {}

local TeleportRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TeleportService")
local RequestTeleportEvent = TeleportRemotes:WaitForChild("RequestTeleport")
local TeleportCompletedEvent = TeleportRemotes:WaitForChild("TeleportCompleted")

local Assets = Workspace:FindFirstChild("Assets")
local TeleportsFolder = Assets and Assets:FindFirstChild("Teleports")
local TreesPart = TeleportsFolder and TeleportsFolder:FindFirstChild("Trees")
local ShopsPart = TeleportsFolder and TeleportsFolder:FindFirstChild("Shops")

local TELEPORT_COOLDOWN = 0.2
local playerCooldowns = {}

local function handleTeleportRequest(player, destinationType)
	local lastTeleport = playerCooldowns[player]
	if lastTeleport and (os.clock() - lastTeleport) < TELEPORT_COOLDOWN then
		return
	end

	if type(destinationType) ~= "string" then return end

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid or humanoid.Health <= 0 then return end

	local targetCFrame = nil

	if destinationType == "Trees" then
		if not TreesPart then return end
		targetCFrame = TreesPart.CFrame + Vector3.new(0, 3, 0)

	elseif destinationType == "Shop" then
		if not ShopsPart then return end
		targetCFrame = ShopsPart.CFrame + Vector3.new(0, 3, 0)

	elseif destinationType == "Home" then
		local plot = PlotService.GetPlot(player)
		if not plot then return end

		local spawnPart = plot:FindFirstChild("SpawnLocation")
		if not spawnPart then return end

		targetCFrame = spawnPart.CFrame + Vector3.new(0, 3, 0)
	else
		return
	end

	if targetCFrame then
		playerCooldowns[player] = os.clock()
		character:PivotTo(targetCFrame)
		TeleportCompletedEvent:FireClient(player, targetCFrame)
	end
end

function TeleportService.Init()
	RequestTeleportEvent.OnServerEvent:Connect(handleTeleportRequest)

	Players.PlayerRemoving:Connect(function(player)
		playerCooldowns[player] = nil
	end)
end

return TeleportService