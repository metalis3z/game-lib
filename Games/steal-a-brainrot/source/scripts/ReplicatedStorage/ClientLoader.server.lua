local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

do
	local Map = Workspace:FindFirstChild("Map")
	if Map then
		local StreamCheck = Map:FindFirstChild("__StreamCheck_DontDelete")
		if StreamCheck and StreamCheck:FindFirstChild("Part") then
			print("[STREAMING DISABLED BUILD]: Client starting")
		elseif not Map:FindFirstChild("Collisions") and Workspace:FindFirstChild("PersistentLoaded") then
			Workspace.PersistentLoaded:Wait()
			print("[STREAMING ENABLED BUILD]: PersistentModels loaded")
		end
	end
end

local Controllers = {}
local RequiredCount = 0
local LoadedCount = 0

local ControllersFolder = ReplicatedStorage:WaitForChild("Controllers")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local ReplicatedGuiFolder = ReplicatedStorage:WaitForChild("ReplicatedGui")
for Index, GuiObject in ipairs(ReplicatedGuiFolder:GetChildren()) do
	GuiObject.Parent = PlayerGui
end

task.spawn(require, script.UIStrokeAdjuster)
task.spawn(require, ReplicatedStorage.Packages.PlayerMouse)
task.spawn(require, ReplicatedStorage.Packages.FFlags)
task.spawn(require, ReplicatedStorage.Packages.Net)
task.spawn(require, ReplicatedStorage.Packages.Debounce)

-- Chargement séquentiel des controllers
for Index, ControllerModule in ipairs(ControllersFolder:GetChildren()) do
	if ControllerModule:IsA("ModuleScript") then
		local Finished = false
		task.delay(15, function()
			if not Finished then
				warn(("Module %s is taking too long to Require"):format(ControllerModule:GetFullName()))
			end
		end)
		debug.setmemorycategory(ControllerModule.Name)
		local Ok, Res = xpcall(require, warn, ControllerModule)
		Finished = true
		if Ok then
			Controllers[ControllerModule.Name] = Res
			RequiredCount += 1
		end
	end
end

for ControllerName, Controller in pairs(Controllers) do
	task.spawn(function()
		debug.setmemorycategory(ControllerName)

		local Finished = false
		task.delay(10, function()
			if not Finished then
				warn(("Module %s is taking too long to Load"):format(ControllerName))
			end
		end)

		if Controller.Load then
			Controller:Load()
		end

		Finished = true
		LoadedCount += 1
	end)
end

while RequiredCount ~= LoadedCount do
	task.wait()
end

for ControllerName, Controller in pairs(Controllers) do
	task.spawn(function()
		debug.setmemorycategory(ControllerName)
		if Controller.Start then
			Controller:Start()
		end
	end)
end

local ComponentsFolder = ReplicatedStorage:WaitForChild("Components")
for Index, ComponentModule in ipairs(ComponentsFolder:GetChildren()) do
	if ComponentModule:IsA("ModuleScript") then
		xpcall(require, warn, ComponentModule)
	end
end

local ClientToolScriptsFolder = ReplicatedStorage:WaitForChild("ClientToolScripts")
for Index, ToolScript in ipairs(ClientToolScriptsFolder:GetChildren()) do
	if ToolScript:IsA("Script") then
		ToolScript.Enabled = true
	end
end

require(ReplicatedStorage.Packages.ReplicatorClient).init()