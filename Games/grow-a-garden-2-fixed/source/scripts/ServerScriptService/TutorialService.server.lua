--credit to leon games studio
--[[
	TutorialService  (MODDED — lado servidor del tutorial)
	====================================================================
	El tutorial estaba SÓLO a medias: el cliente (TutorialController +
	TutorialRunner) ya estaba completo, pero NADIE en el servidor respondía
	al canal Networking.Tutorial.Ready, así que el flujo nunca arrancaba.

	Flujo de los canales (definidos en SharedModules.Networking):
	  • Tutorial.Ready    (cliente -> servidor)  "estoy listo, ¿arranco?"
	  • Tutorial.Start    (servidor -> cliente)  arranca con una Variant (String)
	  • Tutorial.Complete (cliente -> servidor)  terminé, no repetir

	El cliente dispara Ready en bucle (hasta 30 veces / ~60s) tras la pantalla
	de carga; este servicio decide si arrancarlo y con qué Variant. La marca
	TutorialCompleted vive en el atributo del Player y la persiste GameServer
	(PROFILE_TEMPLATE.TutorialCompleted), por eso sólo corre la PRIMERA vez.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Networking = require(ReplicatedStorage.SharedModules.Networking)

-- Variant del tutorial (ver TutorialRunner.t). Variant2 = notificaciones ON,
-- flechas guía, sin forzar teleports. Cambiá acá para otro estilo.
local TUTORIAL_VARIANT = "Variant2"

-- Espera (con timeout) a que GameServer cargue el perfil y aplique el atributo
-- TutorialCompleted (lo hace junto con el tag "DataLoaded").
local function waitForDataLoaded(player: Player, timeout: number): boolean
	local t0 = os.clock()
	while not player:HasTag("DataLoaded") do
		if os.clock() - t0 > timeout or player.Parent ~= Players then
			return player:HasTag("DataLoaded")
		end
		task.wait(0.2)
	end
	return true
end

-- Una sola arrancada por sesión, aunque el cliente mande Ready varias veces.
local startedThisSession: { [Player]: boolean } = {}

Networking.Tutorial.Ready.OnServerEvent:Connect(function(player: Player)
	if startedThisSession[player] then
		return
	end

	-- Asegurar que el perfil ya cargó para leer TutorialCompleted bien.
	waitForDataLoaded(player, 30)
	if player.Parent ~= Players or startedThisSession[player] then
		return
	end

	if player:GetAttribute("TutorialCompleted") == true then
		return -- ya lo hizo en una sesión anterior
	end

	startedThisSession[player] = true
	Networking.Tutorial.Start:FireClient(player, TUTORIAL_VARIANT)
	print(("[TutorialService] tutorial %s iniciado para %s"):format(TUTORIAL_VARIANT, player.Name))
end)

Networking.Tutorial.Complete.OnServerEvent:Connect(function(player: Player)
	player:SetAttribute("TutorialCompleted", true) -- GameServer lo persiste al salir
	print(("[TutorialService] %s completó el tutorial"):format(player.Name))
end)

Players.PlayerRemoving:Connect(function(player)
	startedThisSession[player] = nil
end)

print("[TutorialService] listo — escuchando Tutorial.Ready / Tutorial.Complete")
