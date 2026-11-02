local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)
local StealService = require(ServerScriptService.Services.StealService)
local CombatService = require(ServerScriptService.Services.CombatService)
local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")

local MedusaHead = {}

local COOLDOWN = 25
local RING_RADIUS = 30
local PETRIFY_DURATION = 1

local PlayerCooldowns = {}

local function GetPlayersInRadius(position, radius)
	local playersInRange = {}

	for _, player in ipairs(Players:GetPlayers()) do
		if player.Character then
			local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart then
				local distance = (humanoidRootPart.Position - position).Magnitude
				if distance <= radius then
					table.insert(playersInRange, player)
				end
			end
		end
	end

	return playersInRange
end

local function PetrifyPlayer(targetPlayer, attackerCharacter)
	if not targetPlayer or not targetPlayer.Character then return end
	local targetCharacter = targetPlayer.Character

	local targetHumanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
	if not targetHumanoid or targetHumanoid.Health <= 0 then return end

	local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
	if not targetRootPart then return end

	StealService:CancelSteal(targetPlayer)

	local anchoredParts = {}
	for _, part in ipairs(targetCharacter:GetDescendants()) do
		if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
			if not part.Anchored then
				part.Anchored = true
				table.insert(anchoredParts, part)
			end
		end
	end

	local stoneModel = Instance.new("Model")
	stoneModel.Name = targetPlayer.Name .. "_Petrified"
	stoneModel.Parent = workspace

	task.delay(1, function()
		if not targetCharacter or not targetCharacter.Parent then return end

		for _, part in ipairs(targetCharacter:GetDescendants()) do
			if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
				local stonePart = Instance.new("Part")
				stonePart.Size = part.Size
				stonePart.CFrame = part.CFrame
				stonePart.Material = Enum.Material.Slate
				stonePart.Color = Color3.fromRGB(100, 100, 100)
				stonePart.CanCollide = false
				stonePart.Anchored = true
				stonePart.Parent = stoneModel
			end
		end
	end)

	task.delay(2, function()
		if stoneModel then
			stoneModel:Destroy()
		end
	end)

	task.delay(3, function()
		if not targetCharacter or not targetCharacter.Parent then return end

		for _, part in ipairs(anchoredParts) do
			if part and part.Parent then
				part.Anchored = false
			end
		end

		targetPlayer:SetAttribute("Ragdolled", true)
		targetHumanoid.PlatformStand = true

		if attackerCharacter then
			local attackerRoot = attackerCharacter:FindFirstChild("HumanoidRootPart")
			if attackerRoot then
				CombatService.Fling(targetRootPart, 500, attackerRoot.Position)
			end
		end

		Ragdoll.Ragdoll(targetCharacter)
		task.wait(3)
		Ragdoll.Unragdoll(targetCharacter)

		targetPlayer:SetAttribute("Ragdolled", nil)
		targetHumanoid.PlatformStand = false
	end)
end

function MedusaHead.OnExecution(Player: Player, Character: Model, Tool: Tool)
	local lastUse = PlayerCooldowns[Player.UserId]
	if lastUse and (tick() - lastUse) < COOLDOWN then
		return nil
	end

	local humanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return nil
	end

	PlayerCooldowns[Player.UserId] = tick()
	ToolsCooldown:FireClient(Player, Tool, COOLDOWN)

	local playersInRadius = GetPlayersInRadius(humanoidRootPart.Position, RING_RADIUS)

	for _, targetPlayer in ipairs(playersInRadius) do
		if targetPlayer ~= Player then
			PetrifyPlayer(targetPlayer, Character)
		end
	end

	return tick() + COOLDOWN
end

return MedusaHead