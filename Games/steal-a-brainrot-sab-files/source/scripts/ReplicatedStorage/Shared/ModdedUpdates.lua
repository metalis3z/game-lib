local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")

require(ReplicatedStorage.Datas.ServerData)
local FFlags = require(Packages.FFlags)
local Signal = require(Packages.Signal)
local Timer = require(Packages.Timer)
local RunService = game:GetService("RunService")
local ModdedUpdates = {
	["List"] = {},
	["Methods"] = {},
	["OnUpdateEnabled"] = Signal.new(),
	["OnUpdateDisabled"] = Signal.new()
}

function ModdedUpdates.Methods.IsEnabled(updateName)
	local updateData = ModdedUpdates.List[updateName]
	if updateData then
		local activationTime = FFlags:GetInstant(updateData.FFlag, updateData.UnixTimeStamp)
		local currentTime = workspace:GetServerTimeNow()
		local isEnabled = currentTime >= activationTime
		return isEnabled
	else
		warn("[ModdedUpdates] Update name not found in List: " .. tostring(updateName))
		return false
	end
end

function ModdedUpdates.Methods.GetUpdateTime(updateName)
	local updateData = ModdedUpdates.List[updateName]
	if updateData then
		return FFlags:GetInstant(updateData.FFlag, updateData.UnixTimeStamp)
	end
end

function ModdedUpdates.Methods.GetTimeLeft(updateName)
	local updateData = ModdedUpdates.List[updateName]
	if updateData then
		local activationTime = FFlags:GetInstant(updateData.FFlag, updateData.UnixTimeStamp)
		return activationTime - workspace:GetServerTimeNow()
	end
end

ModdedUpdates.List["Update-05/24/2026"] = {
	["UnixTimeStamp"] = RunService:IsStudio() and 0 or 1779652800,
	["FFlag"] = "Update-05/24/2026",
}
ModdedUpdates.List["Update-05/31/2026"] = {
	["UnixTimeStamp"] = RunService:IsStudio() and 0 or 1780257600,
	["FFlag"] = "Update-05/31/2026",
}
(function()
	local updateCheckerTimer = Timer.new(1)
	local activeUpdatesCache = {}

	updateCheckerTimer.Tick:Connect(function()
		for name, data in ModdedUpdates.List do
			local isCurrentlyEnabled = ModdedUpdates.Methods.IsEnabled(name)

			if activeUpdatesCache[name] then
				if activeUpdatesCache[name] ~= FFlags:GetInstant(data.FFlag, data.UnixTimeStamp) and not isCurrentlyEnabled then
					activeUpdatesCache[name] = nil
					ModdedUpdates.OnUpdateDisabled:Fire(name)
				end
			elseif isCurrentlyEnabled then
				activeUpdatesCache[name] = FFlags:GetInstant(data.FFlag, data.UnixTimeStamp)
				ModdedUpdates.OnUpdateEnabled:Fire(name)
			end
		end
	end)

	updateCheckerTimer:Start()

	for name, data in ModdedUpdates.List do
		if not ModdedUpdates.Methods.IsEnabled(name) then
			task.spawn(function()
				while not ModdedUpdates.Methods.IsEnabled(name) do
					local timeLeft = FFlags:GetInstant(data.FFlag, data.UnixTimeStamp) - workspace:GetServerTimeNow()
					task.wait(math.clamp(timeLeft, 0.1, 5))
				end
				ModdedUpdates.OnUpdateEnabled:Fire(name)
			end)
		end
	end
end)()

return ModdedUpdates