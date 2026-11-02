--[[ CheckFloor — pisos con SpeedMod (tag "FloorModifier").

	ARREGLO DEL CONGELAMIENTO: antes esto hacía
	    WalkSpeed = WalkSpeed * SpeedMod        (al pisar)
	    WalkSpeed = WalkSpeed / SpeedMod        (al salir)
	multiplicando/dividiendo la velocidad REAL, sin guardar la original. Eso se
	rompía de varias formas y te dejaba clavado en el sitio:
	  · un FloorModifier con SpeedMod = 0 dejaba WalkSpeed en 0, y al salir hacía
	    0 / 0 = NaN -> congelado PARA SIEMPRE (ni respawneando, porque al morfear
	    el personaje se reemplaza pero el bucle viejo ya había dejado el valor).
	  · si el bucle se saltaba la salida (el `continue` de "InCutscene", o el
	    personaje reemplazado por el MORPH a mitad de camino), el factor quedaba
	    aplicado y se acumulaba con el siguiente piso.
	Ahora se GUARDA la velocidad previa y al salir se RESTAURA tal cual; el
	multiplicador se clampea para que nunca pueda dejarla en 0.
]]

local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

task.wait(1)

local char = script.Parent
local Humanoid = char:WaitForChild("Humanoid")

local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Include

local DEFAULT_SPEED = 16
local MIN_MOD = 0.15   -- ni el piso más pegajoso puede dejarte en 0

local currentFloor = nil   -- instancia del FloorModifier que estamos pisando
local savedSpeed = nil     -- WalkSpeed que tenía ANTES de pisarlo

local function healthySpeed(n)
	-- n ~= n -> NaN
	if type(n) ~= "number" or n ~= n or n <= 0 then
		return nil
	end
	return n
end

while char.Parent and Humanoid.Health > 0 do
	task.wait(0.1)

	if workspace.CurrentCamera:HasTag("InCutscene") then
		continue
	end

	local root = char.PrimaryPart or char:FindFirstChild("HumanoidRootPart")
	if not root then
		continue
	end

	params.FilterDescendantsInstances = Lib.CS:GetTagged("FloorModifier")

	local hit = workspace:Raycast(root.Position, Vector3.new(0, -10, 0), params)

	if hit and hit.Instance then
		if not currentFloor then
			local sound = hit.Instance:FindFirstChildOfClass("Sound")
			local mod = hit.Instance.Parent and hit.Instance.Parent:GetAttribute("SpeedMod") or 1
			mod = math.max(tonumber(mod) or 1, MIN_MOD)

			savedSpeed = healthySpeed(Humanoid.WalkSpeed) or DEFAULT_SPEED

			if sound then
				sound:Play()
			end

			Humanoid.WalkSpeed = savedSpeed * mod
		end

		currentFloor = hit.Instance
		continue
	end

	if currentFloor then
		Humanoid.WalkSpeed = savedSpeed or DEFAULT_SPEED
		savedSpeed = nil
		currentFloor = nil
	end

	-- Red de seguridad: si algo (otro sistema, un morph a medio camino, un valor
	-- NaN heredado) dejó la velocidad en 0 o rota fuera de un FloorModifier, se
	-- devuelve a la normal en vez de dejarte clavado.
	if not healthySpeed(Humanoid.WalkSpeed) then
		Humanoid.WalkSpeed = DEFAULT_SPEED
	end
end
