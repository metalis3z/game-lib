local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Workspace = game:GetService("Workspace")

local Module = {}
local Gets = script.Parent.Parent.Get
local Set = script.Parent.Parent.Set.PlayerData

local function Get(what)
	local getter = Gets:FindFirstChild(what)
	return getter and getter:Invoke()
end

local function getPlayerData()
	return Get("PlayerData") or {}
end

local function getGiveGun()
	local gameFunctions = Get("GameFunctions")
	return gameFunctions and gameFunctions.GiveWeapon and gameFunctions.GiveWeapon.Gun
end

local function getRandomSpawnPosition()
	local map = Get("Map")
	local spawns = map and map:FindFirstChild("Spawns")
	local spawnParts = {}
	if spawns then
		for _, spawnPart in ipairs(spawns:GetChildren()) do
			if spawnPart:IsA("BasePart") then
				table.insert(spawnParts, spawnPart)
			end
		end
	end

	if #spawnParts > 0 then
		return spawnParts[math.random(1, #spawnParts)].Position + Vector3.new(0, 2, 0)
	end

	return Vector3.new(0, 5, 0)
end

local function getDropCFrame(player, useRandomSpawn)
	if not useRandomSpawn and player and player.Character then
		local root = player.Character:FindFirstChild("HumanoidRootPart")
			or player.Character:FindFirstChild("UpperTorso")
			or player.Character:FindFirstChild("Torso")
		if root and root:IsA("BasePart") then
			return root.CFrame
		end
	end

	return CFrame.new(getRandomSpawnPosition())
end

local function resolveTouchingPlayer(touchedPart)
	local current = touchedPart
	while current and current ~= Workspace do
		if current:IsA("Model") and current:FindFirstChildOfClass("Humanoid") then
			return Players:GetPlayerFromCharacter(current)
		end
		current = current.Parent
	end
	return nil
end

local function canPickupGun(player, previousHolder, playerData)
	if not player or player == previousHolder then
		return false
	end

	local data = playerData[player.Name]
	if not data then
		return false
	end

	return data.Role ~= "Murderer" and data.Dead == false
end

local function giveDroppedGun(drop, previousHolder, touchingPart, playerData, giveGun)
	if drop:GetAttribute("Collected") then
		return
	end

	local hero = resolveTouchingPlayer(touchingPart)
	if not canPickupGun(hero, previousHolder, playerData) then
		return
	end

	drop:SetAttribute("Collected", true)
	local heroData = playerData[hero.Name]
	if heroData then
		heroData.Role = "Hero"
	end
	Set:Fire(hero.Name, "Role", "Hero")
	drop:Destroy()

	if giveGun then
		giveGun(hero)
	end

	ReplicatedStorage.Remotes.Gameplay.PlayerDataChanged:FireAllClients(playerData)
end

local function createGunDrop(previousHolder, useRandomSpawn)
	if _G.RoundEnded then
		return nil
	end

	local template = ServerStorage:FindFirstChild("Gameplay") and ServerStorage.Gameplay:FindFirstChild("GunDrop")
	if not template then
		warn("[GunDrop] Missing ServerStorage.Gameplay.GunDrop")
		return nil
	end

	local playerData = getPlayerData()
	local giveGun = getGiveGun()
	local drop = template:Clone()
	drop.Name = "GunDrop"
	drop.CFrame = getDropCFrame(previousHolder, useRandomSpawn)
	drop:SetAttribute("Collected", false)
	drop.Parent = Workspace
	drop.Touched:Connect(function(touchedPart)
		giveDroppedGun(drop, previousHolder, touchedPart, playerData, giveGun)
	end)
	return drop
end

Module.PlayerRemoving = function(player)
	if Get("GameMode") ~= "Classic" then
		return
	end

	local playerData = getPlayerData()
	local data = playerData[player.Name]
	if not data or data.Dead then
		return
	end

	if data.Role == "Sheriff" or data.Role == "Hero" then
		createGunDrop(player, true)
		if data.Role == "Hero" then
			data.Role = "Innocent"
			Set:Fire(player.Name, "Role", "Innocent")
		end
	end

	data.Dead = true
	Set:Fire(player.Name, "Dead", true)
end

Module.Drop = function(victim)
	return createGunDrop(victim, false) or createGunDrop(victim, true)
end

return Module
