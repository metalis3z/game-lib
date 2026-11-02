-- Fuse Machine 2 : animation côté client (anneaux qui tournent, œufs qui flottent, lumières qui pulsent, éclairs)
local RunService = game:GetService("RunService")
local m = script.Parent
local ring, ring2 = m:WaitForChild("Ring"), m:WaitForChild("Ring2")
local circle = m:WaitForChild("Details"):FindFirstChild("MagicCircle") -- (le cercle a été enlevé : la machine s'ouvre avec l'invite E)
local ringPivot, ring2Pivot, circlePivot = ring:GetPivot(), ring2:GetPivot(), circle and circle:GetPivot()

local bobbers, pulses, lights, needles, zaps = {}, {}, {}, {}, {}
for i, d in m:GetDescendants() do
	if d:IsA("BasePart") then
		if d:GetAttribute("Bob") then table.insert(bobbers, {part = d, base = d.CFrame, amp = d:GetAttribute("Bob"), phase = i * 0.7}) end
		if d:GetAttribute("Pulse") then table.insert(pulses, {part = d, base = d:GetAttribute("Pulse"), phase = i * 0.3}) end
		if d:GetAttribute("Needle") then table.insert(needles, {part = d, base = d.CFrame, center = d:GetAttribute("Center"), phase = i}) end
	elseif d:IsA("PointLight") then
		table.insert(lights, {light = d, base = d.Brightness, phase = i * 0.5})
	elseif d:IsA("Beam") and d:GetAttribute("Zap") then
		table.insert(zaps, d)
	end
end

local clock, nextZap = 0, 0
RunService.RenderStepped:Connect(function(dt)
	local camera = workspace.CurrentCamera
	if not camera or (camera.CFrame.Position - ringPivot.Position).Magnitude > 260 then return end -- trop loin : on ne calcule rien
	clock += dt
	local t = clock
	ring:PivotTo(ringPivot * CFrame.Angles(0, 0, t * 0.6))
	ring2:PivotTo(ring2Pivot * CFrame.Angles(0, 0, -t * 1.2))
	if circle then circle:PivotTo(circlePivot * CFrame.Angles(0, t * 0.35, 0)) end
	for _, b in bobbers do
		b.part.CFrame = b.base * CFrame.new(0, math.sin(t * 2 + b.phase) * b.amp, 0) * CFrame.Angles(0, t * 0.8, 0)
	end
	local beat = 0.5 + 0.5 * math.sin(t * 3)
	for _, p in pulses do
		local w = 0.5 + 0.5 * math.sin(t * 3 + p.phase)
		p.part.Transparency = math.clamp(p.base + (1 - p.base) * 0.45 * (1 - w), 0, 1)
	end
	for _, l in lights do
		l.light.Brightness = l.base * (0.7 + 0.5 * (0.5 + 0.5 * math.sin(t * 3 + l.phase)))
	end
	for _, n in needles do -- l'aiguille du cadran tremble autour d'une valeur
		local angle = math.sin(t * 1.3 + n.phase) * 0.9 + math.sin(t * 9 + n.phase) * 0.08
		local pivot = CFrame.new(n.center) * (n.base - n.base.Position)
		n.part.CFrame = pivot * CFrame.Angles(angle, 0, 0) * CFrame.new(0, 0.2, 0)
	end
	if t >= nextZap then -- éclairs : ils apparaissent par à-coups
		nextZap = t + 0.08 + math.random() * 0.25
		for _, z in zaps do
			z.Enabled = math.random() < 0.6
			z.CurveSize0 = (math.random() - 0.5) * 3
			z.CurveSize1 = (math.random() - 0.5) * 3
		end
	end
end)
