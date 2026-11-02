-- Photos des animaux et des œufs dans les interfaces (ViewportFrame) : même cadrage et même éclairage partout.
--   Portrait.fill(view, template, prepare?)  -- copie le modèle dans le cadre, vu de trois quarts face ; prepare(model) avant la pose (mutation...)
--   Portrait.rays(parent, color?, transparency?, zIndex?)  -- éclat de rayons derrière la photo
local Portrait = {}

Portrait.Rays = "rbxassetid://81911207340002"
local VIEW = Vector3.new(0.62, 0.26, 1).Unit -- les animaux regardent vers +Z : on les voit de face, un peu de côté et d'en haut
local FOV = 24                               -- champ étroit : pas de déformation

function Portrait.fill(view, template, prepare)
	view:ClearAllChildren()
	if not template then return nil end
	local model = template:Clone()
	if prepare then prepare(model) end
	model:PivotTo(CFrame.new())
	model.Parent = view
	local body = model:FindFirstChild("Body")
	local center, radius
	if body and body:IsA("BasePart") then
		-- animal : cadré sur son corps, pour qu'il remplisse la photo (les ailes et l'auréole d'un ange dépassent un peu)
		center, radius = body.Position, body.Size.Magnitude / 2
		if model:GetAttribute("Angel") then
			center += Vector3.new(0, body.Size.Y * 0.14, 0)
			radius *= 1.2
		end
	else
		local cf, size = model:GetBoundingBox()
		center, radius = cf.Position, size.Magnitude / 2
	end
	local camera = Instance.new("Camera")
	camera.FieldOfView = FOV
	camera.CFrame = CFrame.lookAt(center + VIEW * (radius / math.sin(math.rad(FOV / 2)) * 0.84), center)
	camera.Parent = view
	view.CurrentCamera = camera
	view.Ambient = Color3.fromRGB(188, 190, 204)
	view.LightColor = Color3.fromRGB(255, 252, 244)
	view.LightDirection = Vector3.new(-0.5, -1, -0.9)
	return model
end

function Portrait.rays(parent, color, transparency, zIndex)
	local rays = Instance.new("ImageLabel")
	rays.Name = "Rays"
	rays.BackgroundTransparency = 1
	rays.AnchorPoint = Vector2.new(0.5, 0.5)
	rays.Position = UDim2.fromScale(0.5, 0.5)
	rays.Size = UDim2.fromScale(1.5, 1.5)
	rays.SizeConstraint = Enum.SizeConstraint.RelativeXX
	rays.Image = Portrait.Rays
	rays.ImageColor3 = color or Color3.new(1, 1, 1)
	rays.ImageTransparency = transparency or 0.5
	rays.ZIndex = zIndex or parent.ZIndex
	rays.Parent = parent
	return rays
end

-- couleurs des cartes par rareté : {clair (haut), soutenu (bas)}
local rgb = Color3.fromRGB
Portrait.RarityColors = {
	Common = {rgb(190, 250, 40), rgb(120, 215, 0)},
	Uncommon = {rgb(40, 240, 150), rgb(0, 185, 110)},
	Rare = {rgb(40, 185, 255), rgb(0, 125, 235)},
	Epic = {rgb(190, 70, 255), rgb(130, 20, 215)},
	Legendary = {rgb(255, 225, 40), rgb(245, 170, 0)},
	Mythic = {rgb(255, 100, 140), rgb(225, 30, 80)},
	Secret = {rgb(110, 110, 132), rgb(40, 40, 58)},
	Ancient = {rgb(170, 230, 90), rgb(90, 150, 40)},
	OG = {rgb(255, 215, 80), rgb(235, 130, 20)},
	Divine = {rgb(255, 250, 210), rgb(240, 200, 90)},
	Prismatic = {rgb(255, 130, 220), rgb(110, 90, 255)},
	Galactic = {rgb(90, 220, 255), rgb(100, 60, 230)},
	Exclusive = {rgb(255, 250, 220), rgb(255, 196, 60)},
}

return Portrait
