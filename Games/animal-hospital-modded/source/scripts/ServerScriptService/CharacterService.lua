--[[
	CharacterService (Fase 1 — fix de arranque de la cámara/UI)

	El place viene con Players.CharacterAutoLoads = FALSE y ningún script
	llamaba a LoadCharacter (eso lo hacía el server que faltaba). Sin personaje,
	StarterGui nunca se copia a PlayerGui, así que TODOS los módulos de UI
	(CameraSystem, Sanity, Objective, PhotoUI...) se cuelgan en
	PlayerGui:WaitForChild(<gui>) → "Infinite yield" → la cámara no funciona.

	Fix: activar la carga de personajes. El motor maneja el spawn inicial y el
	respawn (usa Workspace.Misc.SpawnLocation + Players.RespawnTime = 3).

	NOTA para fases posteriores: cuando exista el sistema de rondas/turnos, es
	probable que quieras volver a CharacterAutoLoads=false y controlar el spawn
	desde ahí (spawnear al empezar el shift). Por ahora esto hace el juego
	jugable y arregla la cámara/UI.
]]

local Players = game:GetService("Players")

local CharacterService = {}

local function ensureCharacter(player)
	if player.Character then
		return
	end
	local ok, err = pcall(function()
		player:LoadCharacter()
	end)
	if not ok then
		warn("[CharacterService] LoadCharacter falló para " .. player.Name .. ": " .. tostring(err))
	end
end

function CharacterService:Init()
	if self._initialized then
		return
	end
	self._initialized = true

	-- Deja que el motor spawnee y respawnee automáticamente
	Players.CharacterAutoLoads = true

	-- Cubre a quien ya esté en el server antes de activar el flag (evita
	-- que se queden sin personaje si entraron durante la carga del server)
	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(ensureCharacter, player)
	end

	-- print("[CharacterService] inicializado — carga de personajes activa")
end

return CharacterService
