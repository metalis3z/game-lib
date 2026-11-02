-- GlobalEventServer : commande admin StartGlobalEvent
-- Pour l'instant la commande ne fait rien d'autre que "partir" dans TOUS les serveurs.
-- Pour lui donner un effet plus tard : ecouter ServerStorage.GameBindables.GlobalEventStarted (un par serveur).
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local MessagingService = game:GetService("MessagingService")

local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local startRemote = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes"):WaitForChild("StartGlobalEvent")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")
local startedEvent = ServerStorage:WaitForChild("GameBindables"):WaitForChild("GlobalEventStarted")

local TOPIC = "AdminGlobalEvent"
local COOLDOWN = 3 -- secondes entre deux lancements (anti double-clic)
local lastStart = 0

-- reception (tous les serveurs, y compris celui de l'admin)
pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(message)
		local data = message.Data
		startedEvent:Fire(type(data) == "table" and data.adminName or "admin")
	end)
end)

startRemote.OnServerEvent:Connect(function(player)
	if not table.find(AdminConfig.AdminIds, player.UserId) then return end
	if os.clock() - lastStart < COOLDOWN then return end
	lastStart = os.clock()

	local ok = pcall(function()
		MessagingService:PublishAsync(TOPIC, {adminName = player.DisplayName})
	end)
	if ok then
		notifyRemote:FireClient(player, "StartGlobalEvent sent to all servers")
	else
		startedEvent:Fire(player.DisplayName) -- MessagingService indisponible (Studio) : ce serveur seulement
		notifyRemote:FireClient(player, "MessagingService unavailable: StartGlobalEvent started on this server only")
	end
end)
