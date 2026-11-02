--[[
	DataService  (Fase 1 — reconstrucción del server side)  ·  vía ProfileStore

	El cliente (StarterPlayerScripts.LocalDataHandler) hace al arrancar:
		Lib.Network:InvokeServer("RequestData")
	Si nadie registra/responde ese RemoteFunction, el cliente espera 10s y
	tira "Failed to find RemoteFunction: RF/RequestData" o te kickea con
	"ERROR RETRIEVING DATA, PLEASE REJOIN". Este servicio lo responde y persiste
	el perfil con ProfileStore (loleris) — session locking + autosave.

	Contrato de red (ver ReplicatedStorage.Util.Net):
	  · RequestData devuelve la tabla-perfil directa (InvokeServer).
	  · Update parcial: para que el cliente (processData) haga
	        t.data[categoria] = valor
	    hay que disparar  Network:FireClient(plr, categoria, categoria, valor)
	    (la clave va como nombre-de-evento Y como primer argumento). Cada
	    categoría-tabla genera además un BindableEvent homónimo (ej. StatsLocal
	    escucha Lib.dHandler.Stats.Event).

	API para futuras fases:
	  DataService:Get(player)            -> perfil.Data (cede hasta cargar)
	  DataService:GetProfile(player)     -> el Profile de ProfileStore (o nil)
	  DataService:GetStats(player)       -> perfil.Data.Stats
	  DataService:SetStat(player, k, v)  -> setea Stats[k] y empuja al cliente
	  DataService:AddCash(player, n)     -> suma dinero y empuja al cliente
	  DataService:PushCategory(player,c) -> reenvía una categoría al cliente
	  DataService:Save(player)           -> guardado manual (ProfileStore:Save)
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Classes = require(ReplicatedStorage.Data.Classes)
local ProfileStore = require(ServerScriptService:WaitForChild("ProfileStore"))

local Network = Lib.Network

--------------------------------------------------------------------------------
-- Plantilla de perfil (ProfileStore la copia y reconcilia por jugador)
--------------------------------------------------------------------------------
local BASE_CLASS = Classes.BASE_CLASS or "Intern"
local START_MONEY = (Classes.Classes[BASE_CLASS] and Classes.Classes[BASE_CLASS].StartingMoney) or 0

local PROFILE_TEMPLATE = {
	Stats = {
		LocalCash = START_MONEY,
		Class = BASE_CLASS,
		Level = 1,
		XP = 0,
	},
	Inventory = { Items = {}, M4Charges = {} }, -- M4Charges[i] = balas restantes del M4 #i (persistente; 0/ausente = ya no lo tiene)
	OwnedClasses = { [BASE_CLASS] = true },
	Settings = {},
	-- Categorías-canal que el cliente auto-conecta (ver remotes RE/<cat>).
	-- Vacías por ahora; se llenan en fases posteriores. Evitan nil en la UI.
	Gamepasses = {},
	Quests = {},
	Historic = {},
	Help = true, -- flag chequeado por LocalDataHandler en el arranque
	-- Monetización persistente (1 sola compra, se guarda para siempre en el perfil).
	OwnsAdminPanel = false,   -- compró el AdminPanel (MonetizationBuys)
	NoAdminCooldowns = false, -- compró "No Cooldowns" (quita el cooldown del panel)
}

-- USE_MOCK_IN_STUDIO:
--   true  = en Studio usa el store Mock (en memoria). Se BORRA en cada Stop/Play,
--           por eso el AdminPanel "se te pedia comprar de nuevo" al reingresar.
--   false = en Studio usa el DataStore REAL, la compra PERSISTE entre Stop/Play
--           (igual que en el juego publicado). Requiere activar:
--           Home > Game Settings > Security > "Enable Studio Access to API Services".
--           OJO: esto escribe sobre tu perfil REAL del juego publicado.
-- En el juego publicado este flag no importa: siempre usa el DataStore real.
local USE_MOCK_IN_STUDIO = false

local store = ProfileStore.New("PlayerProfiles_v1", PROFILE_TEMPLATE)
if RunService:IsStudio() and USE_MOCK_IN_STUDIO then
	store = store.Mock
end

--------------------------------------------------------------------------------
local DataService = {}
local profiles = {} -- [player] = Profile

local function keyFor(player)
	return "Player_" .. player.UserId
end

local function loadProfile(player)
	local profile = store:StartSessionAsync(keyFor(player), {
		Cancel = function()
			return player.Parent ~= Players
		end,
	})

	if profile == nil then
		-- otra sesión tomó el lock o el jugador ya se fue
		player:Kick("No se pudieron cargar tus datos. Reingresa por favor.")
		return
	end

	profile:AddUserId(player.UserId)
	profile:Reconcile()

	profile.OnSessionEnd:Connect(function()
		profiles[player] = nil
		player:Kick("Tus datos se cargaron en otra sesión. Reingresa por favor.")
	end)

	if player.Parent == Players then
		profiles[player] = profile
	else
		-- se fue durante la carga
		profile:EndSession()
	end
end

--------------------------------------------------------------------------------
-- API pública
--------------------------------------------------------------------------------
function DataService:GetProfile(player)
	return profiles[player]
end

function DataService:Get(player)
	if profiles[player] then
		return profiles[player].Data
	end
	-- espera a que PlayerAdded->loadProfile termine
	local t0 = os.clock()
	while not profiles[player] and player.Parent and os.clock() - t0 < 20 do
		task.wait()
	end
	return profiles[player] and profiles[player].Data or nil
end

function DataService:GetStats(player)
	local data = self:Get(player)
	return data and data.Stats
end

-- Reenvía una categoría-tabla al cliente respetando el contrato de processData
function DataService:PushCategory(player, category)
	local profile = profiles[player]
	if not profile or profile.Data[category] == nil then
		return
	end
	Network:FireClient(player, category, category, profile.Data[category])
end

function DataService:SetStat(player, key, value)
	local stats = self:GetStats(player)
	if not stats then return end
	stats[key] = value
	self:PushCategory(player, "Stats")
	return value
end

function DataService:AddCash(player, amount)
	local stats = self:GetStats(player)
	if not stats then return end
	stats.LocalCash = (stats.LocalCash or 0) + amount
	self:PushCategory(player, "Stats")
	return stats.LocalCash
end

function DataService:Save(player)
	local profile = profiles[player]
	if profile and profile:IsActive() then
		profile:Save()
	end
end

--------------------------------------------------------------------------------
-- Bootstrap
--------------------------------------------------------------------------------
function DataService:Init()
	if self._initialized then
		return
	end
	self._initialized = true

	-- Responde el RequestData que el cliente invoca al arrancar
	Network:Handle("RequestData", function(player)
		return DataService:Get(player)
	end)

	Players.PlayerAdded:Connect(loadProfile)

	Players.PlayerRemoving:Connect(function(player)
		local profile = profiles[player]
		if profile then
			profile:EndSession()
		end
		profiles[player] = nil
	end)

	-- Jugadores ya presentes (playtest de Studio / recarga en caliente)
	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(loadProfile, player)
	end

	-- ProfileStore maneja autosave y game:BindToClose internamente.
	-- print("[DataService] inicializado (ProfileStore" .. (RunService:IsStudio() and " Mock" or "") .. ") — RF/RequestData listo")
end

return DataService
