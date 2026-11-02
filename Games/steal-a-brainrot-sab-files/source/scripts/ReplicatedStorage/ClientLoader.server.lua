local GAME_START_TIME = os.clock()

if not workspace:FindFirstChild("Map"):FindFirstChild("__StreamCheck_DontDelete"):FindFirstChild("Part") then
	if not workspace:FindFirstChild("Map"):FindFirstChild("Collisions") then
		workspace.PersistentLoaded:Wait()
		print("[STREAMING ENABLED BUILD]: PersistentModels loaded")
	end
else
	print("[STREAMING DISABLED BUILD]: Client starting")
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local LoadedModules = {}
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local requiredCount = 0
local loadedCount = 0
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local RequireTimes = {}
local LoadTimes = {}
local StartTimes = {}

for _, gui in ReplicatedStorage:WaitForChild("ReplicatedGui"):GetChildren() do
	gui.Parent = PlayerGui
end

task.spawn(require, ReplicatedStorage.Packages.PlayerMouse)
task.spawn(require, script.UIStrokeAdjuster)
task.spawn(require, ReplicatedStorage.Packages.FFlags)
task.spawn(require, ReplicatedStorage.Packages.Net)
task.spawn(require, ReplicatedStorage.Packages.Debounce)

local requirePhaseStart = os.clock()

for _, controller in Controllers:GetChildren() do
	if controller:IsA("ModuleScript") then
		local finishedRequire = false

		task.delay(10, function()
			if not finishedRequire then
				warn(`[ClientLoader] Module {controller:GetFullName()} is taking too long to Require`)
			end
		end)

		local success = nil
		local result = nil
		local moduleStart = os.clock()

		task.spawn(function()
			debug.setmemorycategory(controller.Name)
			local ok, res = xpcall(require, warn, controller)
			success = ok
			result = res
		end)

		while success == nil do
			task.wait()
		end

		local elapsed = os.clock() - moduleStart
		finishedRequire = true

		RequireTimes[controller.Name] = elapsed
	
		if success then
			LoadedModules[controller.Name] = result
			requiredCount += 1
		end
	end
end


local loadPhaseStart = os.clock()

for name, mod in LoadedModules do
	task.spawn(function()
		debug.setmemorycategory(name)

		local finishedLoad = false
		task.delay(10, function()
			if not finishedLoad then
				warn(`[ClientLoader] Module {name} is taking too long to Load`)
			end
		end)

		if mod.Load then
			local loadStart = os.clock()
			mod:Load()
			local elapsed = os.clock() - loadStart
			LoadTimes[name] = elapsed
		else
			LoadTimes[name] = 0
		end

		finishedLoad = true
		loadedCount += 1
	end)
end

while requiredCount ~= loadedCount do
	task.wait()
end


local summary = {}
for name in LoadedModules do
	local req = RequireTimes[name] or 0
	local load = LoadTimes[name] or 0
	table.insert(summary, { name = name, require = req, load = load, total = req + load })
end
table.sort(summary, function(a, b) return a.total > b.total end)

local CLIENT_LOADED_TIME = os.clock()

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
			local startBegin = os.clock()
			mod:Start()
			StartTimes[name] = os.clock() - startBegin
			startDone += 1
		end
	end)
end


task.spawn(function()
	local deadline = os.clock() + 20
	while startDone < startTotal and os.clock() < deadline do
		task.wait()
	end

	local startSummary = {}
	for name, t in StartTimes do
		table.insert(startSummary, { name = name, t = t })
	end
	table.sort(startSummary, function(a, b) return a.t > b.t end)

	for name, mod in LoadedModules do
		if mod.Start and StartTimes[name] == nil then
			warn(("[ClientLoader] Module %s Start() has not returned (still running / yielding) -- possible cause of lag"):format(name))
		end
	end
end)

for _, component in ReplicatedStorage:WaitForChild("Components"):GetChildren() do
	if component:IsA("ModuleScript") then
		xpcall(require, warn, component)
	end
end

for _, toolScript in ReplicatedStorage:WaitForChild("ClientToolScripts"):GetChildren() do
	if toolScript:IsA("Script") then
		toolScript.Enabled = true
	end
end

require(ReplicatedStorage.Packages.ReplicatorClient).init()