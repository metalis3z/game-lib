-- Game passes: checks which passes each player owns (attributes "Pass_<Key>") and shows the VIP tag.
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ShopConfig = require(ReplicatedStorage:WaitForChild("ShopSystem"):WaitForChild("ShopConfig"))

local VIP_GRADIENT = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 240, 150)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 190, 40)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 240, 150)),
})

local CROWN = "rbxassetid://136875519361543"
local MONT = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
-- le NAME TAG du VIP : l'icône VIP et "VIP" en or qui brille (dégradé animé côté client).
-- Il se place au-dessus du tag spécial (TagService : "PlayerTag") si le joueur en a un.
local function addVipTag(character)
	local head = character:WaitForChild("Head", 5)
	if not head or head:FindFirstChild("VipTag") then return end
	local player = Players:GetPlayerFromCharacter(character)
	local tag = Instance.new("BillboardGui")
	tag.Name = "VipTag"
	tag.Size = UDim2.fromScale(5, 1.5)
	tag.StudsOffsetWorldSpace = Vector3.new(0, 2.9, 0)
	tag.LightInfluence = 0
	tag.MaxDistance = 120
	local row = Instance.new("Frame")
	row.BackgroundTransparency = 1
	row.Size = UDim2.fromScale(1, 1)
	row.Parent = tag
	local list = Instance.new("UIListLayout")
	list.FillDirection = Enum.FillDirection.Horizontal
	list.HorizontalAlignment = Enum.HorizontalAlignment.Center
	list.VerticalAlignment = Enum.VerticalAlignment.Center
	list.Padding = UDim.new(0.02, 0)
	list.Parent = row
	local crown = Instance.new("ImageLabel")
	crown.Name = "Crown"
	crown.BackgroundTransparency = 1
	crown.Image = CROWN
	crown.ScaleType = Enum.ScaleType.Fit
	crown.Size = UDim2.fromScale(1, 1)
	local ratio = Instance.new("UIAspectRatioConstraint")
	ratio.AspectRatio = 1
	ratio.Parent = crown
	crown.LayoutOrder = 1
	crown.Parent = row
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.FontFace = MONT
	label.TextScaled = true
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Text = "VIP"
	label.Size = UDim2.fromScale(0.36, 1)
	label.LayoutOrder = 2
	label.Parent = row
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 3
	stroke.Color = Color3.fromRGB(60, 30, 0)
	stroke.Parent = label
	local gradient = Instance.new("UIGradient")
	gradient.Color = VIP_GRADIENT
	gradient.Rotation = 90
	gradient.Parent = label
	game:GetService("CollectionService"):AddTag(gradient, "AnimatedGradient")
	tag.Parent = head
	-- au-dessus du tag spécial s'il y en a un (il peut arriver un peu après)
	local function stack()
		if head:FindFirstChild("PlayerTag") then tag.StudsOffsetWorldSpace = Vector3.new(0, 5.6, 0) end
	end
	stack()
	head.ChildAdded:Connect(function(child) if child.Name == "PlayerTag" then stack() end end)
end

local function refreshVip(player)
	if ShopConfig.HasPass(player, "VIP") and player.Character then
		task.spawn(addVipTag, player.Character)
	end
end

local function grant(player, key)
	player:SetAttribute("Pass_" .. key, true)
	if key == "VIP" then refreshVip(player) end
end

local function onPlayer(player)
	player.CharacterAdded:Connect(function() refreshVip(player) end)
	player:GetAttributeChangedSignal("Pass_VIP"):Connect(function() refreshVip(player) end)
	for _, pass in ShopConfig.Passes do
		if pass.Id > 0 then
			task.spawn(function()
				local ok, owns = pcall(MarketplaceService.UserOwnsGamePassAsync, MarketplaceService, player.UserId, pass.Id)
				if ok and owns and player.Parent then grant(player, pass.Key) end
			end)
		end
	end
end

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, passId, purchased)
	if not purchased then return end
	for _, pass in ShopConfig.Passes do
		if pass.Id == passId then grant(player, pass.Key) end
	end
end)

Players.PlayerAdded:Connect(onPlayer)
for _, player in Players:GetPlayers() do task.spawn(onPlayer, player) end
