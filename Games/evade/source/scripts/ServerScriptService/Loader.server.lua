--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)

require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("FFlags"))

local Conch = require(ReplicatedStorage.Packages.Conch)
require(ReplicatedStorage.Shared.ConchTypes)

task.spawn(function()
	require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("GameAnalytics"):WaitForChild("GameAnalytics"))
end)

Conch.initiate_default_lifecycle()

require(script.Parent.Modded)

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)

function SetupPlayer(object: Instance)
	if object:IsA("BasePart") then
		local part = object :: BasePart
		part.CollisionGroup = "Player"

		if part.Name == "LeftFoot" or part.Name == "RightFoot" then
			part.CustomPhysicalProperties = PhysicalProperties.new(0.68, 0.5, 1, 0.3, 1)
		elseif part.Name == "HumanoidRootPart" then
			part.CustomPhysicalProperties = PhysicalProperties.new(0.75, 0.5, 1, 0.3, 1)
		else
			part.Massless = true
		end
	end
end

Players.PlayerAdded:Connect(function(player: Player)
	player.CharacterAdded:Connect(function(character: Model)
		for _, part in ipairs(character:GetDescendants()) do
			SetupPlayer(part)
		end
		character.DescendantAdded:Connect(SetupPlayer)

		local humanoid = character:WaitForChild("Humanoid", 10)
		if humanoid then
			humanoid.Died:Once(function()
				Ragdoll.Ragdoll(character)
			end)
		end
	end)

	local playerChannel = Synchronizer:Wait(player)
	if not playerChannel then
		player:Kick("Error while loading data.")
		return
	end

	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstats"

	local Steals = Instance.new("NumberValue", leaderstats)
	Steals.Name = "Steals"
	Steals.Value = playerChannel:Get("Steals")

	local Rebirths = Instance.new("NumberValue", leaderstats)
	Rebirths.Name = "Rebirths"
	Rebirths.Value = playerChannel:Get("Rebirth")

	local currentCash = playerChannel:Get("Coins")

	local Cash = Instance.new("NumberValue", leaderstats)
	Cash.Name = "Cash"
	Cash.Value = currentCash

	Synchronizer:WaitAndCall(player, function(callback)
		callback:OnChanged("Steals", function(amount: number)
			Steals.Value = amount
		end)

		callback:OnChanged("Rebirth", function(amount: number)
			Rebirths.Value = amount
		end)

		callback:OnChanged("Coins", function(amount: number)
			Cash.Value = amount
		end)
	end)
end)

local ServerScriptService = game:GetService("ServerScriptService")
local ServicesFolder = ServerScriptService:FindFirstChild("Services")
if not ServicesFolder then
	ServicesFolder = ReplicatedStorage:WaitForChild("Controllers")
end

local LoadedModules = {}
local modulesRequiredCount = 0
local modulesLoadedCount = 0

for _, module in ServicesFolder:GetChildren() do
	if module:IsA("ModuleScript") then
		local timedOut = false
		task.delay(10, function()
			if not timedOut then
				warn(("Module %s is taking too long to Require"):format(module:GetFullName()))
			end
		end)

		local success, result
		task.spawn(function()
			debug.setmemorycategory(module.Name)
			success, result = xpcall(require, warn, module)
		end)

		while success == nil do
			task.wait()
		end
		timedOut = true

		if success then
			LoadedModules[module.Name] = result
			modulesRequiredCount = modulesRequiredCount + 1
		end
	end
end

for name, mod in LoadedModules do
	task.spawn(function()
		debug.setmemorycategory(name)
		local timedOut = false
		task.delay(10, function()
			if not timedOut then
				warn(("Module %s is taking too long to Load"):format(name))
			end
		end)
		if mod.Load then
			mod:Load()
		end
		timedOut = true
		modulesLoadedCount = modulesLoadedCount + 1
	end)
end

while modulesRequiredCount ~= modulesLoadedCount do
	task.wait()
end

ReplicatedStorage:SetAttribute("EndTimeBB", 1762374954.473)

for name, mod in LoadedModules do
	task.spawn(function()
		debug.setmemorycategory(name)
		if mod.Start then
			mod:Start()
		end
	end)
end