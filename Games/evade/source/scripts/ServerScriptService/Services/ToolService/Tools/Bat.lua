local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local CombatService = require(ServerScriptService.Services.CombatService)
local StealService = require(ServerScriptService.Services.StealService)
local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)

local Bat = {}

local COOLDOWN = 0.7
local RAGDOLL_DURATION = 3
local FLING_FORCE = 500
local HIT_RADIUS = 8

local PlayerCooldowns = {}

function Bat.OnExecution(Player: Player, Character: Model, Tool: Tool)
	local lastUse = PlayerCooldowns[Player.UserId]
	if lastUse and (tick() - lastUse) < COOLDOWN then
		return
	end
	PlayerCooldowns[Player.UserId] = tick()

	local Handle = Tool:FindFirstChild("Handle")
	if not Handle then return end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	if not HumanoidRootPart then return end

	local Slash = Tool:FindFirstChild("Slash")
	if Slash then
		Slash:Play()
	end

	local alreadyHit = {}
	for _, targetPlayer in pairs(Players:GetPlayers()) do
		if targetPlayer ~= Player and targetPlayer.Character and not alreadyHit[targetPlayer.UserId] then
			local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
			if targetRoot and (targetRoot.Position - HumanoidRootPart.Position).Magnitude <= HIT_RADIUS then
				local direction = (targetRoot.Position - HumanoidRootPart.Position).Unit
				local lookDirection = HumanoidRootPart.CFrame.LookVector
				local dotProduct = direction:Dot(lookDirection)
				
				if dotProduct > 0.3 then
					Bat.HitPlayer(Player, targetPlayer, targetRoot)
					alreadyHit[targetPlayer.UserId] = true
				end
			end
		end
	end
end

function Bat.HitPlayer(attacker: Player, target: Player, targetRoot: Part)
	if target:GetAttribute("Ragdolled") then return end

	local targetCharacter = target.Character
	if not targetCharacter then return end

	local targetHumanoid = targetCharacter:FindFirstChild("Humanoid")
	if not targetHumanoid or targetHumanoid.Health <= 0 then return end

	-- Воспроизводим звук попадания
	local attackerTool = attacker.Character and attacker.Character:FindFirstChildOfClass("Tool")
	if attackerTool then
		local Hit = attackerTool:FindFirstChild("Hit")
		if Hit then
			Hit:Play()
		end
	end

	-- Отменяем кражу, если она происходит
	if StealService and StealService.CancelSteal then
		StealService:CancelSteal(target)
	end

	-- Устанавливаем атрибут ragdoll
	target:SetAttribute("Ragdolled", true)
	targetHumanoid.PlatformStand = true

	-- Применяем силу
	local attackerRoot = attacker.Character and attacker.Character:FindFirstChild("HumanoidRootPart")
	if attackerRoot then
		CombatService.Fling(targetRoot, FLING_FORCE, attackerRoot.Position)
	end

	-- Применяем ragdoll
	if Ragdoll and Ragdoll.Ragdoll then
		Ragdoll.Ragdoll(targetCharacter)
	end

	-- Восстанавливаем через время
	task.delay(RAGDOLL_DURATION, function()
		if target and target.Character then
			if Ragdoll and Ragdoll.Unragdoll then
				Ragdoll.Unragdoll(target.Character)
			end
			target:SetAttribute("Ragdolled", nil)
			local humanoid = target.Character:FindFirstChild("Humanoid")
			if humanoid then
				humanoid.PlatformStand = false
			end
		end
	end)
end

return Bat