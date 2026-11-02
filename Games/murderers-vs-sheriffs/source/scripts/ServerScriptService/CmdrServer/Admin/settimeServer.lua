local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local function getRoundState()
	local roundState = ServerStorage:FindFirstChild("RoundState")
	if not roundState then
		return nil, nil
	end

	return roundState:FindFirstChild("RoundActive"), roundState:FindFirstChild("TimeRemaining")
end

local function getRoundTimeRemote()
	local remotes = ReplicatedStorage:FindFirstChild("Remotes")
	local gameplay = remotes and remotes:FindFirstChild("Gameplay")
	if not gameplay then
		return nil
	end

	local remote = gameplay:FindFirstChild("RoundTimeUpdated")
	if not remote then
		remote = Instance.new("RemoteEvent")
		remote.Name = "RoundTimeUpdated"
		remote.Parent = gameplay
	end

	return remote
end

return function(_, seconds)
	local amount = tonumber(seconds)
	if not amount then
		return "Usage: settime <seconds>"
	end

	amount = math.floor(amount)
	if amount <= 0 then
		return "Settime only adds time. Use a number greater than 0."
	end

	local roundActive, timeRemaining = getRoundState()
	if not (roundActive and timeRemaining) then
		return "Round timer is not ready yet."
	end

	if roundActive.Value ~= true then
		return "Settime only works while a round is playing."
	end

	local newTime = math.max(0, math.floor(timeRemaining.Value)) + amount
	timeRemaining.Value = newTime

	if _G.GameVariables then
		_G.GameVariables["GameTimer"] = newTime
	end

	local remote = getRoundTimeRemote()
	if remote then
		remote:FireAllClients(newTime)
	end

	return "Added " .. amount .. " seconds. Round time is now " .. newTime .. " seconds."
end