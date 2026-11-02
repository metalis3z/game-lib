-- Effets des mutations des events du ciel (posés par TraitDeco.MutationFx sur les œufs et les animaux) :
--   tag "EventOrbit" : comètes (Cosmic) et halo (Alien) qui tournent autour du modèle, en laissant une traînée
--   tag "StormArc"   : arcs électriques (Storm) qui crépitent : ils sautent d'un point à l'autre autour du modèle
-- OPTIMISÉ : seulement près de la caméra (NEAR), la liste des effets proches est recalculée 3 fois par seconde (pas à chaque
-- image), et les réglages de chaque orbite sont lus une seule fois.
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local NEAR = 150
local camera = workspace.CurrentCamera
local orbits, arcs = {}, {}
local nearOrbits, nearArcs = {}, {}

local function orbitData(a)
	return {Phase = a:GetAttribute("Phase") or 0, Speed = a:GetAttribute("Speed") or 2, Radius = a:GetAttribute("Radius") or 2,
		Tilt = a:GetAttribute("Tilt") or 0, Height = a:GetAttribute("Height") or 0, Width = a:GetAttribute("Width") or 0.3, PartnerName = a:GetAttribute("Partner") or ""}
end
for _, a in CollectionService:GetTagged("EventOrbit") do orbits[a] = orbitData(a) end
CollectionService:GetInstanceAddedSignal("EventOrbit"):Connect(function(a) orbits[a] = orbitData(a) end)
CollectionService:GetInstanceRemovedSignal("EventOrbit"):Connect(function(a) orbits[a] = nil end)
for _, b in CollectionService:GetTagged("StormArc") do arcs[b] = true end
CollectionService:GetInstanceAddedSignal("StormArc"):Connect(function(b) arcs[b] = true end)
CollectionService:GetInstanceRemovedSignal("StormArc"):Connect(function(b) arcs[b] = nil end)

local function isNear(root, camPos)
	return root and root:IsA("BasePart") and (root.Position - camPos).Magnitude < NEAR
end

local rng = Random.new()
local nextScan, nextArc = 0, 0
RunService.RenderStepped:Connect(function()
	local t = os.clock()
	if t >= nextScan then
		nextScan = t + 0.33
		local camPos = camera.CFrame.Position
		table.clear(nearOrbits)
		for a, data in orbits do
			local root = a.Parent
			if isNear(root, camPos) then
				data.Partner = data.Partner and data.Partner.Parent == root and data.Partner or root:FindFirstChild(data.PartnerName)
				nearOrbits[a] = data
			end
		end
		for beam in arcs do
			if isNear(beam.Parent, camPos) then nearArcs[beam] = true
			else
				nearArcs[beam] = nil
				if beam.Enabled then beam.Enabled = false end
			end
		end
	end
	for a, data in nearOrbits do
		local angle = data.Phase + t * data.Speed
		local x, z = math.cos(angle) * data.Radius, math.sin(angle) * data.Radius
		local y = data.Height + z * math.sin(data.Tilt)
		z *= math.cos(data.Tilt)
		local pos = Vector3.new(x, y, z)
		a.Position = pos
		if data.Partner then data.Partner.Position = pos + Vector3.new(0, data.Width, 0) end
	end
	-- arcs : nouveau tracé ~12 fois par seconde, allumés une fois sur deux
	if t >= nextArc then
		nextArc = t + 0.08
		for beam in nearArcs do
			if beam.Parent and beam.Attachment0 and beam.Attachment1 then
				local on = rng:NextNumber() < 0.55
				beam.Enabled = on
				if on then
					local reach = beam:GetAttribute("Reach") or Vector3.new(2, 2, 2)
					local function point()
						return Vector3.new(rng:NextNumber(-1, 1) * reach.X, rng:NextNumber(-0.6, 1) * reach.Y, rng:NextNumber(-1, 1) * reach.Z)
					end
					beam.Attachment0.Position = point()
					beam.Attachment1.Position = point()
					local bend = reach.Magnitude * 0.6
					beam.CurveSize0 = rng:NextNumber(-bend, bend)
					beam.CurveSize1 = rng:NextNumber(-bend, bend)
				end
			else
				nearArcs[beam] = nil
			end
		end
	end
end)
