--[[
	MorphService
	Handler del RemoteFunction ReplicatedStorage.Events.Morph.

	La CharacterSelection (Premade y Anomaly) llama:
		Events.Morph:InvokeServer("Characters", <nombre>)   -- personajes
		Events.Morph:InvokeServer("Anomaly",    <nombre>)   -- anomalías

	Transforma al jugador en el modelo elegido (carpetas separadas del usuario:
	Characters -> NPCs.UniqueVisitors1, Anomaly -> NPCs.Anomalies1).

	Al morfear MANUALMENTE (set player.Character) el motor NO copia los
	StarterCharacterScripts (Sound...) ni ajusta anim -> se copian esos scripts
	(menos Animate y CameraFixer) y se sobreescriben los IDs de anim del rig con
	PlayerAnimations. Posiciona por HumanoidRootPart (no pivot, que descentra).
	Cámara: CameraFixer del default baja la cámara -0.5 (mala para estos rigs)
	-> no se copia; se usa CameraOffset propio (MORPH_CAMERA_UP) hacia la cabeza.

	TOOLS: al cambiar de personaje las Tools equipadas cuelgan del personaje
	viejo (que se destruye) y el Backpack se puede recrear -> se GUARDAN todas
	(equipadas + mochila) en una carpeta temporal y se devuelven al Backpack
	nuevo, así no se pierde nada al morfear.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")

local NPCs = ReplicatedStorage:WaitForChild("NPCs")
local Events = ReplicatedStorage:WaitForChild("Events")
local MorphRF = Events:WaitForChild("Morph")
local CharScripts = StarterPlayer:FindFirstChild("StarterCharacterScripts")

local FOLDERS = {
	Characters = "UniqueVisitors1",
	Anomaly = "Anomalies1",
}

local PLAYER_WALKSPEED = 16
local SPAWN_LIFT = 3        -- studs hacia arriba para no aparecer dentro/abajo del piso
local MORPH_CAMERA_UP = 1   -- sube la cámara hacia la cabeza del rig (ajustable)

local morphChoice = {}  -- [player] = { category = string, name = string }

local function findTemplate(category, name)
	local folderName = FOLDERS[category]
	if not folderName then
		return nil
	end
	local folder = NPCs:FindFirstChild(folderName)
	if not folder then
		return nil
	end
	return folder:FindFirstChild(name)
end

-- Sobreescribe los IDs de animación del rig con los del player (los del rig
-- pueden estar rotos). Slots: Idle/Walk/Walk2/Jump/Tool.
local function applyPlayerAnimations(char)
	local anims = ReplicatedStorage:FindFirstChild("Animations")
	local folder = anims and anims:FindFirstChild("PlayerAnimations")
	if not folder then
		return
	end
	for _, anim in ipairs(folder:GetChildren()) do
		if anim:IsA("Animation") then
			local slot = char:FindFirstChild(anim.Name)
			if slot and slot:IsA("Animation") then
				slot.AnimationId = anim.AnimationId
			end
		end
	end
end

-- Copia los StarterCharacterScripts al morph (el set manual no los recibe).
-- Se salta "Animate" (el rig trae el suyo) y "CameraFixer" (offset del default,
-- deja la cámara en el medio de estos rigs) y los deshabilitados.
local function addCharacterScripts(char)
	if not CharScripts then
		return
	end
	for _, inst in ipairs(CharScripts:GetChildren()) do
		local skip = inst.Name == "Animate" or inst.Name == "CameraFixer"
		if (inst:IsA("LocalScript") or inst:IsA("Script")) and not skip and not inst.Disabled then
			if not char:FindFirstChild(inst.Name) then
				inst:Clone().Parent = char
			end
		end
	end
end

-- Saca TODAS las Tools (equipadas + Backpack) a una carpeta temporal para que
-- sobrevivan al cambio de personaje. Devuelve la carpeta (sin parent).
local function stashTools(player, oldChar)
	local stash = Instance.new("Folder")
	stash.Name = "MorphToolStash"

	local oldHum = oldChar and oldChar:FindFirstChildOfClass("Humanoid")
	if oldHum then
		oldHum:UnequipTools()
		task.wait()
	end

	local containers = {}
	local backpack = player:FindFirstChildOfClass("Backpack")
	if backpack then
		table.insert(containers, backpack)
	end
	if oldChar then
		table.insert(containers, oldChar)
	end

	for _, container in ipairs(containers) do
		for _, obj in ipairs(container:GetChildren()) do
			if obj:IsA("Tool") then
				obj.Parent = stash
			end
		end
	end

	return stash
end

-- Devuelve las Tools guardadas al Backpack (nuevo) del jugador.
local function restoreTools(player, stash)
	if not stash then
		return
	end

	local backpack = player:FindFirstChildOfClass("Backpack") or player:WaitForChild("Backpack", 10)
	if backpack then
		for _, obj in ipairs(stash:GetChildren()) do
			obj.Parent = backpack
		end
	end

	stash:Destroy()
end

local function buildMorph(player, template)
	local oldChar = player.Character
	local oldRoot = oldChar and (oldChar:FindFirstChild("HumanoidRootPart") or oldChar.PrimaryPart)
	local targetCF = oldRoot and oldRoot.CFrame

	local stash = stashTools(player, oldChar)

	local newChar = template:Clone()
	newChar.Name = player.Name
	newChar:SetAttribute("IsMorph", true)

	local root = newChar:FindFirstChild("HumanoidRootPart")
	if root then
		newChar.PrimaryPart = root
	end

	for _, d in ipairs(newChar:GetDescendants()) do
		if d:IsA("BasePart") then
			d.Anchored = false
		end
	end

	local hum = newChar:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = PLAYER_WALKSPEED
		hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		-- Cámara hacia la cabeza (sin CameraFixer del default)
		hum.CameraOffset = Vector3.new(0, MORPH_CAMERA_UP, 0)
	end

	applyPlayerAnimations(newChar)
	addCharacterScripts(newChar)

	newChar.Parent = workspace
	task.wait()

	player.Character = newChar

	-- Posicionar por el HumanoidRootPart (mueve toda la asamblea soldada),
	-- con un empujón hacia arriba para no caer dentro/abajo del piso.
	if targetCF and root then
		root.CFrame = targetCF + Vector3.new(0, SPAWN_LIFT, 0)
	end

	if oldChar then
		oldChar:Destroy()
	end

	-- NETWORK OWNERSHIP: el morph lo CREA el servidor, así que su asamblea puede
	-- quedarse siendo simulada por el servidor. Cuando pasa eso, el cliente mueve
	-- el Humanoid (MoveDirection = 1) pero la física que simula no es la
	-- autoritativa y se descarta -> el jugador queda "congelado" vibrando en el
	-- sitio con WalkSpeed normal y sin anclaje. Se le entrega la propiedad al
	-- jugador explícitamente.
	task.defer(function()
		if player.Character ~= newChar then return end
		local r = newChar:FindFirstChild("HumanoidRootPart") or newChar.PrimaryPart
		if r and not r.Anchored then
			pcall(function() r:SetNetworkOwner(player) end)
		end
	end)

	-- Después de que el motor terminó de cambiar el personaje (y de recrear el
	-- Backpack si le tocaba), devolvemos el inventario.
	task.defer(function()
		restoreTools(player, stash)
	end)


	return newChar
end

local function applyMorph(player, category, name)
	local template = findTemplate(category, name)
	if not template then
		warn(("[MorphService] modelo no encontrado: %s / %s"):format(tostring(category), tostring(name)))
		return false
	end
	morphChoice[player] = { category = category, name = name }
	buildMorph(player, template)
	return true
end

MorphRF.OnServerInvoke = function(player, category, name)
	if typeof(category) ~= "string" or typeof(name) ~= "string" then
		return false
	end
	return applyMorph(player, category, name)
end

local function hookPlayer(player)
	player.CharacterAdded:Connect(function(char)
		if char:GetAttribute("IsMorph") then
			return
		end
		local choice = morphChoice[player]
		if not choice then
			return
		end
		task.defer(function()
			if player.Character ~= char then
				return
			end
			local template = findTemplate(choice.category, choice.name)
			if template then
				buildMorph(player, template)
			end
		end)
	end)
end

Players.PlayerAdded:Connect(hookPlayer)
for _, player in ipairs(Players:GetPlayers()) do
	hookPlayer(player)
end

Players.PlayerRemoving:Connect(function(player)
	morphChoice[player] = nil
end)

-- print("[MorphService] listo — Events.Morph enganchado")
