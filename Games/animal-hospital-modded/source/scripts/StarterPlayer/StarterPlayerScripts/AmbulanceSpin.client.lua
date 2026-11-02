--[[ AmbulanceSpin — gira la ambulancia de exhibición 360° sobre el eje Y de forma
     continua y automática. Es puramente VISUAL (corre en el cliente), así no
     replica CFrames del modelo (208 partes) cada frame ni depende de ninguna compra. ]]
local RunService = game:GetService("RunService")

local SPEED = math.rad(60)   -- grados/seg -> 60°/s = una vuelta completa cada 6 s

local ambulance = workspace:WaitForChild("Monetization")
	:WaitForChild("AmbulanceCall")
	:WaitForChild("ambulance")

-- Pivote base capturado una vez (el modelo está anclado y quieto en el server).
local base = ambulance:GetPivot()
local pivotPos = base.Position
local angle = 0

RunService.RenderStepped:Connect(function(dt)
	angle = (angle + SPEED * dt) % (2 * math.pi)
	-- rotación alrededor del eje Y de mundo que pasa por el pivote
	ambulance:PivotTo(
		CFrame.new(pivotPos) * CFrame.Angles(0, angle, 0) * CFrame.new(-pivotPos) * base
	)
end)
