local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")

require(ReplicatedStorage.Datas.ServerData)

local FFlags = require(Packages.FFlags)
local Signal = require(Packages.Signal)
local Timer = require(Packages.Timer)

local Updates = {
	List = {},
	Methods = {},
	OnUpdateEnabled = Signal.new(),
	OnUpdateDisabled = Signal.new(),
}

function Updates.Methods.IsEnabled(updateName)
	local update = Updates.List[updateName]
	if not update then
		return false
	end

	return workspace:GetServerTimeNow()
		>= FFlags:GetInstant(update.FFlag, update.UnixTimeStamp)
end

function Updates.Methods.GetUpdateTime(updateName)
	local update = Updates.List[updateName]
	if update then
		return FFlags:GetInstant(update.FFlag, update.UnixTimeStamp)
	end
end

function Updates.Methods.GetTimeLeft(updateName)
	local update = Updates.List[updateName]
	if update then
		return FFlags:GetInstant(update.FFlag, update.UnixTimeStamp)
		- workspace:GetServerTimeNow()
	end
end

Updates.List["Update-03/17/2026"] = {
	UnixTimeStamp = 1773784800,
	FFlag = "Update-03/17/2026",
}

do
	local updateTimer = Timer.new(1)
	local lastKnownStates = {}

	updateTimer.Tick:Connect(function()
		for updateName, updateData in pairs(Updates.List) do
			local currentFlagTime = FFlags:GetInstant(
				updateData.FFlag,
				updateData.UnixTimeStamp
			)

			if lastKnownStates[updateName] then
				if lastKnownStates[updateName] ~= currentFlagTime
					and not Updates.Methods.IsEnabled(updateName)
				then
					lastKnownStates[updateName] = nil
					Updates.OnUpdateDisabled:Fire(updateName)
				end
			elseif Updates.Methods.IsEnabled(updateName) then
				lastKnownStates[updateName] = currentFlagTime
				Updates.OnUpdateEnabled:Fire(updateName)
			end
		end
	end)

	updateTimer:Start()

	for updateName, updateData in pairs(Updates.List) do
		if Updates.Methods.IsEnabled(updateName) then
			Updates.OnUpdateEnabled:Fire(updateName)
		else
			task.spawn(function()
				while not Updates.Methods.IsEnabled(updateName) do
					local timeLeft =
						FFlags:GetInstant(updateData.FFlag, updateData.UnixTimeStamp)
					- workspace:GetServerTimeNow()

					task.wait(math.clamp(timeLeft, 0.01, math.huge))
				end

				Updates.OnUpdateEnabled:Fire(updateName)
			end)
		end
	end
end

return Updates