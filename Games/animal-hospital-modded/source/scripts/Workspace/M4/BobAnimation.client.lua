-- BobAnimation
-- Flotado decorativo del modelo M4 (sube/baja suave en loop). Puramente
-- visual (LocalScript: cada cliente lo anima, sin costo de red/servidor).
-- El modelo tiene varias piezas sueltas SIN soldar entre si (cada una
-- Anchored por separado), asi que se mueve el conjunto entero con
-- Model:PivotTo (no alcanza con mover una sola part). El offset se suma en
-- espacio MUNDIAL (CFrame + Vector3) para que siempre "flote" hacia arriba
-- de verdad, sin importar la inclinacion con la que este apoyado el arma.

local RunService = game:GetService("RunService")

local model = script.Parent
local baseCFrame = model:GetPivot()

local BOB_HEIGHT = 0.6 -- studs que sube/baja
local BOB_TIME = 2 -- segundos por ciclo completo (subir + bajar)

RunService.Heartbeat:Connect(function()
	local t = (os.clock() % BOB_TIME) / BOB_TIME
	local offset = math.sin(t * math.pi * 2) * BOB_HEIGHT
	model:PivotTo(baseCFrame + Vector3.new(0, offset, 0))
end)
