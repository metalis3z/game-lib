-- TradeMachine : animations côté client (flèches, anneaux, spirales, pulsations). Purement visuel.
local RunService = game:GetService("RunService")
local model = script.Parent
local MAX_DIST = script:GetAttribute("MaxDistance") or 180
local TURN = script:GetAttribute("ArrowTurnSeconds") or 3

local function find(name)
	local p = model:FindFirstChild(name, true)
	return (p and p:IsA("BasePart")) and p or nil
end
local function pair(a, b)
	if not (a and b) then return nil end
	return { parts = { a, b }, base = { a.CFrame, b.CFrame }, center = (a.Position + b.Position) / 2 }
end

-- wait until streamed in (the place uses StreamingEnabled)
while not (find("CentralPortal_Glass") and find("ExchangeArrows_ChamberBlue") and find("ExchangeArrows_ChamberGreen") and model.PrimaryPart) do
	task.wait(0.5)
end
local pivot = model:GetPivot()
local axis = pivot.LookVector
local glass = find("CentralPortal_Glass")
local center = glass and glass.Position or pivot.Position
local chamber = pair(find("ExchangeArrows_ChamberBlue"), find("ExchangeArrows_ChamberGreen"))
local crown = pair(find("ExchangeArrows_CrownBlue"), find("ExchangeArrows_CrownGreen"))
local rings = find("Effects_EnergyRings")
local ringsBase = rings and rings.CFrame
local light = model:FindFirstChild("TM_ChamberLight", true)
local lightBase = light and light.Brightness
local emitters = find("CentralPortal_Emitters")
local emitColor = emitters and emitters.Color

local spiral = {}
for _, a in ipairs(model:GetDescendants()) do
	if a:IsA("Attachment") and a.Name:match("^TM_VFX_Spiral") then
		table.insert(spiral, { att = a, base = a.WorldPosition })
	end
end

local function spin(info, angle)
	if not info then return end
	local c = info.center
	local rot = CFrame.new(c) * CFrame.fromAxisAngle(axis, angle) * CFrame.new(-c)
	for i, p in ipairs(info.parts) do
		p.CFrame = rot * info.base[i]
	end
end

local function setEffects(on)
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("ParticleEmitter") or d:IsA("Beam") then
			d.Enabled = on
		elseif d:IsA("BasePart") and d.Parent and d.Parent.Name == "Effects" and d.Name ~= "Effects_EnergyMotes" then
			d.LocalTransparencyModifier = on and 0 or 1
		end
	end
end
model:GetAttributeChangedSignal("EffectsEnabled"):Connect(function()
	setEffects(model:GetAttribute("EffectsEnabled") ~= false)
end)
setEffects(model:GetAttribute("EffectsEnabled") ~= false)

local t = 0
RunService.Heartbeat:Connect(function(dt)
	if model:GetAttribute("EffectsEnabled") == false then return end
	local cam = workspace.CurrentCamera
	if cam and (cam.CFrame.Position - center).Magnitude > MAX_DIST then return end
	t += dt
	local turn = -t * (2 * math.pi / TURN)
	spin(chamber, turn)
	spin(crown, turn)
	if rings then
		rings.CFrame = ringsBase + Vector3.yAxis * math.sin(t * 1.6) * 0.3
	end
	local orbit = CFrame.Angles(0, t * 1.4, 0)
	for _, s in ipairs(spiral) do
		local off = s.base - Vector3.new(center.X, s.base.Y, center.Z)
		s.att.WorldPosition = Vector3.new(center.X, s.base.Y, center.Z) + orbit:VectorToWorldSpace(off)
	end
	local pulse = 0.5 + 0.5 * math.sin(t * 3)
	if light then
		light.Brightness = lightBase * (0.85 + 0.3 * pulse)
	end
	if emitters then
		emitters.Color = emitColor:Lerp(Color3.new(1, 1, 1), 0.35 * pulse)
	end
end)
