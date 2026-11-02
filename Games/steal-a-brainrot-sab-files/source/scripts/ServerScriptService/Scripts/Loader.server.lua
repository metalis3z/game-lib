--!strict

local GAME_START_TIME = os.clock()
print("[Loader] Game loading started at:", GAME_START_TIME)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local Ragdoll = require(ReplicatedStorage.Packages.Ragdoll)

require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("FFlags"))

local ReplicatorServer = require(ReplicatedStorage.Packages.ReplicatorServer)
ReplicatorServer.init()

local Conch = require(ReplicatedStorage.Packages.Conch)
require(ReplicatedStorage.Shared.ConchTypes)

task.spawn(function()
	require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("GameAnalytics"):WaitForChild("GameAnalytics"))
end)

Conch.initiate_default_lifecycle()

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

local LoadedModules: { [string]: any } = {}
local PRIORITY_MODULES = {"DataService", "PlotService", "AnimalService"}

local RequireTimes: { [string]: number } = {}
local LoadTimes: { [string]: number } = {}
local StartTimes: { [string]: number } = {}

local function safeResume(thread: thread)
	if coroutine.status(thread) == "suspended" then
		task.spawn(thread)
	end
end

local function requireSync(module: ModuleScript): (boolean, any)
	local callingThread = coroutine.running()
	local success, result
	local done = false

	local timedOut = false
	task.delay(10, function()
		if not timedOut then
			warn(("Module %s is taking too long to Require"):format(module:GetFullName()))
		end
	end)

	task.spawn(function()
		debug.setmemorycategory(module.Name)
		success, result = xpcall(require, function(err)
			warn(("Module %s failed: %s"):format(module:GetFullName(), err))
		end, module)
		timedOut = true
		done = true
		safeResume(callingThread)
	end)

	if not done then
		coroutine.yield()
	end

	return success, result
end

local function requireAndLoad(module: ModuleScript)
	local startTime = os.clock()

	local success, result = requireSync(module)
	local requireEndTime = os.clock()
	RequireTimes[module.Name] = requireEndTime - startTime
	print(("[Loader] Module %s required in %.3f seconds"):format(module.Name, requireEndTime - startTime))
	if not success then return end

	LoadedModules[module.Name] = result

	if result.Load then
		local timedOut = false
		task.delay(10, function()
			if not timedOut then
				warn(("Module %s is taking too long to Load"):format(module:GetFullName()))
			end
		end)

		local loadStartTime = os.clock()
		result:Load()
		local loadEndTime = os.clock()
		timedOut = true
		LoadTimes[module.Name] = loadEndTime - loadStartTime
		print(("[Loader] Module %s loaded in %.3f seconds"):format(module.Name, loadEndTime - loadStartTime))
	end

end

for _, name in PRIORITY_MODULES do
	local module = ServicesFolder:FindFirstChild(name)
	if module and module:IsA("ModuleScript") then
		requireAndLoad(module)
	end
end

local mainThread = coroutine.running()
local pendingCount = 0

for _, module in ServicesFolder:GetChildren() do
	if module:IsA("ModuleScript") and not table.find(PRIORITY_MODULES, module.Name) then
		pendingCount += 1
		task.spawn(function()
			local reqStart = os.clock()
			local success, result = requireSync(module)
			local reqEnd = os.clock()
			RequireTimes[module.Name] = reqEnd - reqStart
			print(("[Loader] Module %s required in %.3f seconds"):format(module.Name, reqEnd - reqStart))
			if success then
				LoadedModules[module.Name] = result
			end
			pendingCount -= 1
			if pendingCount == 0 then
				safeResume(mainThread)
			end
		end)
	end
end

if pendingCount > 0 then
	coroutine.yield()
end

local loadThread = coroutine.running()
local pendingLoads = 0

for name, mod in LoadedModules do
	if not table.find(PRIORITY_MODULES, name) then
		pendingLoads += 1
		task.spawn(function()
			debug.setmemorycategory(name)
			local timedOut = false
			task.delay(10, function()
				if not timedOut then
					warn(("Module %s is taking too long to Load"):format(name))
				end
			end)
			if mod.Load then
				local loadStart = os.clock()
				mod:Load()
				local loadEnd = os.clock()
				LoadTimes[name] = loadEnd - loadStart
				print(("[Loader] Module %s loaded in %.3f seconds"):format(name, loadEnd - loadStart))
			end
			timedOut = true
			pendingLoads -= 1
			if pendingLoads == 0 then
				safeResume(loadThread)
			end
		end)
	end
end

if pendingLoads > 0 then
	coroutine.yield()
end

ReplicatedStorage:SetAttribute("EndTimeBB", 1762374954.473)

local GAME_END_TIME = os.clock()
print(("[Loader] ========== GAME FULLY LOADED IN %.3f seconds =========="):format(GAME_END_TIME - GAME_START_TIME))

local summary: { { name: string, require: number, load: number, total: number } } = {}
for name in LoadedModules do
	local r = RequireTimes[name] or 0
	local l = LoadTimes[name] or 0
	table.insert(summary, { name = name, require = r, load = l, total = r + l })
end
table.sort(summary, function(a, b)
	return a.total > b.total
end)

print(("[Loader] ===== Module load summary (slowest first), %d modules ====="):format(#summary))
for _, e in summary do
	print(("[Loader]   %-28s require %.3fs | load %.3fs | total %.3fs"):format(e.name, e.require, e.load, e.total))
end

local startTotal = 0
local startDone = 0
for _, mod in LoadedModules do
	if mod.Start then
		startTotal += 1
	end
end

for name, mod in LoadedModules do
	task.spawn(function()
		debug.setmemorycategory(name)
		if mod.Start then
			local s = os.clock()
			mod:Start()
			StartTimes[name] = os.clock() - s
			startDone += 1
		end
	end)
end

task.spawn(function()
	local deadline = os.clock() + 20
	while startDone < startTotal and os.clock() < deadline do
		task.wait()
	end

	local startSummary: { { name: string, t: number } } = {}
	for name, t in StartTimes do
		table.insert(startSummary, { name = name, t = t })
	end
	table.sort(startSummary, function(a, b)
		return a.t > b.t
	end)

	print("[Loader] ===== Start() summary (slowest first) =====")
	for _, e in startSummary do
		print(("[Loader]   %-28s start %.3fs"):format(e.name, e.t))
	end

	for name, mod in LoadedModules do
		if mod.Start and StartTimes[name] == nil then
			warn(("[Loader] Module %s Start() has not returned (still running / yielding) -- possible cause of lag"):format(name))
		end
	end
end)