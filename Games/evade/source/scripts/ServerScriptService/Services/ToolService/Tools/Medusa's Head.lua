local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)
local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)
local StealService = require(game:GetService("ServerScriptService").Services.StealService)
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

local function PetrifyPlayer(targetPlayer)
	if not targetPlayer or not targetPlayer.Character then return end
	local targetCharacter = targetPlayer.Character

	local humanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then return end

	-- Stop stealing if they're frozen
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

	task.delay(1, function()
		local stoneParts = {}

		for _, part in ipairs(targetCharacter:GetDescendants()) do
			if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
				local stonePart = Instance.new("Part")
				stonePart.Size = part.Size
				stonePart.CFrame = part.CFrame
				stonePart.Material = Enum.Material.Slate
				stonePart.CanCollide = false
				stonePart.Anchored = true
				stonePart.Parent = workspace

				table.insert(stoneParts, stonePart)
			end
		end
	end)

	task.delay(2, function()
		for _, child in ipairs(workspace:GetChildren()) do
			if child:IsA("Part") and child.Material == Enum.Material.Slate then
				child:Destroy()
			end
		end
	end)

	task.delay(3, function()
		Ragdoll.Ragdoll(targetCharacter)
		for _, part in ipairs(anchoredParts) do
			if part and part.Parent then
				part.Anchored = false
			end
		end
		Ragdoll.Ragdoll(targetCharacter)
		task.wait(1.25)
		Ragdoll.Unragdoll(targetCharacter)
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
			PetrifyPlayer(targetPlayer)
		end
	end

	return tick() + COOLDOWN
end

return MedusaHead
