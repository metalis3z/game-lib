-- Cinématique "Samouraï contre la horde" (panneau admin > Cutscenes). Tout est joué côté client (FightFilm.SamuraiFilm) :
-- le serveur vérifie seulement que la demande vient d'un admin, puis prévient les clients.
-- scope : "me" = seulement l'admin (pour tester), "server" = ce serveur, sinon tous les serveurs.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")
local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local startRemote = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes"):WaitForChild("StartSamuraiFilm")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")
local playRemote = ReplicatedStorage:WaitForChild("FightFilm"):WaitForChild("Play")

local TOPIC = "AdminSamuraiFilm"
local LENGTH = 112 -- durée réelle de la cinématique (s) : le film dure 99 s, plus l'attente du début et le nettoyage
local busyUntil = 0
local function play()
	if os.clock() < busyUntil then return end
	busyUntil = os.clock() + LENGTH
	playRemote:FireAllClients()
end
pcall(function() MessagingService:SubscribeAsync(TOPIC, function() task.spawn(play) end) end)

startRemote.OnServerEvent:Connect(function(player, scope)
	if not table.find(AdminConfig.AdminIds, player.UserId) then return end
	if scope == "me" then
		playRemote:FireClient(player)
		return
	end
	if os.clock() < busyUntil then
		notifyRemote:FireClient(player, "The cutscene is already playing")
		return
	end
	local sent = scope ~= "server" and pcall(function() MessagingService:PublishAsync(TOPIC, {t = os.time()}) end)
	if not sent then task.spawn(play) end
	notifyRemote:FireClient(player, sent and "Samurai cutscene started on ALL servers" or "Samurai cutscene started on this server")
end)
