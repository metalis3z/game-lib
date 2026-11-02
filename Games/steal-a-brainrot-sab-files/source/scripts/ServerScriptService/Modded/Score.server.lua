local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Net = require(ReplicatedStorage.Packages.Net)
local LiveSoccerEventService = require(ServerScriptService.Services.LiveSoccerEventService)

local AnimalService
local function getAnimalService()
	if not AnimalService then
		local ok, svc = pcall(function()
			return require(ServerScriptService.Services.AnimalService)
		end)
		if ok then
			AnimalService = svc
		end
	end
	return AnimalService
end

local goalSoundRemote = Net:RemoteEvent("LiveSoccerEvent/Goal")
local redCardSoundRemote = Net:RemoteEvent("LiveSoccerEvent/RedCard")
local remoteFunc = Net:RemoteFunction("AdminService/LiveSoccerScore")

remoteFunc.OnServerInvoke = function(player, teamName, brainrotName, mode)
	if not teamName or teamName == "" then
		return false, "Please select a team!"
	end

	if not mode or mode == "" then
		return false, "Please select a mode!"
	end

	LiveSoccerEventService.FireBurst(teamName)
	LiveSoccerEventService.FireMiniEvent(teamName)

	local modeLower = string.lower(mode)

	if modeLower == "goal" then
		goalSoundRemote:FireAllClients()

		if brainrotName and brainrotName ~= "" then
			local svc = getAnimalService()
			if svc then
				pcall(function()
					svc.spawnAnimalCustom(brainrotName, nil, nil, 15, nil, nil, true, false, nil, nil, nil, nil, "LiveSoccer", true)
				end)
			end
		else
			LiveSoccerEventService.SpawnGoalBrainrot()
		end
	elseif modeLower == "red card" then
		redCardSoundRemote:FireAllClients()

		if brainrotName and brainrotName ~= "" then
			local svc = getAnimalService()
			if svc then
				pcall(function()
					svc.spawnAnimalCustom(brainrotName, nil, nil, 15, nil, nil, true, false, nil, nil, nil, nil, "LiveSoccer", true)
				end)
			end
		else
			LiveSoccerEventService.SpawnRedCardBrainrot()
		end
	end

	return true
end