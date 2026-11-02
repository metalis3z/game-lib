--[[
	GunClient — lógica de disparo del arma (corre en el Backpack del jugador).
	Apunta con el mouse; al disparar avisa al servidor (autoritativo del daño y
	de la munición). El servidor guarda las balas en el atributo "Charges" del Tool
	y actualiza el nombre a "Gun (n)"; cuando llega a 0 el Tool se destruye.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local Lib = require(ReplicatedStorage:WaitForChild("Lib"))

local tool   = script.Parent
local handle = tool:WaitForChild("Handle")
local muzzle = handle:WaitForChild("Muzzle")
local shot   = handle:WaitForChild("Shot")

local player = Players.LocalPlayer
local mouse  = player:GetMouse()

local COOLDOWN = 0.35
local lastFire = 0

--[[ DEBUG del Handle en la mano ---------------------------------------------
	Para afinar cómo se agarra la pistola: con el Gun EQUIPADO, edita en el
	Explorer (durante Play) los atributos del Tool:
	  · GripPos (Vector3)  = desplazamiento del arma en la mano (studs)
	  · GripRot (Vector3)  = rotación en GRADOS (X, Y, Z)
	El arma se reorienta al instante y GripDebug imprime los valores. Cuando te
	guste, pásame GripPos/GripRot y los dejo fijos (y quito el debug).
]]
local function applyGrip(verbose)
	local pos = tool:GetAttribute("GripPos") or Vector3.new(0, 0, 0)
	local rot = tool:GetAttribute("GripRot") or Vector3.new(-90, -90, 0)
	-- fromOrientation (orden YXZ) para que coincida con GripRot guardado vía ToOrientation
	tool.Grip = CFrame.new(pos) * CFrame.fromOrientation(math.rad(rot.X), math.rad(rot.Y), math.rad(rot.Z))
	if verbose and tool:GetAttribute("GripDebug") then
		print(("[GunGrip] GripPos=%s  GripRot=%s (grados)"):format(tostring(pos), tostring(rot)))
	end
end

applyGrip(false)
-- Imprime SOLO cuando cambias un valor (para afinar), no en cada equip.
tool:GetAttributeChangedSignal("GripPos"):Connect(function() applyGrip(true) end)
tool:GetAttributeChangedSignal("GripRot"):Connect(function() applyGrip(true) end)
tool.Equipped:Connect(function() applyGrip(false) end)

-- Trazador visual rápido entre el cañón y el punto de impacto.
local function tracer(from, to)
	local dist = (to - from).Magnitude
	if dist < 0.1 then return end
	local part = Instance.new("Part")
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.Material = Enum.Material.Neon
	part.Color = Color3.fromRGB(255, 220, 120)
	part.Size = Vector3.new(0.12, 0.12, dist)
	part.CFrame = CFrame.lookAt((from + to) / 2, to)
	part.Parent = workspace
	Debris:AddItem(part, 0.06)
end

tool.Activated:Connect(function()
	local now = os.clock()
	if now - lastFire < COOLDOWN then return end
	if (tool:GetAttribute("Charges") or 0) <= 0 then return end
	lastFire = now

	local target = mouse.Hit and mouse.Hit.Position
	if not target then return end

	-- efectos locales inmediatos
	pcall(function() shot:Play() end)
	tracer(muzzle.WorldPosition, target)

	-- el servidor valida, aplica daño y descuenta la bala
	Lib.Network:FireServer("ShootGun", target)
end)
