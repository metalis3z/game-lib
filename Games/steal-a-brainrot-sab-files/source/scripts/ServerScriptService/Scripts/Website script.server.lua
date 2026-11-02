local HttpService       = game:GetService("HttpService")
local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Synchronizer      = require(ReplicatedStorage.Packages.Synchronizer)

local SITE_URL   = "https://heartfelt-dieffenbachia-e5e908.netlify.app/api/update"
local SECRET_KEY = "BrotinhoGamesTestSubject872"
local SYNC_EVERY = 5
task.wait(10)
local playerCache = {}

local function safeGet(channel, key)
	local ok, val = pcall(function() return channel:Get(key) end)
	if ok then return val end
	return nil
end

local function capturePlayer(player, overrideOnline)
	local channel = Synchronizer:Get(player)

	local podiums  = {}
	local rebirths = 0

	if channel then
		local rawPodiums = safeGet(channel, "AnimalPodiums") or {}
		rebirths = safeGet(channel, "Rebirths") or 0

		for _, pd in pairs(rawPodiums) do
			if type(pd) ~= "table" or not pd.Index then continue end

			local traits = {}
			if type(pd.Traits) == "table" then
				for _, t in ipairs(pd.Traits) do
					if type(t) == "string" then
						table.insert(traits, t)
					end
				end
			elseif type(pd.Traits) == "string" then
				local ok2, decoded = pcall(HttpService.JSONDecode, HttpService, pd.Traits)
				if ok2 and type(decoded) == "table" then
					for _, t in ipairs(decoded) do
						if type(t) == "string" then
							table.insert(traits, t)
						end
					end
				end
			end

			table.insert(podiums, {
				index    = pd.Index,
				mutation = pd.Mutation,
				traits   = traits,
			})
		end
	elseif playerCache[player.UserId] then
		local cached = playerCache[player.UserId]
		podiums  = cached.podiums
		rebirths = cached.rebirths
	end

	local data = {
		userId   = tostring(player.UserId),
		username = player.Name,
		podiums  = podiums,
		rebirths = rebirths,
		online   = overrideOnline ~= nil and overrideOnline or true,
	}

	playerCache[player.UserId] = {
		podiums  = podiums,
		rebirths = rebirths,
	}

	return data
end

local function sendBatch(playerList)
	if #playerList == 0 then return end

	local ok, body = pcall(HttpService.JSONEncode, HttpService, { players = playerList })
	if not ok then
		warn("[Tracker] JSON encode error:", body)
		return
	end

	local ok2, resp = pcall(function()
		return HttpService:RequestAsync({
			Url    = SITE_URL,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json",
				["x-secret"]     = SECRET_KEY,
			},
			Body = body,
		})
	end)

	if not ok2 then
		warn("HTTP error:", resp)
		return
	end

	if not resp.Success then
		warn("ERROR", resp.StatusCode, resp.Body)
	end
end

Players.PlayerRemoving:Connect(function(player)
	task.spawn(function()
		task.wait(0.05) 
		local data = capturePlayer(player, false)
		sendBatch({ data })
		task.delay(10, function()
			playerCache[player.UserId] = nil
		end)
	end)
end)

while true do
	local batch = {}
	for _, player in ipairs(Players:GetPlayers()) do
		local ok, data = pcall(capturePlayer, player, true)
		if ok and data then
			table.insert(batch, data)
		end
	end

	if #batch > 0 then
		sendBatch(batch)
	end

	task.wait(SYNC_EVERY)
end