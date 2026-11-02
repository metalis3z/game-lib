-- Au-dessus de chaque base : la tête (photo de l'avatar) de son propriétaire, ronde, à la place de l'icône maison, avec son nom
-- en dessous. On voit celle de tout le monde. "Your Base" et le revenu par seconde restent seulement au-dessus de sa propre base.
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local bases = workspace:WaitForChild("all base")
local FONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
local names = {}

local function nameOf(userId)
	local p = Players:GetPlayerByUserId(userId)
	if p then return p.DisplayName end
	if names[userId] == nil then
		names[userId] = false
		task.spawn(function()
			local ok, name = pcall(function() return Players:GetNameFromUserIdAsync(userId) end)
			names[userId] = ok and name or "Player"
		end)
	end
	return names[userId] or ""
end

local function decorate(home, ownerId)
	local image = home:FindFirstChildOfClass("ImageLabel")
	if not image then return end
	if not home:GetAttribute("HeadReady") then
		home:SetAttribute("HeadReady", true)
		local w = home.Size.X.Scale
		home.Size = UDim2.fromScale(w, w * 1.32) -- de la place pour le nom en dessous
		home.StudsOffset += Vector3.new(0, w * 0.26, 0) -- un peu plus haut : le nom reste au-dessus de "Your Base"
		image.AnchorPoint = Vector2.new(0.5, 0)
		image.Position = UDim2.fromScale(0.5, 0)
		image.Size = UDim2.fromScale(1, 0.76)
		image.BackgroundColor3 = Color3.fromRGB(235, 240, 255)
		image.BackgroundTransparency = 0
		image.ScaleType = Enum.ScaleType.Fit
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0.5, 0)
		corner.Parent = image
		local ring = Instance.new("UIStroke")
		ring.Thickness = 5
		ring.Color = Color3.new(1, 1, 1)
		ring.Parent = image
		local label = Instance.new("TextLabel")
		label.Name = "OwnerName"
		label.BackgroundTransparency = 1
		label.AnchorPoint = Vector2.new(0.5, 1)
		label.Position = UDim2.fromScale(0.5, 1)
		label.Size = UDim2.fromScale(1.6, 0.22)
		label.FontFace = FONT
		label.TextScaled = true
		label.TextColor3 = Color3.new(1, 1, 1)
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 3
		stroke.Parent = label
		label.Parent = home
	end
	image.Image = "rbxthumb://type=AvatarHeadShot&id=" .. ownerId .. "&w=150&h=150"
	local label = home:FindFirstChild("OwnerName")
	if label then label.Text = nameOf(ownerId) end
end

local function update(base)
	local ownerId = base:GetAttribute("OwnerUserId")
	local mine = ownerId == player.UserId
	local display = base:FindFirstChild("BaseDisplay")
	if not display then return end
	for _, gui in display:GetChildren() do
		if gui:IsA("BillboardGui") then
			if gui.Name == "HomeGui" then
				gui.Enabled = ownerId ~= nil and ownerId ~= 0
				if gui.Enabled then decorate(gui, ownerId) end
			else
				gui.Enabled = mine -- "Your Base" + revenu
			end
		end
	end
end

local function watch(base)
	if not base:IsA("Model") then return end
	update(base)
	base:GetAttributeChangedSignal("OwnerUserId"):Connect(function() update(base) end)
	base.ChildAdded:Connect(function(child)
		if child.Name == "BaseDisplay" then task.defer(update, base) end
	end)
end

for _, base in bases:GetChildren() do watch(base) end
bases.ChildAdded:Connect(watch)
-- le nom d'un joueur parti peut arriver un peu plus tard (requête) : on rafraîchit de temps en temps
while true do
	task.wait(3)
	for _, base in bases:GetChildren() do if base:IsA("Model") then update(base) end end
end
