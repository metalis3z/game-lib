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
local DEBUG = false

local morphChoice = {}  -- [player] = { category = string, name = string }

local function dprint(...)
	if DEBUG then
		print("[MorphDebug]", ...)
	end
end

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

local function buildMorph(player, template)
	local oldChar = player.Character
	local oldRoot = oldChar and (oldChar:FindFirstChild("HumanoidRootPart") or oldChar.PrimaryPart)
	local targetCF = oldRoot and oldRoot.CFrame

	-- Si el jugador tiene una Tool equipada, está parentada dentro de oldChar.
	-- Si no la devolvemos al Backpack antes de destruir oldChar, la Tool se
	-- destruye junto con el personaje viejo y la cura se pierde para siempre.
	if oldChar then
		print("[MorphDebug] ===== INICIO MORPH =====")
		print("[MorphDebug] Player:", player.Name)

		local backpack = player:FindFirstChildOfClass("Backpack")

		local equipped = {}
		for _, obj in ipairs(oldChar:GetChildren()) do
			if obj:IsA("Tool") then
				table.insert(equipped, obj.Name)
			end
		end

		if #equipped == 0 then
			print("[MorphDebug] No hay herramientas equipadas en el Character.")
		else
			print("[MorphDebug] Herramientas equipadas:", table.concat(equipped, ", "))
		end

		if backpack then
			local backpackTools = {}
			for _, obj in ipairs(backpack:GetChildren()) do
				if obj:IsA("Tool") then
					table.insert(backpackTools, obj.Name)
				end
			end

			print("[MorphDebug] Backpack antes:", #backpackTools > 0 and table.concat(backpackTools, ", ") or "(vacío)")
		end

		local oldHum = oldChar:FindFirstChildOfClass("Humanoid")
		if oldHum then
			print("[MorphDebug] Llamando Humanoid:UnequipTools()")
			oldHum:UnequipTools()
			task.wait()

			local remaining = {}
			for _, obj in ipairs(oldChar:GetChildren()) do
				if obj:IsA("Tool") then
					table.insert(remaining, obj.Name)
				end
			end

			if #remaining == 0 then
				print("[MorphDebug] OK: ninguna Tool quedó equipada.")
			else
				print("[MorphDebug] AÚN quedan equipadas:", table.concat(remaining, ", "))
			end
		else
			print("[MorphDebug] No existe Humanoid, moviendo Tools manualmente.")

			if backpack then
				for _, obj in ipairs(oldChar:GetChildren()) do
					if obj:IsA("Tool") then
						print("[MorphDebug] Moviendo", obj.Name, "al Backpack.")
						obj.Parent = backpack
					end
				end
			end
		end

		if backpack then
			local backpackTools = {}
			for _, obj in ipairs(backpack:GetChildren()) do
				if obj:IsA("Tool") then
					table.insert(backpackTools, obj.Name)
				end
			end

			print("[MorphDebug] Backpack después:", #backpackTools > 0 and table.concat(backpackTools, ", ") or "(vacío)")
		end

		print("[MorphDebug] ===== FIN PREPARACIÓN =====")
	end

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

	local backpack = player:FindFirstChildOfClass("Backpack")

	print("[MorphDebug] ===== DESPUÉS DEL MORPH =====")

	local equipped = {}
	for _, obj in ipairs(newChar:GetChildren()) do
		if obj:IsA("Tool") then
			table.insert(equipped, obj.Name)
		end
	end

	print("[MorphDebug] Tools equipadas:",
		#equipped > 0 and table.concat(equipped, ", ") or "(ninguna)")

	if backpack then
		local backpackTools = {}
		for _, obj in ipairs(backpack:GetChildren()) do
			if obj:IsA("Tool") then
				table.insert(backpackTools, obj.Name)
			end
		end

		print("[MorphDebug] Backpack:",
			#backpackTools > 0 and table.concat(backpackTools, ", ") or "(vacío)")
	end

	print("[MorphDebug] =======================")
	player.Character = newChar

	-- Posicionar por el HumanoidRootPart (mueve toda la asamblea soldada),
	-- con un empujón hacia arriba para no caer dentro/abajo del piso.
	if targetCF and root then
		root.CFrame = targetCF + Vector3.new(0, SPAWN_LIFT, 0)
	end

	if oldChar then
		oldChar:Destroy()
	end

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

print("[MorphService] listo — Events.Morph enganchado")
