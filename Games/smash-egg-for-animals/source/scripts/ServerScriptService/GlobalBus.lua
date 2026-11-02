-- GlobalBus : TOUS les messages entre serveurs du jeu passent par UN SEUL abonnement MessagingService (sujet "GameBus_v1").
-- Pourquoi : Roblox limite le nombre d'abonnements par serveur (environ 20 au démarrage, avant que les joueurs arrivent).
-- Le jeu en avait 26 (un par système) : les derniers échouaient en silence, au hasard selon l'ordre de démarrage des scripts
-- (ex. le spawn d'œuf GLOBAL ne marchait plus). Ici, chaque système garde son propre "sujet", mais tout passe dans un seul tuyau.
-- Même utilisation que MessagingService :  local MessagingService = require(ServerScriptService.GlobalBus)
--   MessagingService:SubscribeAsync(sujet, function(message) ... message.Data ... end)
--   MessagingService:PublishAsync(sujet, data)   (lève une erreur si l'envoi échoue, comme avant : les pcall des scripts marchent)
local MessagingService = game:GetService("MessagingService")
local BUS_TOPIC = "GameBus_v1"

local Bus = {}
local handlers = {} -- [sujet] = {fonctions}
local subscribed, subscribing, warned = false, false, false

local function deliver(message)
	local packet = message.Data
	if type(packet) ~= "table" or type(packet.t) ~= "string" then return end
	local list = handlers[packet.t]
	if not list then return end
	local wrapped = {Data = packet.d, Sent = message.Sent}
	for _, fn in table.clone(list) do task.spawn(fn, wrapped) end
end

local function ensureSubscribed()
	if subscribed or subscribing then return end
	subscribing = true
	task.spawn(function()
		while not subscribed do
			local ok, err = pcall(function() MessagingService:SubscribeAsync(BUS_TOPIC, deliver) end)
			if ok then
				subscribed = true
			else
				if not warned then warn("[GlobalBus] subscribe failed (retrying every 10 s): " .. tostring(err)) warned = true end
				task.wait(10)
			end
		end
		subscribing = false
	end)
end

function Bus:SubscribeAsync(topic, fn)
	assert(type(topic) == "string" and type(fn) == "function", "GlobalBus:SubscribeAsync(topic, callback)")
	handlers[topic] = handlers[topic] or {}
	table.insert(handlers[topic], fn)
	ensureSubscribed()
	local connection = {Connected = true}
	function connection:Disconnect()
		if not self.Connected then return end
		self.Connected = false
		local list = handlers[topic]
		local i = list and table.find(list, fn)
		if i then table.remove(list, i) end
	end
	return connection
end

function Bus:PublishAsync(topic, data)
	MessagingService:PublishAsync(BUS_TOPIC, {t = topic, d = data})
end

ensureSubscribed()
return Bus
