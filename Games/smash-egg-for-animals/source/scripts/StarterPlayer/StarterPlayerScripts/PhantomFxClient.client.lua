-- Animaux Phantom (attribut Phantom, faits par AnimalWiring) : vie "fantôme" en plus de l'animation du kit (MeshAnimalClient).
--   * ils deviennent un peu transparents par vagues, et parfois "clignotent" comme un spectre (deux battements rapides)
--   * leur lueur cyan respire ; la brume sort plus fort quand ils bougent ; une petite gerbe d'étincelles quand ils clignotent
-- Tout est local et seulement pour les animaux proches de la caméra.
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local NEAR = 160
local rng = Random.new()
local list = {}
local function add(m)
	if list[m] or not m:IsA("Model") or not m:GetAttribute("Phantom") or m:GetAttribute("Rig") == "Reaper" then return end
	local root = m.PrimaryPart
	local body = m:FindFirstChild("Body")
	if not root or not body then return end
	list[m] = {Root = root, Body = body, Glow = root:FindFirstChild("PhantomGlow"), Mist = root:FindFirstChild("PhantomMist"), Sparks = root:FindFirstChild("PhantomSparks"),
		Seed = rng:NextNumber(0, 50), Next = os.clock() + rng:NextNumber(3, 9), Blink = nil, Last = root.Position, BaseGlow = nil, BaseMist = nil}
end
task.spawn(function()
	while true do
		for _, m in CollectionService:GetTagged("MeshAnimal") do
			if not list[m] and m:IsDescendantOf(workspace) then add(m) end
		end
		for m in list do if not m:IsDescendantOf(workspace) then list[m] = nil end end
		task.wait(1)
	end
end)
RunService.RenderStepped:Connect(function(dt)
	local cam = workspace.CurrentCamera
	local eye = cam and cam.CFrame.Position or Vector3.zero
	local now = os.clock()
	for m, e in list do
		local root, body = e.Root, e.Body
		if not root.Parent or not body.Parent then list[m] = nil continue end
		if (root.Position - eye).Magnitude > NEAR then e.Last = root.Position continue end
		local t = now + e.Seed
		local speed = (root.Position - e.Last).Magnitude / math.max(dt, 1e-3)
		e.Last = root.Position
		-- clignotement spectral
		local blink = 0
		if not e.Blink and now >= e.Next then e.Blink = 0 e.Next = now + rng:NextNumber(5, 11) if e.Sparks then e.Sparks:Emit(12) end end
		if e.Blink then
			e.Blink += dt
			if e.Blink > 0.5 then e.Blink = nil else blink = math.abs(math.sin(e.Blink * math.pi * 4)) end
		end
		body.Transparency = math.clamp(0.08 + 0.12 * (0.5 + 0.5 * math.sin(t * 1.3)) + 0.45 * blink, 0, 0.7)
		if e.Glow then
			e.BaseGlow = e.BaseGlow or e.Glow.Brightness
			e.Glow.Brightness = e.BaseGlow * (0.7 + 0.5 * (0.5 + 0.5 * math.sin(t * 2.2)) + 1.5 * blink)
		end
		if e.Mist then
			e.BaseMist = e.BaseMist or e.Mist.Rate
			e.Mist.Rate = e.BaseMist * (1 + math.clamp(speed / 6, 0, 2))
		end
	end
end)
