-- Effets des mutations des events du ciel (posés par TraitDeco.MutationFx sur les œufs et les animaux) :
--   tag "EventOrbit" : comètes (Cosmic) et halo (Alien) qui tournent autour du modèle, en laissant une traînée
--   tag "StormArc"   : arcs électriques (Storm) qui crépitent : ils sautent d'un point à l'autre autour du modèle
-- Seulement près de la caméra (les effets lointains ne bougent pas : on ne les voit pas de toute façon).
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local NEAR = 260
local camera = workspace.CurrentCamera
local orbits, arcs = {}, {}

local function track(list, tag)
	for _, o in CollectionService:GetTagged(tag) do list[o] = true end
	CollectionService:GetInstanceAddedSignal(tag):Connect(function(o) list[o] = true end)
	CollectionService:GetInstanceRemovedSignal(tag):Connect(function(o) list[o] = nil end)
end
track(orbits, "EventOrbit")
track(arcs, "StormArc")

local function near(part)
	return part and (part.Position - camera.CFrame.Position).Magnitude < NEAR
end

local rng = Random.new()
local nextArc = 0
RunService.RenderStepped:Connect(function()
	local t = os.clock()
	for a in orbits do
		local root = a.Parent
		if root and root:IsA("BasePart") and near(root) then
			local angle = (a:GetAttribute("Phase") or 0) + t * (a:GetAttribute("Speed") or 2)
			local r = a:GetAttribute("Radius") or 2
			local tilt = a:GetAttribute("Tilt") or 0
			local x, z = math.cos(angle) * r, math.sin(angle) * r
			local y = (a:GetAttribute("Height") or 0) + z * math.sin(tilt)
			z *= math.cos(tilt)
			local pos = Vector3.new(x, y, z)
			a.Position = pos
			local partner = root:FindFirstChild(a:GetAttribute("Partner") or "")
			if partner then partner.Position = pos + Vector3.new(0, a:GetAttribute("Width") or 0.3, 0) end
		end
	end
	-- arcs : nouveau tracé ~12 fois par seconde, allumés une fois sur deux
	if t >= nextArc then
		nextArc = t + 0.08
		for beam in arcs do
			local root = beam.Parent
			if root and root:IsA("BasePart") and near(root) and beam.Attachment0 and beam.Attachment1 then
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
			elseif beam.Enabled then
				beam.Enabled = false
			end
		end
	end
end)
