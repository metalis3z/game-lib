--[[ MonetizationSpins — gira 360° sobre el eje Y (mundo) los props de las compras:
     AdminPanel.default (MeshPart), BuyNPC.CheckInSign (Model), sword.ClassicSword
     y boombox.SuperFlyGoldBoombox (Tools -> su Handle). Todos anclados; giro server. ]]
local RunService = game:GetService("RunService")
local Monetization = workspace:WaitForChild("Monetization")

local SPEED = math.rad(70)   -- grados/seg

-- Resuelve el objeto que hay que girar (Tool -> Handle; Part/Model -> el mismo).
local function targetFor(prop, childName)
	local obj = prop and prop:FindFirstChild(childName)
	if not obj then return nil end
	if obj:IsA("Tool") then return obj:FindFirstChild("Handle") end
	return obj   -- BasePart o Model (ambos son PVInstance, sirven con PivotTo)
end

-- Resuelve un objeto por ruta anidada dentro de Monetization (para props que no
-- estan en el primer nivel, como HDadmin > HD Admin > Part).
local function nested(...)
	local obj = Monetization
	for _, name in ipairs({...}) do
		obj = obj and obj:FindFirstChild(name)
	end
	if obj and obj:IsA("Tool") then return obj:FindFirstChild("Handle") end
	return obj
end

local defs = {
	targetFor(Monetization:FindFirstChild("AdminPanel"), "default"),
	targetFor(Monetization:FindFirstChild("BuyNPC"),     "CheckInSign"),
	targetFor(Monetization:FindFirstChild("sword"),      "Handle"),
	targetFor(Monetization:FindFirstChild("boombox"),    "Handle"),
	nested("HDadmin", "HD Admin", "Part"),
}

local spins = {}
for _, pv in ipairs(defs) do
	if pv then
		if pv:IsA("BasePart") then pv.Anchored = true end
		local base = pv:GetPivot()
		table.insert(spins, { pv = pv, pos = base.Position, baseRot = base - base.Position, yaw = 0 })
	end
end

RunService.Heartbeat:Connect(function(dt)
	for _, s in ipairs(spins) do
		if s.pv and s.pv.Parent then
			s.yaw = s.yaw + SPEED * dt
			s.pv:PivotTo(CFrame.new(s.pos) * CFrame.Angles(0, s.yaw, 0) * s.baseRot)
		end
	end
end)
