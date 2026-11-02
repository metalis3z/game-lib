--credit to quartz games studio
--[[
	SeedPackService  (servidor)
	--------------------------------------------------------------------
	Entrega y APERTURA de seed packs (faltaba en el server reconstruido).

	Modelo (igual que las semillas, deducido del cliente):
	  • Un seed pack es un Tool con atributo SeedPack=<PackName> y un Handle.
	    El inventario (InventoryController.Main) lo categoriza por ese atributo
	    y saca el icono de SeedPackData.GetData(PackName).IMG; el contador sale
	    del atributo Count. SeedPackHandleController clona el visual de
	    Assets.SeedPacks[PackName] sobre el Handle al equipar.
	  • Al hacer clic (equipado) el cliente dispara Networking.SeedPack.OpenSeedPack
	    (invoke :Response(Any)) y espera { Success = true, WonSeed = <seed> }.
	    Aquí elegimos la semilla con SeedPackData.GetRandomSeed, la entregamos
	    con GameServerAPI.GiveSeed, descontamos un pack y respondemos.

	packCounts[userId][packName] es la fuente de verdad; el Tool la refleja.
	Se entrega vía GameServerAPI.GiveSeedPack (lo usa DevProductService al comprar).
]]

local Players            = game:GetService("Players")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local ServerScriptService= game:GetService("ServerScriptService")

local Networking    = require(ReplicatedStorage.SharedModules.Networking)
local SeedPackData  = require(ReplicatedStorage.SharedModules.SeedPackData)
local GameServerAPI = require(ServerScriptService.GameServerAPI)

local packCounts = {}  -- [userId] = { [packName] = count }

local function packExists(packName: string): boolean
	return SeedPackData.GetData(packName) ~= nil
end

local function findPackTool(player: Player, packName: string): Tool?
	for _, container in { player:FindFirstChild("Backpack"), player.Character } do
		if container then
			for _, t in container:GetChildren() do
				if t:IsA("Tool") and t:GetAttribute("SeedPack") == packName then
					return t
				end
			end
		end
	end
	return nil
end

-- El Handle es invisible: SeedPackHandleController le suelda el visual encima.
local function buildHandle(): Part
	local h = Instance.new("Part")
	h.Name = "Handle"
	h.Size = Vector3.new(1, 1, 1)
	h.Transparency = 1
	h.CanCollide = false
	h.CanQuery = false
	h.CanTouch = false
	h.Massless = true
	return h
end

local function spawnPackTool(player: Player, packName: string, count: number): Tool
	local data = SeedPackData.GetData(packName)
	local tool = Instance.new("Tool")
	tool.Name = packName
	tool.RequiresHandle = true
	tool.CanBeDropped = false
	tool.TextureId = (data and data.IMG) or ""
	tool:SetAttribute("SeedPack", packName)
	tool:SetAttribute("MainCategory", "SeedPack")
	tool:SetAttribute("Count", count)
	buildHandle().Parent = tool
	tool.Parent = player:FindFirstChild("Backpack") or player:WaitForChild("Backpack")
	return tool
end

-- Sincroniza el Tool con el conteo: crea si falta, ajusta Count, o destruye si 0.
local function syncPackTool(player: Player, packName: string, count: number)
	local tool = findPackTool(player, packName)
	if count <= 0 then
		if tool then
			tool:Destroy()
		end
	elseif tool then
		tool:SetAttribute("Count", count)
	else
		spawnPackTool(player, packName, count)
	end
end

-- Apila 'amount' packs de 'packName' en el Backpack. Expuesto a DevProductService.
local function givePack(player: Player, packName: string, amount: number?): boolean
	if not packExists(packName) then
		return false
	end
	local uid = player.UserId
	packCounts[uid] = packCounts[uid] or {}
	packCounts[uid][packName] = (packCounts[uid][packName] or 0) + (amount or 1)
	syncPackTool(player, packName, packCounts[uid][packName])
	return true
end

GameServerAPI.GiveSeedPack = givePack

-- Re-crea los Tools tras respawn (el Backpack nuevo está vacío).
local function respawnPacks(player: Player)
	local counts = packCounts[player.UserId]
	if not counts then
		return
	end
	for packName, count in counts do
		if count > 0 then
			syncPackTool(player, packName, count)
		end
	end
end

----------------------------------------------------------------------
-- Apertura
----------------------------------------------------------------------
Networking.SeedPack.OpenSeedPack.OnServerInvoke = function(player: Player, packName)
	if type(packName) ~= "string" or not packExists(packName) then
		return { Success = false }
	end

	local uid = player.UserId
	packCounts[uid] = packCounts[uid] or {}

	-- Cuántos tiene: fuente de verdad, con fallback al atributo Count del Tool.
	local have = packCounts[uid][packName] or 0
	if have <= 0 then
		local tool = findPackTool(player, packName)
		have = (tool and tool:GetAttribute("Count")) or 0
	end
	if have <= 0 then
		return { Success = false }
	end

	local wonSeed = SeedPackData.GetRandomSeed(packName)
	if not wonSeed then
		return { Success = false }
	end

	-- Entrega la semilla ganada (si es un nombre válido en PlantService).
	GameServerAPI.WaitFor("GiveSeed")(player, wonSeed, 1)

	-- Reproduce la animación de apertura (el pack se "tira" en arco, aterriza
	-- y revela la semilla). El visual lo maneja el cliente en
	-- SeedPackOpenController.Start -> SeedPackEffect.Open, que SOLO corre cuando
	-- el server emite ReplicateOpenSeedPack. El reconstruido nunca lo emitía, así
	-- que ningún pack (Ghost Pepper incluido) mostraba animación.
	--
	-- Mapeo de args (OJO: SeedPackEffect.Open usa p2/p3, NO p1):
	--   evt(player, A, B, C, pos) -> Open(A, B, C, pos, cframe)
	--   B (3er arg) -> Open.p2 = packName  (lookup del modelo y del efecto)
	--   C (4to arg) -> Open.p3 = wonSeed   (semilla revelada)
	--   A (2do arg) -> Open.p1 = clave en t2. DEBE ser ÚNICA por apertura: t2 se
	--                  indexa por esta clave y una corutina la pone en nil al
	--                  revelar; si se reusa (p.ej. packName) y se abren varios
	--                  packs a la vez, una apertura borra la clave de otra y
	--                  Seeds:FindFirstChild(nil) crashea (SeedPackEffect:346).
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		local landing = hrp.Position + hrp.CFrame.LookVector * 6
		local dropId = game:GetService("HttpService"):GenerateGUID(false)
		Networking.SeedPack.ReplicateOpenSeedPack:FireAllClients(player, dropId, packName, wonSeed, landing)
	end

	-- Consume un pack.
	local remaining = have - 1
	packCounts[uid][packName] = remaining
	syncPackTool(player, packName, remaining)

	return { Success = true, WonSeed = wonSeed }
end

----------------------------------------------------------------------
-- Respawn / limpieza
----------------------------------------------------------------------
local function hookPlayer(player: Player)
	player.CharacterAdded:Connect(function()
		task.wait(0.4)
		respawnPacks(player)
	end)
end

for _, p in Players:GetPlayers() do
	hookPlayer(p)
end
Players.PlayerAdded:Connect(hookPlayer)
Players.PlayerRemoving:Connect(function(player)
	packCounts[player.UserId] = nil
end)

print("[SeedPackService] listo — entrega y apertura de seed packs")
