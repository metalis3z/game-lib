-- Outil d'édition : le cercle devant chaque stand (Hammers, Trails). Un vrai rond, en une seule pièce :
--   * le sol : une SurfaceGui posée à plat, un disque translucide au bord épais et lumineux, un fin cercle intérieur
--   * le rideau : des étincelles et des traits de lumière qui montent du bord et s'effacent (deux ParticleEmitter)
-- return function() -> rapport
local CS = game:GetService("CollectionService")
local SHOPS = {
	{Stand = "HAMMER shop", Shop = "Hammers", Color = Color3.fromRGB(255, 176, 40)},
	{Stand = "Sell shopa", Shop = "Trails", Color = Color3.fromRGB(60, 200, 255)},
}
local R = 9.5

local function new(class, props, parent)
	local i = Instance.new(class)
	for k, v in props do i[k] = v end
	i.Parent = parent
	return i
end

return function()
	local out = {}
	for _, s in SHOPS do
		local stand = workspace[s.Stand]
		local old = stand:FindFirstChild("ShopZone") if old then old:Destroy() end
		local cf, size = stand:GetBoundingBox()
		local center = Vector3.new(cf.Position.X - size.X / 2 - 0.5, 0, cf.Position.Z) -- les stands regardent vers -X
		local hit = workspace:Raycast(center + Vector3.new(0, 10, 0), Vector3.new(0, -30, 0))
		local groundY = hit and hit.Position.Y or 0
		local model = new("Model", {Name = "ShopZone"}, nil)
		local disc = new("Part", {Name = "Disc", Size = Vector3.new(R * 2, 0.1, R * 2), CFrame = CFrame.new(center.X, groundY + 0.06, center.Z), Transparency = 1,
			Anchored = true, CanCollide = false, CanQuery = false, CanTouch = false, CastShadow = false}, model)
		model.PrimaryPart = disc
		local light = s.Color:Lerp(Color3.new(1, 1, 1), 0.45)

		-- sol : le rond
		local gui = new("SurfaceGui", {Name = "Circle", Face = Enum.NormalId.Top, SizingMode = Enum.SurfaceGuiSizingMode.FixedSize, CanvasSize = Vector2.new(1000, 1000),
			LightInfluence = 0, Brightness = 2.2, AlwaysOnTop = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}, disc)
		local fill = new("Frame", {Name = "Fill", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -44, 1, -44),
			BackgroundColor3 = light, BackgroundTransparency = 0.62, BorderSizePixel = 0}, gui)
		new("UICorner", {CornerRadius = UDim.new(0.5, 0)}, fill)
		new("UIGradient", {Rotation = 90, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.25), NumberSequenceKeypoint.new(0.5, 0.55), NumberSequenceKeypoint.new(1, 0.25)})}, fill)
		new("UIStroke", {Name = "Edge", Thickness = 30, Color = s.Color, Transparency = 0.05, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, fill)
		-- halo doux juste à l'extérieur du bord
		local halo = new("Frame", {Name = "Halo", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -8, 1, -8),
			BackgroundTransparency = 1, ZIndex = 0}, gui)
		new("UICorner", {CornerRadius = UDim.new(0.5, 0)}, halo)
		new("UIStroke", {Name = "Glow", Thickness = 14, Color = light, Transparency = 0.55, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, halo)
		-- fin cercle intérieur
		local inner = new("Frame", {Name = "Inner", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8),
			BackgroundTransparency = 1, ZIndex = 2}, gui)
		new("UICorner", {CornerRadius = UDim.new(0.5, 0)}, inner)
		new("UIStroke", {Name = "Line", Thickness = 6, Color = Color3.new(1, 1, 1), Transparency = 0.55, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}, inner)

		-- rideau : étincelles qui montent du bord, et traits de lumière étirés
		new("ParticleEmitter", {Name = "Motes", Texture = "rbxasset://textures/particles/sparkles_main.dds", Color = ColorSequence.new(Color3.new(1, 1, 1), s.Color),
			LightEmission = 1, LightInfluence = 0, Shape = Enum.ParticleEmitterShape.Disc, ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume, ShapePartial = 0.93,
			EmissionDirection = Enum.NormalId.Top, Rate = 26, Lifetime = NumberRange.new(1.4, 2.2), Speed = NumberRange.new(1.6, 3.2), SpreadAngle = Vector2.new(4, 4),
			Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0)}),
			Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1)})}, disc)
		new("ParticleEmitter", {Name = "Curtain", Texture = "rbxasset://textures/particles/sparkles_main.dds", Color = ColorSequence.new(light, s.Color),
			LightEmission = 1, LightInfluence = 0, Shape = Enum.ParticleEmitterShape.Disc, ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume, ShapePartial = 0.97,
			EmissionDirection = Enum.NormalId.Top, Rate = 70, Lifetime = NumberRange.new(0.8, 1.3), Speed = NumberRange.new(2.2, 3.4), SpreadAngle = Vector2.new(0, 0),
			Orientation = Enum.ParticleOrientation.VelocityParallel, Squash = NumberSequence.new(1.6),
			Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.42), NumberSequenceKeypoint.new(1, 0.3)}),
			Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(0.4, 0.7), NumberSequenceKeypoint.new(1, 1)})}, disc)
		new("PointLight", {Name = "Glow", Color = s.Color, Range = 14, Brightness = 0.8, Shadows = false}, disc)

		model:SetAttribute("Shop", s.Shop)
		model:SetAttribute("Radius", R)
		CS:AddTag(model, "ShopZone")
		model.Parent = stand
		for _, d in stand:GetDescendants() do if d:IsA("ProximityPrompt") then d.Enabled = false end end
		table.insert(out, string.format("%s: circle at (%.1f, %.2f, %.1f), radius %.1f, %d parts", s.Stand, center.X, groundY, center.Z, R, #model:GetChildren()))
	end
	return table.concat(out, "\n")
end
