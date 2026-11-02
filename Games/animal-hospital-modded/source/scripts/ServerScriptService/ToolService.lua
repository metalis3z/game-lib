--[[
	ToolService  (Fase 3/4 — el backpack del jugador)

	El backpack de Roblox (ReplicatedStorage.Purse, renombrado BackpackGui) es el
	core estándar: muestra los Tool que hay en Player.Backpack. Cada CURA de
	Data.IllnessesAndCures se puede volver un Tool:
	  · Name / ToolTip = nombre de la cura (ej. "Thermo", "IV Drops")
	  · TextureId       = la imagen de la cura (icono en la ranura del backpack)
	  · Attribute CureName = nombre de la cura  -> PatientCareService lo compara
	    contra la cura requerida por la enfermedad del paciente.

	IMPORTANTE (progresión): NO se dan las 17 curas al empezar (saturaba el hotbar
	y buggeaba la UI). Al spawnear solo se da un KIT INICIAL corto; el resto se
	CONSIGUE jugando (fases de tienda/suministros) vía :GrantCure. PatientCareService
	solo asigna enfermedades que puedas curar con lo que tienes, así siempre es
	jugable y la variedad crece cuando consigues más curas.

	RequiresHandle=false: no necesitan malla física para equiparse ni mostrar icono.

	MORPHS: las curas funcionan IGUAL morfeado. Con RequiresHandle=true Roblox
	solo equipa si el Character tiene "Right Arm"/"RightHand" para soldar el
	Handle; los rigs de NPCs.* no las tienen y el equip fallaba en silencio (la
	Tool parecía desaparecer). Ahora RequiresHandle=false y el Handle se suelda a
	mano (Motor6D "CureGrip") al brazo si existe, o al HumanoidRootPart/Head con
	un offset fijo si el morph no tiene brazos.

	API: ToolService:Init(), :GiveStarterKit(player), :GrantCure(player, cureName),
	     :HasCure(player, cureName)
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local IllnessesAndCures = require(ReplicatedStorage.Data.IllnessesAndCures)

-- El jugador ENTRA SIN NADA: el backpack arranca vacío. Todas las curas se
-- consiguen jugando (estantes de suministro vía SupplyService:GrantCure).
local STARTER_CURES = {}

-- Cuánto SUBE el item respecto a la mano (studs), a la altura del pecho. Sube/baja
-- este número para afinar (2 = hombro, 1.2 = pecho, 0.5 = cintura).
local GRIP_RAISE = 2.2
-- Cuánto lo empuja hacia ADELANTE (frente al pecho). + = adelante, - = hacia el cuerpo.
local GRIP_FORWARD = 1.4

local ToolService = {}

local DEBUG_GRIP = false  -- true = prints al equipar/desequipar una cura (rig, brazo, weld, posición)

local function dprint(...)
	if DEBUG_GRIP then
		print("[ToolService:Grip]", ...)
	end
end

-- Imprime el estado del brazo/mano del rig actual del jugador al equipar una
-- Tool: si existe Right Arm (R6) / RightHand (R15), si el Handle quedó
-- soldado (Motor6D "RightGrip"), y en qué está parentada la Tool ahora mismo.
local function debugArmState(player, tool, char)
	char = char or player.Character
	if not char then
		dprint(("EQUIP %s -> jugador %s SIN Character"):format(tool.Name, player.Name))
		return
	end

	local hum = char:FindFirstChildOfClass("Humanoid")
	local rigType = hum and tostring(hum.RigType) or "sin Humanoid"
	local isMorph = char:GetAttribute("IsMorph") == true

	local rightArm = char:FindFirstChild("Right Arm")
	local rightHand = char:FindFirstChild("RightHand")
	local armPart = rightArm or rightHand

	local handle = tool:FindFirstChild("Handle")
	local grip = armPart and handle and armPart:FindFirstChild("RightGrip")

	dprint(("EQUIP %s | player=%s | char=%s | isMorph=%s | RigType=%s"):format(
		tool.Name, player.Name, char.Name, tostring(isMorph), rigType))
	dprint(("  Right Arm=%s | RightHand=%s -> parte usada para el grip: %s"):format(
		tostring(rightArm ~= nil), tostring(rightHand ~= nil), armPart and armPart.Name or "NINGUNA (sin brazo -> no hay donde soldar el Handle)"))
	dprint(("  Tool.Parent=%s | Handle existe=%s | Motor6D RightGrip creado=%s"):format(
		tostring(tool.Parent), tostring(handle ~= nil), tostring(grip ~= nil)))
end

local function debugUnequip(player, tool)
	dprint(("UNEQUIP %s | player=%s | Tool.Parent ahora=%s"):format(
		tool.Name, player.Name, tostring(tool.Parent)))
end

local function buildCureTool(cure)
	local tool = Instance.new("Tool")
	tool.Name = cure.Name
	tool.ToolTip = cure.Name
	tool.TextureId = cure.Image or ""   -- icono en la ranura del backpack
	-- OJO: antes esto era true. Con RequiresHandle=true, Roblox SOLO parenta
	-- la Tool al Character si encuentra una parte "Right Arm" (R6) o
	-- "RightHand" (R15) para soldar el Handle. Los morphs (NPCs.*) no tienen
	-- esas partes -> el equip fallaba en silencio (Equipped nunca se disparaba,
	-- la Tool se quedaba "trabada", parecia desaparecer). Con false, Roblox
	-- SIEMPRE deja equipar y nosotros soldamos el Handle a mano (attachHandle).
	tool.RequiresHandle = false
	tool.CanBeDropped = false
	tool:SetAttribute("CureName", cure.Name)

	-- Handle en la mano: tablero fino INVISIBLE con el icono de la cura por ambas
	-- caras en Decals (los Decals se ven aunque el part sea transparente).
	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.new(1, 1.2, 0.25)
	handle.Material = Enum.Material.SmoothPlastic
	handle.Color = Color3.fromRGB(235, 235, 235)
	handle.CanCollide = false
	handle.Massless = true
	handle.Transparency = 1   -- part invisible; los Decals del icono se siguen viendo
	handle.TopSurface = Enum.SurfaceType.Smooth
	handle.BottomSurface = Enum.SurfaceType.Smooth
	for _, face in ipairs({ Enum.NormalId.Front, Enum.NormalId.Back }) do
		local decal = Instance.new("Decal")
		decal.Texture = cure.Image or ""
		decal.Face = face
		decal.Parent = handle
	end
	handle.Parent = tool

	-- Posición del Handle en la mano vía Tool.Grip. El RightGripAttachment del Handle
	-- NO funcionaba (Roblox lo ignora aquí y usaba el Grip por defecto -> item pegado
	-- a la mano). El grip de la mano (R15, brazo abajo) tiene su eje Z = MUNDO-ARRIBA,
	-- así que subimos GRIP_RAISE por ahí y ponemos el tablero VERTICAL con el icono al
	-- frente. Handle.CFrame = mano.gripWorld * Grip:Inverse().
	tool.Grip = (CFrame.new(0, GRIP_FORWARD, GRIP_RAISE) * CFrame.Angles(math.rad(90), 0, 0)):Inverse()

	-- Offset medido a mano (ver debug POSICIÓN): posición/rotación del Handle
	-- relativa al HumanoidRootPart cuando está bien agarrado en la mano de un
	-- personaje normal (RightHand). Se usa como fallback fijo para los morphs
	-- sin brazo, en vez de tool.Grip (que está pensado para colgar de una
	-- mano, no para plantarse sobre el torso -- por eso se veía mal).
	-- (Y subido +1 respecto al valor medido original 0.08, para que en los morphs
	--  sin brazos la cura quede a la altura del pecho/hombro y no de la cintura.)
	local FALLBACK_HRP_OFFSET = CFrame.new(1.30, 1.08, -1.26)

	-- Sueldan el Handle a mano (Motor6D "CureGrip") a la mejor parte disponible
	-- del Character actual. Con RigType normal usa Right Arm/RightHand (mismo
	-- resultado visual de antes); en un morph sin brazos cae a
	-- HumanoidRootPart/Head con FALLBACK_HRP_OFFSET.
	local function attachHandle(char)
		local handle = tool:FindFirstChild("Handle")
		if not handle then return end

		local armPart = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightHand")

		-- PERSONAJE NORMAL: Roblox YA crea su propio Motor6D "RightGrip"
		-- (brazo -> Handle, usando tool.Grip) al equipar, aunque RequiresHandle
		-- sea false. Si ademas soldabamos el nuestro, el Handle quedaba con DOS
		-- motores peleandose: el solver de fisica corregia el conflicto tirando
		-- del brazo y TUMBABA al jugador al suelo. Si ya existe el RightGrip no
		-- hacemos nada: la posicion ya la da tool.Grip (GRIP_RAISE/GRIP_FORWARD).
		if armPart then
			for _ = 1, 12 do
				if armPart:FindFirstChild("RightGrip") then
					dprint("  attachHandle: Roblox ya creo el RightGrip, no soldamos nada")
					return
				end
				if tool.Parent ~= char then return end   -- se desequipo mientras esperabamos
				task.wait()
			end
		end

		local attachPart, c0, c1

		if armPart then
			-- hay brazo pero Roblox no hizo el RightGrip -> lo soldamos nosotros
			attachPart = armPart
			c0 = CFrame.new()
			c1 = tool.Grip
		else
			attachPart = char:FindFirstChild("HumanoidRootPart")
				or char:FindFirstChild("Head")
				or char:FindFirstChild("RootPart")
			c0 = FALLBACK_HRP_OFFSET
			c1 = CFrame.new()
		end

		if not attachPart then
			dprint(("  attachHandle: %s no tiene NINGUNA parte usable, no se pudo soldar el Handle"):format(char.Name))
			return
		end

		handle.CanCollide = false
		handle.Anchored = false
		-- OJO: esta fórmula tiene que coincidir EXACTO con lo que el Motor6D va a
		-- calcular abajo (Part1.CFrame = Part0.CFrame * C0 * C1:Inverse()). Antes
		-- usaba "attachPart.CFrame * tool.Grip" (sin invertir) -- eso dejaba el
		-- Handle en una posición distinta a la que el Motor6D recién creado
		-- "pensaba" que tenía que tener, y el solver de física corregía ese salto
		-- de golpe empujando/rotando el personaje entero (por eso tumbaba al piso
		-- al equipar, sobre todo pegado al HumanoidRootPart). Con las dos fórmulas
		-- iguales no hay salto y no hay tirón.
		handle.CFrame = attachPart.CFrame * c0 * c1:Inverse()

		local weld = Instance.new("Motor6D")
		weld.Name = "CureGrip"
		weld.Part0 = attachPart
		weld.Part1 = handle
		weld.C0 = c0
		weld.C1 = c1
		weld.Parent = handle

		dprint(("  attachHandle: Handle soldado a '%s' (Motor6D CureGrip creado)"):format(attachPart.Name))

		-- DEBUG DE POSICIÓN: dónde terminó el Handle relativo al HumanoidRootPart.
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if hrp then
			local relativeToHRP = hrp.CFrame:ToObjectSpace(handle.CFrame)
			local pos = relativeToHRP.Position
			local rx, ry, rz = relativeToHRP:ToEulerAnglesXYZ()
			dprint(("  POSICIÓN Handle relativa a HumanoidRootPart -> Pos=(%.2f, %.2f, %.2f) | Rot(deg)=(%.1f, %.1f, %.1f)"):format(
				pos.X, pos.Y, pos.Z, math.deg(rx), math.deg(ry), math.deg(rz)))
		end
	end

	local function detachHandle()
		local handle = tool:FindFirstChild("Handle")
		local weld = handle and handle:FindFirstChild("CureGrip")
		if weld then
			weld:Destroy()
		end
	end

	-- Debug: cada vez que se equipa/desequipa esta cura, imprime el estado
	-- del brazo del rig actual (ver DEBUG_GRIP arriba para activar/desactivar).
	tool.Equipped:Connect(function()
		local char = tool.Parent
		local player = char and Players:GetPlayerFromCharacter(char)
		if player then
			debugArmState(player, tool, char)
		end
		if char then
			attachHandle(char)
		end
	end)
	tool.Unequipped:Connect(function()
		detachHandle()
		local backpack = tool.Parent
		local player = backpack and backpack:IsA("Backpack") and backpack.Parent
		if player and player:IsA("Player") then
			debugUnequip(player, tool)
		end
	end)

	return tool
end

local function backpackOf(player)
	return player:FindFirstChildOfClass("Backpack") or player:WaitForChild("Backpack", 10)
end

-- ¿el jugador ya tiene esa cura (en backpack o equipada)?
function ToolService:HasCure(player, cureName)
	for _, container in ipairs({ player:FindFirstChildOfClass("Backpack"), player.Character }) do
		if container then
			for _, obj in ipairs(container:GetChildren()) do
				if obj:IsA("Tool") and obj:GetAttribute("CureName") == cureName then
					return true
				end
			end
		end
	end
	return false
end

-- Da una cura suelta (para tienda/suministros). No duplica.
function ToolService:GrantCure(player, cureName)
	local cure = IllnessesAndCures.GetCures()[cureName]
	if not cure then return false end
	if self:HasCure(player, cureName) then return true end
	local backpack = backpackOf(player)
	if not backpack then return false end
	buildCureTool(cure).Parent = backpack
	return true
end

-- Repone el kit inicial SIN borrar curas ya conseguidas. Antes esto limpiaba
-- TODAS las Tools con CureName (Backpack + Character) en cada CharacterAdded
-- -- es decir, en cada respawn -- y como no se repone nada (STARTER_CURES
-- suele estar vacío en esta fase de progresión), las curas ganadas jugando
-- desaparecían del inventario apenas el personaje se recargaba por cualquier
-- motivo (morir, resetear, etc.). Ahora solo agrega lo que falte del kit.
function ToolService:GiveStarterKit(player)
	local backpack = backpackOf(player)
	if not backpack then return end

	local cures = IllnessesAndCures.GetCures()
	for _, name in ipairs(STARTER_CURES) do
		local cure = cures[name]
		if cure and not self:HasCure(player, name) then
			buildCureTool(cure).Parent = backpack
		end
	end
end

function ToolService:Init()
	if self._initialized then return end
	self._initialized = true

	local function hook(player)
		player.CharacterAdded:Connect(function()
			-- El Backpack se recrea en cada spawn; reponemos el kit inicial.
			task.spawn(function()
				self:GiveStarterKit(player)
			end)
		end)
		if player.Character then
			task.spawn(function()
				self:GiveStarterKit(player)
			end)
		end
	end

	Players.PlayerAdded:Connect(hook)
	for _, player in ipairs(Players:GetPlayers()) do
		hook(player)
	end

	-- print("[ToolService] inicializado — kit inicial de curas en el backpack")
end

return ToolService
