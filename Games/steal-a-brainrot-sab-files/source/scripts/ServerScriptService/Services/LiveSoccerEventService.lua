local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local Players             = game:GetService("Players")
local Workspace           = game:GetService("Workspace")
local HttpService         = game:GetService("HttpService")

local ReplicatorServer    = require(ReplicatedStorage.Packages.ReplicatorServer)
local Net                 = require(ReplicatedStorage.Packages.Net)

local burstRemote    = Net:RemoteEvent("LiveSoccerEvent/Burst")
local miniEventRemote = Net:RemoteEvent("LiveSoccerEvent/MiniEvent")

local ESPN_URL = "https://site.api.espn.com/apis/site/v2/sports/soccer/fifa.world/scoreboard"


local matchesReplicator = ReplicatorServer.get("LiveSoccerMatches", {
	matches = {},
})

local matches = {} 
local espnState = {}  


local AnimalService
local function getAnimalService()
	if not AnimalService then
		local ok, svc = pcall(function()
			return require(game.ServerScriptService.Services.AnimalService)
		end)
		if ok then
			AnimalService = svc
		end
	end
	return AnimalService
end

local function spawnGoalBrainrot()
	local svc = getAnimalService()
	if not svc then return nil end

	local animalName
	if math.random() <= 0.15 then
		animalName = "Esok Goala"  
	else
		animalName = "Hippo Golazo" 
	end

	pcall(function()
		svc.spawnAnimalCustom(animalName, nil, nil, 15, nil, nil, true, false, nil, nil, nil, nil, nil, true)
	end)
	return animalName
end


local function spawnRedCardBrainrot()
	local svc = getAnimalService()
	if not svc then return end

	pcall(function()
		svc.spawnAnimalCustom("Ref Ref Ref Sahur", nil, nil, 15, nil, nil, true, false, nil, nil, nil, nil, nil, true)
	end)
end

local function fireBurst(countryName)
	local scoreboard = Workspace:FindFirstChild("SoccerScoreBoard")
	if not scoreboard then return end
	local pos = scoreboard:GetPivot().Position + Vector3.new(0, 15, 0)
	burstRemote:FireAllClients(pos, countryName)
end

local function fireMiniEvent(countryName)
	miniEventRemote:FireAllClients(countryName, os.time() + 30)
end

local function parseISODate(dateStr)
	if not dateStr then return os.time() end
	local dt = DateTime.fromIsoDate(dateStr)
	if dt then
		return dt.UnixTimestamp
	end

	local cleaned = string.gsub(dateStr, "Z$", "+00:00")
	dt = DateTime.fromIsoDate(cleaned)
	if dt then
		return dt.UnixTimestamp
	end
	return os.time()
end

local function parseMatchMinute(detail)
	if not detail then return 0 end
	local minute = tonumber(string.match(detail, "(%d+)'"))
	return minute or 0
end


local function mapStatus(stateStr, detail)
	if stateStr == "pre" then
		return "upcoming", 0
	elseif stateStr == "in" then
		if detail and string.find(string.lower(detail), "halftime") then
			return "halftime", 45
		end
		return "live", parseMatchMinute(detail)
	elseif stateStr == "post" then
		return "finished", 90
	end
	return "upcoming", 0
end

local function fetchMatches()
	local success, response = pcall(function()
		return HttpService:GetAsync(ESPN_URL, true)
	end)
	if not success then
		return nil
	end

	local ok, data = pcall(function()
		return HttpService:JSONDecode(response)
	end)
	if not ok or not data then
		return nil
	end

	return data
end

local function processMatches()
	local data = fetchMatches()
	if not data then return end

	local events = data.events or {}
	local newMatches = {}
	local newEspnState = {}

	for _, event in ipairs(events) do
		local espnId = tostring(event.id)
		local comps = event.competitions and event.competitions[1]
		if not comps then continue end

		local competitors = comps.competitors or {}
		local home = competitors[1] or {}
		local away = competitors[2] or {}

		local homeName = (home.team and home.team.displayName) or "Unknown"
		local awayName = (away.team and away.team.displayName) or "Unknown"
		local homeScore = tonumber(home.score) or 0
		local awayScore = tonumber(away.score) or 0

		local statusInfo = (event.status and event.status.type) or {}
		local espnStatusStr = statusInfo.state or "pre"
		local detail = statusInfo.detail or ""
		local status, matchMinute = mapStatus(espnStatusStr, detail)

		local startUtc = parseISODate(event.date)

		local match = {
			matchId = espnId,
			homeName = homeName,
			awayName = awayName,
			homeScore = homeScore,
			awayScore = awayScore,
			status = status,
			matchMinute = matchMinute,
			startUtcSeconds = startUtc,
		}

		local prev = espnState[espnId]
		if prev then

			if homeScore > prev.homeScore then
				fireBurst(homeName)
				fireMiniEvent(homeName)
				spawnGoalBrainrot()
			elseif awayScore > prev.awayScore then
				fireBurst(awayName)
				fireMiniEvent(awayName)
				spawnGoalBrainrot()
			end


			local details = comps.details or {}
			local prevDetailCount = prev.detailCount or 0
			if #details > prevDetailCount then
				for i = prevDetailCount + 1, #details do
					local d = details[i]
					local dtype = (d.type and d.type.text) or ""
					if string.find(string.lower(dtype), "red card") then
						spawnRedCardBrainrot()
					end
				end
			end
		end


		newEspnState[espnId] = {
			homeScore = homeScore,
			awayScore = awayScore,
			detailCount = #(comps.details or {}),
		}

		table.insert(newMatches, match)
	end

	matches = newMatches
	espnState = newEspnState

	matchesReplicator:SetKey("matches", matches)
end

return {
	Start = function()

		Players.PlayerAdded:Connect(function(player)
			matchesReplicator:AddSubscriber(player)
		end)
		for _, player in Players:GetPlayers() do
			matchesReplicator:AddSubscriber(player)
		end


		processMatches()


		task.spawn(function()
			while true do
				processMatches()
				task.wait(30)
			end
		end)
	end,

	GetMatches = function()
		return matches
	end,

	StandaloneScore = function(teamName)
		fireBurst(teamName)
		fireMiniEvent(teamName)
		spawnGoalBrainrot()
		return true
	end,

	RandomBoard = function()
		return spawnGoalBrainrot()
	end,

	FireBurst = fireBurst,
	FireMiniEvent = fireMiniEvent,
	SpawnGoalBrainrot = spawnGoalBrainrot,
	SpawnRedCardBrainrot = spawnRedCardBrainrot,
}