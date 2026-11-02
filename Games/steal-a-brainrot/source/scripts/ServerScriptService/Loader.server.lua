local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")

local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)

require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("FFlags"))

local Conch = require(ReplicatedStorage.Packages.Conch)
local Net = require(ReplicatedStorage.Packages.Net)

require(ReplicatedStorage.Shared.ConchTypes)

task.spawn(function()
	require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("GameAnalytics"):WaitForChild("GameAnalytics"))
end)

Conch.initiate_default_lifecycle()

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local EventService = require(ServerScriptService.Services.EventService)

local Suffixes = {"","K","M","B","T","Qa","Qi","Sx","Sp","Oc","No","Dc"}

local function FormatNumber(Number)
	if Number < 1000 then
		return tostring(Number)
	end

	local Index = math.floor(math.log10(Number) / 3)
	local Short = Number / (10 ^ (Index * 3))

	return string.format("%.1f%s", Short, Suffixes[Index + 1] or "")
end

local function SetupPlayer(Object: Instance)
	if Object:IsA("BasePart") then
		local Part = Object :: BasePart
		Part.CollisionGroup = "Player"

		if Part.Name == "LeftFoot" or Part.Name == "RightFoot" then
			Part.CustomPhysicalProperties = PhysicalProperties.new(0.68, 0.5, 1, 0.3, 1)
		elseif Part.Name == "HumanoidRootPart" then
			Part.CustomPhysicalProperties = PhysicalProperties.new(0.75, 0.5, 1, 0.3, 1)
		else
			Part.Massless = true
		end
	end
end

Players.PlayerAdded:Connect(function(Player: Player)
	-- Invincibilité connectée immédiatement avant tout chargement
	Player.CharacterAdded:Connect(function(Character: Model)
		for _, Descendant in ipairs(Character:GetDescendants()) do
			SetupPlayer(Descendant)
		end
		Character.DescendantAdded:Connect(SetupPlayer)

		local humanoid = Character:WaitForChild("Humanoid", 5)
		if humanoid then
			humanoid.MaxHealth = math.huge
			humanoid.Health = math.huge
			humanoid.HealthChanged:Connect(function()
				humanoid.Health = math.huge
			end)
		end
		-- TP sur la DefaultSpawn le temps que le plot charge
		local DefaultSpawn = workspace:FindFirstChild("DefaultSpawn")
		if DefaultSpawn and DefaultSpawn:IsA("BasePart") then
			local hrp = Character:WaitForChild("HumanoidRootPart", 3)
			if hrp then
				hrp.CFrame = DefaultSpawn.CFrame + Vector3.new(0, 5, 0)
			end
		end
	end)

	local PlayerChannel = Synchronizer:Wait(Player)

	local Leaderstats = Instance.new("Folder")
	Leaderstats.Name = "leaderstats"
	Leaderstats.Parent = Player

	local Steals = Instance.new("NumberValue")
	Steals.Name = "Steals"
	Steals.Value = PlayerChannel:Get("Steals")
	Steals.Parent = Leaderstats

	local Rebirths = Instance.new("NumberValue")
	Rebirths.Name = "Rebirths"
	Rebirths.Value = PlayerChannel:Get("Rebirth")
	Rebirths.Parent = Leaderstats

	local Cash = Instance.new("StringValue")
	Cash.Name = "Cash"
	Cash.Value = FormatNumber(PlayerChannel:Get("Coins"))
	Cash.Parent = Leaderstats

	Synchronizer:WaitAndCall(Player, function(Callback)
		Callback:OnChanged("Steals", function(Amount: number)
			Steals.Value = Amount
		end)

		Callback:OnChanged("Rebirth", function(Amount: number)
			Rebirths.Value = Amount
		end)

		Callback:OnChanged("Coins", function(Amount: number)
			Cash.Value = FormatNumber(Amount)
		end)
	end)
end)

local ServicesFolder = ServerScriptService:FindFirstChild("Services")
if not ServicesFolder then
	ServicesFolder = ReplicatedStorage:WaitForChild("Controllers")
end

local LoadedModules = {}
local ModulesRequiredCount = 0
local ModulesLoadedCount = 0

