--credit to quartz games studio
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local LocalPlayer = Players.LocalPlayer
local v1 = CollectionService:HasTag(LocalPlayer, "PersistentLoaded") and true or false
local v2 = CollectionService:GetInstanceAddedSignal("PersistentLoaded"):Connect(function(p1) --[[ Line: 10 | Upvalues: LocalPlayer (copy), v1 (ref) ]]
	if p1 ~= LocalPlayer then
		return
	end

	v1 = true
end)
local v3 = workspace.PersistentLoaded:Connect(function() --[[ Line: 17 | Upvalues: v1 (ref) ]]
	v1 = true
end)
local v4, v5 = v2, v3

repeat
	task.wait()
until v1

if v4 then
	v4:Disconnect()
end

if v5 then
	v5:Disconnect()
end

repeat
	task.wait()
until game:IsLoaded()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Environment = require(ReplicatedStorage.SharedModules.Environment)
local Controllers = script.Parent:WaitForChild("Controllers")

local function runWatched(p1, p2, p3) --[[ runWatched | Line: 55 ]]
	local v1 = false
	local v2 = false
	local v3 = nil

	task.spawn(function() --[[ Line: 60 | Upvalues: v2 (ref), v3 (ref), p3 (copy), v1 (ref) ]]
		local ok, result = pcall(p3)

		v2 = ok
		v3 = result
		v1 = true
	end)

	local v4 = os.clock()
	local sum = 3

	while not v1 do
		task.wait(0.1)

		if v1 then
			break
		end

		local v5 = os.clock() - v4

		if v5 >= 30 then
			warn(string.format("%s \'%s\' %s exceeded %ds and was abandoned -- this controller likely yields forever (e.g. WaitForChild for an instance that never replicates). Continuing startup so the player can still load.", "[ControllerStarter]", p2, p1, 30))

			return false, "timeout"
		end

		if sum <= v5 then
			warn(string.format("%s \'%s\' still running %s after %.1fs -- this is blocking all remaining controllers and the loading screen.", "[ControllerStarter]", p2, p1, v5))
			sum = sum + 3
		end
	end

	local v6 = os.clock() - v4

	if v6 >= 1 then
		warn(string.format("%s \'%s\' %s took %.0fms.", "[ControllerStarter]", p2, p1, v6 * 1000))
	end

	if not v2 then
		warn(string.format("%s \'%s\' %s errored: %s", "[ControllerStarter]", p2, p1, (tostring(v3))))
	end

	return v2, v3
end

local v6 = os.clock()
local t = {}
local sum = 3

while not LocalPlayer.Character do
	task.wait(0.1)

	local v7 = os.clock() - v6

	if sum <= v7 then
		warn(string.format("%s Still waiting for the character to spawn after %.1fs -- spawn is gated on profile data load; controllers can\'t start until StarterGui has cloned into PlayerGui.", "[ControllerStarter]", v7))
		sum = sum + 3
	end
end

local v8 = os.clock()
local v9 = require

for v10, v11 in Controllers:GetChildren() do
	local v12, v13 = runWatched("require", v11.Name, function() --[[ Line: 133 | Upvalues: v9 (copy), v11 (copy) ]]
		return v9(v11)
	end)

	if v12 then
		table.insert(t, {
			name = v11.Name,
			module = v13
		})
	end
end

table.sort(t, function(p1, p2) --[[ Line: 143 ]]
	return (p1.module.StartOrder or 0) < (p2.module.StartOrder or 0)
end)

for v14, v15 in t do
	local v16 = if v15.module.Disabled then true else false

	if v15.module.Init and not (v16 or runWatched("Init", v15.name, function() --[[ Line: 152 | Upvalues: v15 (copy) ]]
		v15.module:Init()
	end)) then
		v15.failed = true
	end
end

for v17, v18 in t do
	if not (if v18.failed then true else false) and v18.module.Start then
		runWatched("Start", v18.name, function() --[[ Line: 166 | Upvalues: v18 (copy) ]]
			v18.module:Start()
		end)
	end
end

if RunService:IsStudio() or Environment.env == "Dev" then
	print(string.format("%s All controllers started in %.0fms (%d loaded).", "[ControllerStarter]", (os.clock() - v8) * 1000, #t))
end

LocalPlayer:AddTag("ControllersStarted")