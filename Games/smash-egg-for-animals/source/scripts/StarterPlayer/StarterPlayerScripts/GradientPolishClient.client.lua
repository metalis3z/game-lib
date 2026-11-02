-- GradientPolishClient : des dégradés plus beaux partout dans les menus, et des rayons de soleil à quelques endroits choisis.
--   * DÉGRADÉS : un dégradé simple à deux couleurs (fond d'un bouton ou d'un cadre) devient un dégradé à quatre étapes :
--     un reflet clair tout en haut, la couleur du haut, un passage doux, et le bas un peu plus profond. Les couleurs restent les
--     mêmes, elles ont juste plus de relief. Si un script remet un dégradé à deux couleurs (bouton acheté...), il est refait.
--     Pas touchés : les textes, les contours, les reflets (Gleam) et les dégradés de transparence.
--   * RAYONS : des rayons qui tournent lentement derrière les icônes Index / Shop et les gros boutons œufs / animaux.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Portrait = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("PetPortrait"))
local WHITE, BLACK = Color3.new(1, 1, 1), Color3.new(0, 0, 0)
local EXCLUDED = {PetInventoryGui = true, SettingsGui = true, InventoryButtonGui = true, TopBarGui = true} -- inventaire et réglages : on n'y touche pas

local function plain(sequence)
	local k = sequence.Keypoints
	return #k == 2
end
local function enrich(g)
	local k = g.Color.Keypoints
	local top, bottom = k[1].Value, k[2].Value
	g.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, top:Lerp(WHITE, 0.22)),
		ColorSequenceKeypoint.new(0.2, top),
		ColorSequenceKeypoint.new(0.62, top:Lerp(bottom, 0.6)),
		ColorSequenceKeypoint.new(1, bottom:Lerp(BLACK, 0.1)),
	})
end
local function eligible(g)
	local parent = g.Parent
	if not parent or not (parent:IsA("GuiButton") or parent:IsA("Frame")) then return false end
	if parent.Name == "Gleam" or parent:GetAttribute("NoGradientPolish") then return false end
	if parent.BackgroundTransparency > 0.6 then return false end
	local screen = parent:FindFirstAncestorWhichIsA("ScreenGui")
	if not screen or EXCLUDED[screen.Name] then return false end
	-- un dégradé de transparence (reflets, fondus) : on n'y touche pas
	for _, kp in g.Transparency.Keypoints do if kp.Value > 0.01 then return false end end
	return true
end
local watched = setmetatable({}, {__mode = "k"})
local function polish(g)
	if watched[g] or not eligible(g) then return end
	watched[g] = true
	if plain(g.Color) then enrich(g) end
	g:GetPropertyChangedSignal("Color"):Connect(function()
		if plain(g.Color) and eligible(g) then enrich(g) end
	end)
end

-- rayons de soleil derrière une icône
local rays = {}
local function raysBehind(icon, scale, transparency)
	if not icon or icon:FindFirstChild("SunRays") or not icon.Parent then return end
	-- un calque invisible posé exactement comme l'icône (même place, même taille), et les rayons centrés dedans :
	-- ils tournent pile autour de l'icône, même si elle est décalée dans le bouton
	local holder = Instance.new("Frame")
	holder.Name = "SunRaysHolder"
	holder.BackgroundTransparency = 1
	holder.AnchorPoint, holder.Position, holder.Size, holder.Rotation = icon.AnchorPoint, icon.Position, icon.Size, 0
	holder.ZIndex = math.max(icon.ZIndex - 1, 1)
	holder.Parent = icon.Parent
	icon:GetPropertyChangedSignal("Position"):Connect(function() holder.Position = icon.Position end)
	icon:GetPropertyChangedSignal("Size"):Connect(function() holder.Size = icon.Size end)
	local r = Portrait.rays(holder, Color3.fromRGB(255, 255, 235), transparency or 0.55, holder.ZIndex)
	r.Name = "SunRays"
	r.SizeConstraint = Enum.SizeConstraint.RelativeXY
	r.AnchorPoint = Vector2.new(0.5, 0.5)
	r.Position = UDim2.fromScale(0.5, 0.5)
	r.Size = UDim2.fromScale(scale, scale)
	local marker = Instance.new("BoolValue")
	marker.Name = "SunRays"
	marker.Parent = icon
	table.insert(rays, {ray = r, speed = 14 + math.random() * 10})
end
local function placeRays()
	local left = playerGui:FindFirstChild("left bottom")
	if left then
		for _, name in {"IndexButton", "ShopButton"} do
			local b = left:FindFirstChild(name, true)
			local face = b and b:FindFirstChild("Face")
			local icon = face and face:FindFirstChild("Icon")
			if icon then raysBehind(icon, 1.7, 0.6) end
		end
	end
	local dock = playerGui:FindFirstChild("GardenPanelGui")
	for _, name in {"Eggs", "Pets"} do
		local b = dock and dock:FindFirstChild(name, true)
		local icon = b and b:FindFirstChild("Icon")
		if icon then raysBehind(icon, 1.25, 0.55) end
	end
end
RunService.RenderStepped:Connect(function(dt)
	for _, r in rays do
		if r.ray.Parent then r.ray.Rotation = (r.ray.Rotation + r.speed * dt) % 360 end
	end
end)

for _, d in playerGui:GetDescendants() do if d:IsA("UIGradient") then task.defer(polish, d) end end
playerGui.DescendantAdded:Connect(function(d)
	if d:IsA("UIGradient") then task.delay(0.05, polish, d) end
end)
task.delay(2, placeRays)
task.delay(8, placeRays)