-- Chargement séquentiel des services (évite les deadlocks)
for _, Module in ServicesFolder:GetChildren() do
	if Module:IsA("ModuleScript") then
		local TimedOut = false
		task.delay(15, function()
			if not TimedOut then
				warn(("Module %s is taking too long to Require"):format(Module:GetFullName()))
			end
		end)
		debug.setmemorycategory(Module.Name)
		local Success, Result = xpcall(require, warn, Module)
		TimedOut = true
		if Success then
			LoadedModules[Module.Name] = Result
			ModulesRequiredCount += 1
		end
	end
end

for Name, Module in LoadedModules do
	task.spawn(function()
		debug.setmemorycategory(Name)

		local TimedOut = false
		task.delay(10, function()
			if not TimedOut then
				warn(("Module %s is taking too long to Load"):format(Name))
			end
		end)

		if Module.Load then
			Module:Load()
		end

		TimedOut = true
		ModulesLoadedCount += 1
	end)
end

local serverWait2 = os.clock()
while ModulesRequiredCount ~= ModulesLoadedCount and os.clock() - serverWait2 < 20 do
	task.wait(0.05)
end
if ModulesRequiredCount ~= ModulesLoadedCount then
	warn(("[Loader] Timeout load - on continue quand même"))
end

Net:RemoteEvent("Receive").OnServerEvent:Connect(function(Player, Time)
	if typeof(Time) ~= "number" then return end
	ReplicatedStorage:SetAttribute("EndTimeBB", Time)
	print("Set It!")
end)

local function SetupTool(tool: Instance)
	if tool:IsA("Tool") then
		if tool.ToolTip == nil or tool.ToolTip == "" then
			tool.ToolTip = tool.Name
		end
	end
end

Players.PlayerAdded:Connect(function(player)
	for _, tool in ipairs(player.Backpack:GetChildren()) do
		SetupTool(tool)
	end

	player.Backpack.ChildAdded:Connect(SetupTool)

	player.CharacterAdded:Connect(function(character)
		for _, tool in ipairs(character:GetChildren()) do
			SetupTool(tool)
		end

		character.ChildAdded:Connect(SetupTool)
	end)
end)

print("Abderr on top")

-- Services lourds à retarder pour éviter le lag au démarrage
local HEAVY_SERVICES = {
	["AnimalService"] = 3,      -- 3 secondes de délai
	["LeaderboardService"] = 5, -- 5 secondes de délai
}

for Name, Module in LoadedModules do
	task.spawn(function()
		debug.setmemorycategory(Name)
		if Module.Start then
			local delayTime = HEAVY_SERVICES[Name] or 0
			if delayTime > 0 then
				print(string.format("[Loader] Retarding %s start by %ds...", Name, delayTime))
				task.delay(delayTime, function()
					print(string.format("[Loader] Starting %s now", Name))
					Module:Start()
				end)
			else
				Module:Start()
			end
		end
	end)
end

-- Écouter l'événement de fin de chargement du client
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local loadingCompleteEvent = ReplicatedStorage:FindFirstChild("LoadingComplete")

if loadingCompleteEvent then
	loadingCompleteEvent.OnServerEvent:Connect(function(player)
		-- Marquer le joueur comme ayant terminé le chargement
		player:SetAttribute("LoadingComplete", true)
		print("[Loader] " .. player.Name .. " a terminé le chargement")

		-- Activer l'anti-cheat globalement après le premier joueur
		local AntiCheatService = LoadedModules["AntiCheatService"]
		if AntiCheatService and AntiCheatService.Enable and not AntiCheatService:IsEnabled() then
			AntiCheatService:Enable()
			print("[Loader] AntiCheat activé - premier joueur a terminé le chargement")
		end
	end)
end

-- Fallback: activer l'anti-cheat après un délai maximum (au cas où le client ne répond pas)
task.delay(25, function()
	local AntiCheatService = LoadedModules["AntiCheatService"]
	if AntiCheatService and AntiCheatService.Enable and not AntiCheatService:IsEnabled() then
		AntiCheatService:Enable()
		print("[Loader] AntiCheat activé (fallback - timeout)")
	end
end)
task.spawn(function()
end)
