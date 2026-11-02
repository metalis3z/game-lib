-- Cutscene-Event : des cinématiques qui lancent un event (ou un mini-jeu) quand elles se terminent.
-- Panneau admin (F2) > onglet "Cutscene-Event" (StarterPlayerScripts.AdminCutsceneEventsTab).
-- Pour en ajouter une : une entrée dans COMBOS (Play lance la cinématique sur ce serveur, Length = sa durée, puis Then).
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local MessagingService = game:GetService("MessagingService")

local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local bindables = ServerStorage:WaitForChild("GameBindables")
local startRemote = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes"):WaitForChild("StartCutsceneEvent")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")
local TOPIC = "AdminCutsceneEvent"

local COMBOS = {
	-- Hacker Infiltration (34 s + 2 s de chargement) : le hacker pirate le système... puis l'event HACKER ATTACK commence
	HackerInfiltration = {
		Name = "Hacker Infiltration -> HACKER ATTACK",
		Length = 36,
		Play = function() bindables:WaitForChild("PlayHackerCutscene"):Fire() end,
		Then = function(duration) bindables:WaitForChild("RunSkyEvent"):Fire("Hacker", "start", duration) end,
	},
}

local busy = {}
local function run(id, duration)
	local combo = COMBOS[id]
	if not combo or busy[id] then return false end
	busy[id] = true
	combo.Play()
	task.delay(combo.Length, function()
		busy[id] = nil
		combo.Then(duration)
	end)
	return true
end

-- tous les serveurs
pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(message)
		local data = message.Data
		if type(data) == "table" and data.JobId ~= game.JobId then run(data.Id, data.Duration) end
	end)
end)

startRemote.OnServerEvent:Connect(function(player, id, scope, duration)
	if not table.find(AdminConfig.AdminIds, player.UserId) then return end
	local combo = COMBOS[id]
	if not combo then return end
	duration = math.clamp(tonumber(duration) or 600, 60, 86400)
	if not run(id, duration) then
		notifyRemote:FireClient(player, combo.Name .. " is already playing")
		return
	end
	if scope == "global" then
		pcall(function() MessagingService:PublishAsync(TOPIC, {Id = id, Duration = duration, JobId = game.JobId}) end)
	end
	notifyRemote:FireClient(player, combo.Name .. " started" .. (scope == "global" and " on ALL servers" or ""))
end)
