--[[ SkullSpin — gira el Skull de exhibición de la compra SkipShift 360° sobre el
     eje Y de forma continua y automática. Es puramente VISUAL (corre en el cliente).
     El Handle está anclado en el server, así que sólo lo movemos en el render local. ]]
local RunService = game:GetService("RunService")

local SPEED = math.rad(60)   -- 60°/s -> una vuelta completa cada 6 s

local skull = workspace:WaitForChild("Monetization")
	:WaitForChild("SkipShift")
	:WaitForChild("Skull")

-- Pivote base capturado una vez (el modelo está anclado y quieto en el server).
local base = skull:GetPivot()
local pivotPos = base.Position
local angle = 0

RunService.RenderStepped:Connect(function(dt)
	angle = (angle + SPEED * dt) % (2 * math.pi)
	-- rotación alrededor del eje Y de mundo que pasa por el pivote
	skull:PivotTo(
		CFrame.new(pivotPos) * CFrame.Angles(0, angle, 0) * CFrame.new(-pivotPos) * base
	)
end)
