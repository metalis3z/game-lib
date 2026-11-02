--[[
	ToolGripService  — que CUALQUIER Tool funcione también morfeado

	PROBLEMA (Gun, M4, ClassicSword, Boombox, tools de clase...):
	  · Con RequiresHandle = true (el default de esos Tools), Roblox SOLO equipa
	    si el Character tiene "Right Arm" (R6) o "RightHand" (R15) para soldarle
	    el Handle. Los rigs de NPCs.* (los morphs) no tienen esas partes, así que
	    el equip fallaba EN SILENCIO: la Tool no se equipaba, no disparaba y
	    parecía desaparecer del hotbar.
	  · Y si uno suelda su propio Motor6D cuando el personaje SÍ tiene brazo,
	    quedan DOS motores sobre el mismo Handle (el "RightGrip" que crea Roblox
	    + el nuestro) y el solver de física tumba al jugador al suelo.

	SOLUCIÓN (la misma que ya funciona en ToolService para las curas):
	  · RequiresHandle = false en toda Tool que llegue al jugador -> Roblox
	    siempre deja equipar, tenga brazos o no.
	  · Al equipar: si el rig tiene brazo, se espera a que Roblox cree su
	    "RightGrip" y NO se suelda nada (posición nativa, cero tirón). Si no
	    aparece (morph sin brazos), se suelda un Motor6D "MorphGrip" al
	    HumanoidRootPart usando una "mano virtual" (HAND_OFFSET) y el tool.Grip
	    propio de la Tool, así conserva su orientación de siempre.
	  · Al desequipar se borra el MorphGrip.

	Las curas NO pasan por acá: ToolService ya las maneja con su propio grip.

	API: ToolGripService:Init(), :Prepare(tool)
]]

local Players = game:GetService("Players")

local ToolGripService = {}

-- "Mano virtual" relativa al HumanoidRootPart para los morphs sin brazos:
-- a la derecha (X), a la altura del pecho (Y) y algo adelante (Z negativa).
local HAND_OFFSET = CFrame.new(1.2, 0.9, -1.0)
local WELD_NAME = "MorphGrip"
-- Frames que se espera a que Roblox cree su RightGrip antes de dar por hecho
-- que el rig no tiene brazo.
local GRIP_WAIT_FRAMES = 12

-- Tabla débil: no marca la Tool con atributos (los atributos se copian al
-- clonar y una copia quedaría "preparada" pero sin conexiones).
local prepared = setmetatable({}, { __mode = "k" })

local function detach(tool)
	local handle = tool:FindFirstChild("Handle")
	local weld = handle and handle:FindFirstChild(WELD_NAME)
	if weld then
		weld:Destroy()
	end
end

local function attach(tool, char)
	local handle = tool:FindFirstChild("Handle")
	if not handle then return end

	local armPart = char:FindFirstChild("Right Arm") or char:FindFirstChild("RightHand")
	if armPart then
		-- Personaje normal: el RightGrip lo hace Roblox. Soldar otro motor sobre
		-- el mismo Handle es lo que tumbaba al jugador al piso.
		for _ = 1, GRIP_WAIT_FRAMES do
			if armPart:FindFirstChild("RightGrip") then return end
			if tool.Parent ~= char then return end
			task.wait()
		end
	end

	if handle:FindFirstChild(WELD_NAME) then return end

	local root = char:FindFirstChild("HumanoidRootPart")
		or char.PrimaryPart
		or char:FindFirstChild("Head")
	if not root then return end

	handle.CanCollide = false
	handle.Massless = true
	handle.Anchored = false

	local c0 = HAND_OFFSET
	local c1 = tool.Grip
	-- Misma fórmula que va a usar el Motor6D (Part1 = Part0 * C0 * C1:Inverse()):
	-- si no coinciden, el solver corrige el salto de golpe y sacude al personaje.
	handle.CFrame = root.CFrame * c0 * c1:Inverse()

	local weld = Instance.new("Motor6D")
	weld.Name = WELD_NAME
	weld.Part0 = root
	weld.Part1 = handle
	weld.C0 = c0
	weld.C1 = c1
	weld.Parent = handle
end

function ToolGripService:Prepare(tool)
	if typeof(tool) ~= "Instance" or not tool:IsA("Tool") then return end
	if prepared[tool] then return end
	-- Las curas ya las maneja ToolService (tienen su propio grip vertical).
	if tool:GetAttribute("CureName") then return end
	prepared[tool] = true

	tool.RequiresHandle = false

	tool.Equipped:Connect(function()
		local char = tool.Parent
		if char and char:IsA("Model") then
			task.spawn(attach, tool, char)
		end
	end)
	tool.Unequipped:Connect(function()
		detach(tool)
	end)

	-- Si ya estaba equipada al momento de prepararla.
	if tool.Parent and tool.Parent:IsA("Model") then
		task.spawn(attach, tool, tool.Parent)
	end
end

local function watch(container)
	if not container then return end
	for _, obj in ipairs(container:GetChildren()) do
		ToolGripService:Prepare(obj)
	end
	container.ChildAdded:Connect(function(obj)
		ToolGripService:Prepare(obj)
	end)
end

local function hookPlayer(player)
	watch(player:FindFirstChildOfClass("Backpack"))
	player.ChildAdded:Connect(function(child)
		if child:IsA("Backpack") then
			watch(child)
		end
	end)

	player.CharacterAdded:Connect(function(char)
		watch(char)
	end)
	if player.Character then
		watch(player.Character)
	end
end

function ToolGripService:Init()
	if self._initialized then return end
	self._initialized = true

	Players.PlayerAdded:Connect(hookPlayer)
	for _, player in ipairs(Players:GetPlayers()) do
		hookPlayer(player)
	end

	-- print("[ToolGripService] listo — Tools con Handle equipables también morfeado")
end

return ToolGripService
