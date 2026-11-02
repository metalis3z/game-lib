-- Coulées de lave (modèles "CouleeDeLave", tag "LavaFlow") : décor animé, sans collision ni dégâts.
-- La lave descend du bassin jusqu'au sol, des vagues claires glissent en continu le long de chaque coulée,
-- de grosses gouttes dévalent et éclaboussent la flaque, et le tout pulse comme de la roche en fusion.
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local TAG = "LavaFlow"
local FLOW_SPEED = 11   -- studs par seconde
local GROW_TIME = 4     -- secondes pour que la coulée atteigne le sol
local WAVES = 3         -- vagues claires par coulée
local RANGE = 450       -- au-delà, on n'anime pas
local rng = Random.new()

local function decor(size, color, parent)
	local p = Instance.new("Part")
	p.Anchored, p.CanCollide, p.CanTouch, p.CanQuery, p.CastShadow = true, false, false, false, false
	p.Material = Enum.Material.Neon
	p.Color = color
	p.Size = size
	p.Parent = parent
	return p
end

local flows = {}
local function setup(model)
	if flows[model] then return end
	local drips = {}
	for i = 1, 5 do
		local drip = model:FindFirstChild("Drip" .. i)
		local top, bottom = drip and drip:GetAttribute("Top"), drip and drip:GetAttribute("Bottom")
		if drip and top and bottom then
			local entry = {
				Drip = drip, Crust = model:FindFirstChild("DripCrust" .. i), Top = top, Bottom = bottom, Color = drip.Color,
				X = drip.Position.X, Z = drip.Position.Z, Rotation = drip.CFrame.Rotation, Width = drip.Size.X, Depth = drip.Size.Z,
				CrustWidth = 0, CrustDepth = 0, Delay = (i - 1) * 0.5, Waves = {},
				Blob = model:FindFirstChild("Blob" .. i), BlobCrust = model:FindFirstChild("BlobCrust" .. i), BlobY = top - rng:NextNumber(0, top - bottom),
			}
			if entry.Crust then entry.CrustWidth, entry.CrustDepth = entry.Crust.Size.X, entry.Crust.Size.Z end
			for w = 1, WAVES do
				table.insert(entry.Waves, {Part = decor(Vector3.new(entry.Width * 0.6, 3, entry.Depth + 0.15), Color3.fromRGB(255, 140, 20), model), Offset = (w - 1) / WAVES})
			end
			table.insert(drips, entry)
		end
	end
	if #drips == 0 then return end
	local puddle = model:FindFirstChild("Puddle")
	flows[model] = {Drips = drips, Start = os.clock(), Pool = model:FindFirstChild("Pool"), Puddle = puddle, Core = model:FindFirstChild("PuddleCore"),
		PuddleSize = puddle and puddle.Size, CoreSize = model:FindFirstChild("PuddleCore") and model.PuddleCore.Size, Embers = puddle and puddle:FindFirstChild("Embers")}
	model.Destroying:Connect(function() flows[model] = nil end)
end
-- les modèles peuvent arriver morceau par morceau : on réessaie tant qu'ils ne sont pas prêts
task.spawn(function()
	while true do
		for _, model in CollectionService:GetTagged(TAG) do
			if not flows[model] and model:IsDescendantOf(workspace) then setup(model) end
		end
		task.wait(1)
	end
end)

RunService.RenderStepped:Connect(function(dt)
	local t = os.clock()
	local cameraPosition = workspace.CurrentCamera.CFrame.Position
	for model, flow in flows do
		local first = flow.Drips[1]
		if (Vector3.new(first.X, first.Top, first.Z) - cameraPosition).Magnitude > RANGE then continue end
		local elapsed = t - flow.Start
		local glow = 0.5 + 0.5 * math.sin(t * 1.8)
		for index, d in flow.Drips do
			-- 1) la lave coule du bassin jusqu'au sol
			local k = math.clamp((elapsed - d.Delay) / GROW_TIME, 0.02, 1)
			k = 1 - (1 - k) ^ 2
			local full = d.Top - d.Bottom
			local length = full * k
			local sway = 1 + 0.06 * math.sin(t * 2.3 + index)
			d.Drip.Size = Vector3.new(d.Width * sway, length, d.Depth)
			d.Drip.CFrame = CFrame.new(d.X, d.Top - length / 2, d.Z) * d.Rotation
			d.Drip.Color = Color3.fromRGB(190, 52, 0):Lerp(Color3.fromRGB(235, 84, 0), glow)
			if d.Crust then
				d.Crust.Size = Vector3.new(d.CrustWidth, length, d.CrustDepth)
				d.Crust.CFrame = CFrame.new(d.Crust.Position.X, d.Top - length / 2, d.Crust.Position.Z) * d.Rotation
			end
			-- 2) vagues claires qui glissent vers le bas
			for _, wave in d.Waves do
				local progress = (t * FLOW_SPEED / full + wave.Offset + index * 0.13) % 1
				local y = d.Top - progress * full
				local visible = y > d.Top - length + 1.5
				local fade = math.sin(progress * math.pi)
				wave.Part.Transparency = visible and (1 - fade * 0.6) or 1
				wave.Part.Size = Vector3.new(d.Width * (0.45 + 0.25 * fade), 2.5 + 2.5 * fade, d.Depth + 0.15)
				wave.Part.CFrame = CFrame.new(d.X, y, d.Z) * d.Rotation
			end
			-- 3) une grosse goutte dévale la coulée et éclabousse la flaque
			if d.Blob then
				d.BlobY -= FLOW_SPEED * 1.5 * dt
				if d.BlobY < d.Bottom then
					d.BlobY = d.Top - rng:NextNumber(0, 6)
					if flow.Embers and k >= 1 then flow.Embers:Emit(8) end
				end
				local shown = d.BlobY > d.Top - length
				local stretch = 1 + 0.25 * math.sin(t * 6 + index)
				local rotation = d.Blob.CFrame.Rotation
				d.Blob.CFrame = CFrame.new(d.X, d.BlobY, d.Z) * rotation
				d.Blob.Transparency = shown and 0 or 1
				if d.BlobCrust then
					d.BlobCrust.CFrame = CFrame.new(d.BlobCrust.Position.X, d.BlobY, d.BlobCrust.Position.Z) * d.BlobCrust.CFrame.Rotation
					d.BlobCrust.Transparency = shown and 0 or 1
				end
			end
		end
		-- 4) le bassin et la flaque pulsent ; la flaque s'étale quand la lave arrive
		if flow.Pool then flow.Pool.Color = Color3.fromRGB(200, 56, 0):Lerp(Color3.fromRGB(240, 96, 0), glow) end
		local spread = math.clamp((elapsed - GROW_TIME * 0.8) / 2.5, 0.05, 1)
		if flow.Puddle then
			flow.Puddle.Size = Vector3.new(flow.PuddleSize.X * spread, flow.PuddleSize.Y, flow.PuddleSize.Z * spread * (1 + 0.04 * math.sin(t * 1.5)))
			flow.Puddle.Color = Color3.fromRGB(190, 50, 0):Lerp(Color3.fromRGB(235, 88, 0), glow)
		end
		if flow.Core then
			flow.Core.Size = Vector3.new(flow.CoreSize.X * spread * (0.9 + 0.1 * math.sin(t * 2.1)), flow.CoreSize.Y, flow.CoreSize.Z * spread * (0.85 + 0.15 * math.sin(t * 1.7 + 1)))
		end
	end
end)
