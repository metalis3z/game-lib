--[[
	SanityService  (Fase 2 — sistema de cordura)

	El cliente (StarterPlayerScripts.UI.SanityLocal) lee
	  LocalPlayer:GetAttribute("Sanity")   -- 0..100
	y su updateSanity() hace early-return si es nil. También usa:
	  SanityImpactMultiplier  (clase Psychologist = x2)
	  SanityLossReason / SanityGainReason  (texto del +/- flotante)
	Y dispara al servidor  Lib.Network:FireServer("PlayerLostSanity", amount, reason)
	(incluye un drenaje pasivo "Job Stress" cada 50s).

	Sin servidor que SETEE el atributo Sanity, la UI no hace nada. Este servicio:
	  · Pone Sanity=100 y el multiplicador de la clase al spawnear.
	  · Procesa PlayerLostSanity de forma autoritativa (server manda; replica).
	  · API para el resto del server: Lose/Gain/SetSanity.
	  · Al llegar a 0, mata al personaje (dispara la pantalla de muerte).
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))
local Classes = require(ReplicatedStorage.Data.Classes)
local DataService = require(ServerScriptService:WaitForChild("DataService"))
local Network = Lib.Network

local MAX_SANITY = 100

local SanityService = {}

local function classAttributes(player)
	local stats = DataService:GetStats(player)
	local className = stats and stats.Class or Classes.BASE_CLASS
	local def = Classes.Classes[className]
	return def and def.Attributes or {}
end

local function getSanity(player)
	return player:GetAttribute("Sanity") or MAX_SANITY
end

local function setSanity(player, value, reason, isGain)
	value = math.clamp(value, 0, MAX_SANITY)
	if isGain then
		player:SetAttribute("SanityGainReason", reason or "")
	else
		player:SetAttribute("SanityLossReason", reason or "")
	end
	player:SetAttribute("Sanity", value)

	if value <= 0 then
		local char = player.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum and hum.Health > 0 then
			hum.Health = 0
		end
	end
end

--------------------------------------------------------------------------------
-- API pública
--------------------------------------------------------------------------------
function SanityService:SetSanity(player, value, reason)
	setSanity(player, value, reason, false)
end

function SanityService:LoseSanity(player, amount, reason)
	local mult = player:GetAttribute("SanityImpactMultiplier") or 1
	setSanity(player, getSanity(player) - amount * mult, reason, false)
end

function SanityService:GainSanity(player, amount, reason)
	local mult = player:GetAttribute("SanityImpactMultiplier") or 1
	setSanity(player, getSanity(player) + amount * mult, reason, true)
end

function SanityService:GetSanity(player)
	return getSanity(player)
end

-- Reinicia cordura al máximo (nuevo turno / respawn)
function SanityService:Reset(player)
	local attrs = classAttributes(player)
	player:SetAttribute("SanityImpactMultiplier", attrs.SanityImpactMultiplier or 1)
	player:SetAttribute("Sanity", MAX_SANITY)
end

--------------------------------------------------------------------------------
-- Bootstrap
--------------------------------------------------------------------------------
function SanityService:Init()
	if self._initialized then return end
	self._initialized = true

	local function onCharacter(player)
		-- espera el perfil (clase) y setea cordura inicial
		task.spawn(function()
			DataService:Get(player)
			self:Reset(player)
		end)
	end

	Players.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(function()
			onCharacter(player)
		end)
		if player.Character then
			onCharacter(player)
		end
	end)
	for _, player in ipairs(Players:GetPlayers()) do
		player.CharacterAdded:Connect(function()
			onCharacter(player)
		end)
		if player.Character then
			onCharacter(player)
		end
	end

	-- El cliente reporta pérdidas (drenaje pasivo, sustos...). Server autoritativo.
	Network:Connect("PlayerLostSanity", function(player, amount, reason)
		if type(amount) ~= "number" then return end
		amount = math.clamp(amount, 0, MAX_SANITY)
		self:LoseSanity(player, amount, reason)
	end)

	print("[SanityService] inicializado")
end

return SanityService
