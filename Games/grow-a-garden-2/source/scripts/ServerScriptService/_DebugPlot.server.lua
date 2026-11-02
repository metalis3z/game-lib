--credit to leon games studio
--[[
	_DebugPlot  (TEMPORAL — borrar cuando termines de depurar)
	------------------------------------------------------------------
	Comandos de chat:
	  /plotdebug   -> imprime las plantas de TU plot:
	                  - LIVE  = las que el server tiene en memoria (gardens)
	                  - SAVED = las que están en tu base de datos (perfil)
	                  Si borras una planta con la pala y SAVED sigue mostrándola,
	                  la persistencia está fallando. Si tras rejoin vuelve, estaba
	                  guardada.
	  /digclear    -> (atajo) imprime solo el conteo rápido.

	Combínalo con los prints [DIG][normal]/[DIG][rainbow] de PlantService que se
	disparan al cavar.
]]

local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local GameServerAPI = require(ServerScriptService:WaitForChild("GameServerAPI"))

local function countAndIds(t)
	local n, ids = 0, {}
	for k in pairs(t or {}) do
		n += 1
		if #ids < 25 then
			table.insert(ids, tostring(k))
		end
	end
	return n, table.concat(ids, ", ")
end

local function dump(player: Player)
	local uid = player.UserId
	local live = GameServerAPI.GetGardenSave and GameServerAPI.GetGardenSave(uid) or {}
	local saved = GameServerAPI.GetSavedPlants and GameServerAPI.GetSavedPlants(player) or {}
	local lc, lids = countAndIds(live)
	local sc, sids = countAndIds(saved)
	warn(("========== [PLOTDEBUG] %s =========="):format(player.Name))
	warn(("  LIVE  (memoria del server): %d plantas -> %s"):format(lc, lids))
	warn(("  SAVED (base de datos)     : %d plantas -> %s"):format(sc, sids))
	-- diferencias: lo que está en SAVED pero no en LIVE (no debería tras un dig
	-- bien persistido) y viceversa.
	local onlySaved = {}
	for k in pairs(saved or {}) do
		if not (live or {})[k] then
			table.insert(onlySaved, tostring(k))
		end
	end
	if #onlySaved > 0 then
		warn(("  ⚠️ En SAVED pero NO en LIVE (persistencia desfasada): %s"):format(table.concat(onlySaved, ", ")))
	else
		warn("  ✅ SAVED y LIVE coinciden (sin plantas fantasma en la DB)")
	end
	warn("=========================================")
end

local function hook(player: Player)
	player.Chatted:Connect(function(message)
		local cmd = message:lower():gsub("%s+", "")
		if cmd == "/plotdebug" or cmd == "/digclear" then
			dump(player)
		end
	end)
end

Players.PlayerAdded:Connect(hook)
for _, p in Players:GetPlayers() do
	hook(p)
end

warn("[_DebugPlot] activo. Escribe /plotdebug en el chat para ver LIVE vs SAVED de tu plot.")
