--[[
	MoveDebug — para cazar el congelamiento

	Escribe en el Output (cliente) qué pasa cuando apretás W y cuando el
	personaje camina. Lo importante es poder distinguir DOS causas distintas:

	  · MoveDir = 0 con la W apretada  -> el INPUT no llega al Humanoid: algo
	    apagó los controles (una GUI con Modal/foco, ContextActionService, el
	    PlayerModule deshabilitado, una cutscene que no devolvió el control).
	  · MoveDir distinto de 0 pero Vel ~ 0 -> el input SÍ llega pero el cuerpo no
	    se mueve: WalkSpeed 0/NaN, anclado, PlatformStand, Humanoid trabado en
	    FallingDown/Ragdoll, o atascado en la geometría.

	Poné DEBUG = false para apagarlo cuando ya no haga falta.
]]

local DEBUG = false

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- Cada cuánto avisa mientras seguís apretando W sin moverte.
local STUCK_AFTER = 0.6    -- s apretando W sin avanzar antes de gritar
local STUCK_REPEAT = 2     -- s entre avisos repetidos
local MOVING_SPEED = 1     -- studs/s: por debajo de esto se considera "quieto"

local function parts()
	local char = LocalPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local root = char and char:FindFirstChild("HumanoidRootPart")
	return char, hum, root
end

-- Foto del estado en una línea.
local function snapshot()
	local char, hum, root = parts()
	if not (char and hum and root) then
		return "sin personaje/Humanoid/HumanoidRootPart"
	end

	local vel = root.AssemblyLinearVelocity
	local flat = Vector3.new(vel.X, 0, vel.Z).Magnitude
	local move = hum.MoveDirection

	-- ¿alguna parte de la asamblea anclada? (te clava en el sitio)
	local anchored = nil
	for _, d in ipairs(char:GetDescendants()) do
		if d:IsA("BasePart") and d.Anchored then
			anchored = d.Name
			break
		end
	end

	return ("W=%s | MoveDir=%.2f | Vel=%.2f | WalkSpeed=%s | State=%s | Sit=%s | PlatformStand=%s | Anclado=%s | Morph=%s")
		:format(
			tostring(UserInputService:IsKeyDown(Enum.KeyCode.W)),
			move.Magnitude,
			flat,
			tostring(hum.WalkSpeed),
			tostring(hum:GetState()):gsub("Enum.HumanoidStateType.", ""),
			tostring(hum.Sit),
			tostring(hum.PlatformStand),
			anchored or "no",
			tostring(char:GetAttribute("IsMorph") == true)
		)
end

if not DEBUG then
	return
end

-- 1) Tecla W: al apretar y al soltar.
UserInputService.InputBegan:Connect(function(input, processed)
	if input.KeyCode ~= Enum.KeyCode.W then return end
	print(("[MoveDebug] W ABAJO%s | %s"):format(
		processed and " (la GUI se comio el input!)" or "", snapshot()))
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode ~= Enum.KeyCode.W then return end
	print("[MoveDebug] W ARRIBA | " .. snapshot())
end)

-- 2) Caminando: el Humanoid avisa su velocidad real (con debounce para no
--    inundar el Output: solo al arrancar y al frenar).
task.spawn(function()
	local function hookChar(char)
		local hum = char:WaitForChild("Humanoid", 10)
		if not hum then return end
		local movingBefore = false
		hum.Running:Connect(function(speed)
			local moving = speed > MOVING_SPEED
			if moving ~= movingBefore then
				movingBefore = moving
				print(("[MoveDebug] %s (%.1f studs/s) | %s")
					:format(moving and "CAMINANDO" or "QUIETO", speed, snapshot()))
			end
		end)
		hum.StateChanged:Connect(function(_, new)
			if new == Enum.HumanoidStateType.FallingDown
				or new == Enum.HumanoidStateType.PlatformStanding
				or new == Enum.HumanoidStateType.Ragdoll
				or new == Enum.HumanoidStateType.Seated
			then
				warn(("[MoveDebug] estado sospechoso -> %s | %s")
					:format(tostring(new):gsub("Enum.HumanoidStateType.", ""), snapshot()))
			end
		end)
	end

	LocalPlayer.CharacterAdded:Connect(hookChar)
	if LocalPlayer.Character then
		hookChar(LocalPlayer.Character)
	end
end)

-- 3) DETECTOR DE CONGELAMIENTO: W apretada y no avanzás -> avisa QUÉ pasa.
task.spawn(function()
	local holding = 0
	local lastWarn = 0

	while true do
		task.wait(0.2)

		local _, hum, root = parts()
		if not (hum and root) then
			holding = 0
			continue
		end

		if not UserInputService:IsKeyDown(Enum.KeyCode.W) then
			holding = 0
			continue
		end

		local vel = root.AssemblyLinearVelocity
		local flat = Vector3.new(vel.X, 0, vel.Z).Magnitude

		if flat > MOVING_SPEED then
			holding = 0
			continue
		end

		holding += 0.2
		if holding >= STUCK_AFTER and (os.clock() - lastWarn) >= STUCK_REPEAT then
			lastWarn = os.clock()
			local causa
			if hum.MoveDirection.Magnitude < 0.05 then
				causa = "el INPUT no llega al Humanoid (controles apagados / GUI con foco)"
			else
				causa = "el input llega pero el CUERPO no se mueve (velocidad, anclaje o atascado)"
			end
			warn(("[MoveDebug] APRETANDO W Y NO ME MUEVO -> %s | %s"):format(causa, snapshot()))
		end
	end
end)

print("[MoveDebug] activo — apretá W y mirá el Output")
