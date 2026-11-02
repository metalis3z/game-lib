-- GlobalAnnounceClient: displays global announcements + code redemption UI for all players
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local AdminSystem = ReplicatedStorage:WaitForChild("AdminSystem")
local remotes = AdminSystem:WaitForChild("Remotes")

local function make(parent, className, props)
	local obj = Instance.new(className)
	for k, v in props do obj[k] = v end
	obj.Parent = parent
	return obj
end

---------------------------------------------------------------- Global announcement display
local playerGui = player:WaitForChild("PlayerGui")
local announceGui = make(playerGui, "ScreenGui", {
	Name = "GlobalAnnounceGui",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
})

local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local HEAVY = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy)
announceGui.DisplayOrder = 30

-- les annonces s'empilent juste sous "Burn Power", en haut de l'écran
local announceContainer = make(announceGui, "Frame", {
	Size = UDim2.new(1, 0, 0, 0),
	AutomaticSize = Enum.AutomaticSize.Y,
	AnchorPoint = Vector2.new(0.5, 0),
	Position = UDim2.new(0.5, 0, 0, 150),
	BackgroundTransparency = 1,
})
make(announceContainer, "UIListLayout", {
	FillDirection = Enum.FillDirection.Vertical,
	HorizontalAlignment = Enum.HorizontalAlignment.Center,
	VerticalAlignment = Enum.VerticalAlignment.Top,
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 8),
})
announceContainer.Position = UDim2.new(0.5, 0, 0, 72) -- sous la barre du haut (la barre Burn n'existe plus)

local announceCounter = 0

-- largeur max d'un texte d'annonce : toute la largeur de l'écran (le conteneur est mis à l'échelle par UIScaler,
-- sa largeur "avant échelle" vaut celle de l'écran), moins la place de la tête et du nom
local function maxTextWidth(reserved)
	local width = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize.X or 1280
	local autoScale = announceContainer:FindFirstChild("AutoScale")
	local scale = autoScale and autoScale.Scale > 0 and autoScale.Scale or 1
	return math.max(300, width * 0.96 / scale - reserved) -- sur mobile le texte est réduit : il a donc plus de place "avant échelle"
end

-- apparition "pop" puis disparition, sans fondu (le relief du texte reste net)
local function popIn(frame, life)
	local scale = make(frame, "UIScale", {Scale = 0})
	TweenService:Create(scale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	task.delay(life, function()
		if not frame.Parent then return end
		local out = TweenService:Create(scale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0})
		out:Play()
		out.Completed:Wait()
		frame:Destroy()
	end)
end

local function showAnnouncement(adminName, text, userId)
	announceCounter += 1
	local frame = make(announceContainer, "Frame", {
		Size = UDim2.new(0, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundTransparency = 1,
		LayoutOrder = announceCounter,
	})
	make(frame, "UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 12),
	})
	local icon = make(frame, "ImageLabel", {
		Size = UDim2.new(0, 54, 0, 54),
		BackgroundTransparency = 1, -- juste la tête du joueur : ni rond, ni fond, ni contour
		Image = "",
		LayoutOrder = 1,
		Visible = type(userId) == "number" and userId > 0,
	})

	-- le nom de l'admin, puis le badge certifié de Roblox (seulement pour un vrai joueur, pas pour les messages d'event)
	local nameLabel = make(frame, "TextLabel", {
		Text = adminName,
		FontFace = HEAVY,
		TextSize = 32,
		TextColor3 = Color3.fromRGB(255, 216, 74),
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
		Size = UDim2.new(0, 0, 0, 0),
		LayoutOrder = 2,
	})
	make(nameLabel, "UIStroke", {Thickness = 4, Color = Color3.new(0, 0, 0), LineJoinMode = Enum.LineJoinMode.Round})
	make(frame, "TextLabel", {
		Name = "Verified",
		Text = utf8.char(0xE000), -- le logo certifié officiel de Roblox
		TextSize = 34,
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(34, 34),
		LayoutOrder = 3,
		Visible = icon.Visible,
	})
	local label = make(frame, "TextLabel", {
		Text = text,
		FontFace = HEAVY,
		TextSize = 32,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
		Size = UDim2.new(0, 0, 0, 0),
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		LayoutOrder = 4,
	})
	-- le texte reste sur UNE ligne, sur toute la largeur de l'écran : s'il est trop long, on réduit sa taille
	-- (jusqu'à 16) au lieu de le couper en deux ; il ne passe à la ligne qu'en tout dernier recours
	local maxWidth = maxTextWidth(utf8.len(tostring(adminName)) * 22 + (icon.Visible and 130 or 40) + 60)
	make(label, "UISizeConstraint", {MaxSize = Vector2.new(maxWidth, math.huge)})
	local size = 32
	while size > 16 do
		local ok, bounds = pcall(function()
			local params = Instance.new("GetTextBoundsParams")
			params.Text, params.Font, params.Size, params.Width = text, HEAVY, size, 100000
			return game:GetService("TextService"):GetTextBoundsAsync(params)
		end)
		if not ok or bounds.X <= maxWidth then break end
		size -= 2
	end
	label.TextSize = size
	make(label, "UIStroke", {Thickness = 4, Color = Color3.new(0, 0, 0), LineJoinMode = Enum.LineJoinMode.Round})

	-- avatar du vrai joueur (userId envoyé par le serveur)
	if icon.Visible then
		task.spawn(function()
			for _ = 1, 5 do
				local ok, thumb, ready = pcall(function()
					return Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
				end)
				if ok and thumb and ready then
					if icon.Parent then icon.Image = thumb end
					return
				end
				task.wait(1)
			end
		end)
	end
	popIn(frame, 7)
end

remotes.BroadcastAnnounce.OnClientEvent:Connect(function(adminName, text, userId)
	showAnnouncement(adminName, text, userId)
end)

-- œuf apparu (lancé par un admin, ou œuf spécial après la réinitialisation de la nuit) : juste un texte, en dégradé de la rareté
local RARITY_GRADIENT = {
	Common = {Color3.fromRGB(255, 255, 255), Color3.fromRGB(170, 255, 140)},
	Uncommon = {Color3.fromRGB(255, 255, 255), Color3.fromRGB(110, 235, 200)},
	Rare = {Color3.fromRGB(255, 255, 255), Color3.fromRGB(110, 190, 255)},
	Epic = {Color3.fromRGB(255, 255, 255), Color3.fromRGB(205, 130, 255)},
	Legendary = {Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 205, 70)},
	Mythic = {Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 95, 130)},
	Secret = {Color3.fromRGB(255, 255, 255), Color3.fromRGB(150, 150, 170), Color3.fromRGB(255, 255, 255)},
	Ancient = {Color3.fromRGB(255, 255, 255), Color3.fromRGB(150, 220, 90)},
	OG = {Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 190, 60)},
	Divine = {Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 228, 120), Color3.fromRGB(170, 225, 255)},
	Prismatic = {Color3.fromRGB(255, 110, 110), Color3.fromRGB(255, 235, 110), Color3.fromRGB(110, 200, 255), Color3.fromRGB(210, 120, 255)},
	Galactic = {Color3.fromRGB(130, 90, 255), Color3.fromRGB(90, 225, 255), Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 130, 230)},
	Phantom = {Color3.fromRGB(90, 255, 225), Color3.fromRGB(255, 255, 255), Color3.fromRGB(170, 110, 255), Color3.fromRGB(60, 50, 100)},
	Reset = {Color3.fromRGB(255, 255, 255), Color3.fromRGB(150, 255, 130)},
}
local function showEggSpawn(eggName, zoneTitle, rarity, _, _, _, giant, admin)
	announceCounter += 1
	local colors = RARITY_GRADIENT[rarity] or RARITY_GRADIENT.Common
	local text
	if rarity == "Reset" then
		text = "ALL THE EGGS HAVE BEEN RESET!"
	elseif admin then
		text = "ADMIN SPAWN · " .. string.upper(tostring(rarity)) .. " " .. string.upper(eggName) .. " in your server!  (" .. string.upper(zoneTitle) .. ")"
	else
		text = (giant and "GIANT " or "") .. string.upper(tostring(rarity)) .. " " .. string.upper(eggName) .. " spawned in " .. string.upper(zoneTitle) .. "!"
	end
	local label = make(nil, "TextLabel", {
		Text = text,
		TextTransparency = 1,
		FontFace = HEAVY,
		TextSize = (rarity == "Phantom" or rarity == "Galactic" or rarity == "Prismatic" or rarity == "Divine" or rarity == "OG" or rarity == "Ancient" or rarity == "Secret" or rarity == "Mythic" or giant) and 40 or 32,
		TextColor3 = Color3.new(1, 1, 1),
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
		Size = UDim2.new(0, 0, 0, 0),
		TextWrapped = true,
		LayoutOrder = announceCounter,
	})
	make(label, "UISizeConstraint", {MaxSize = Vector2.new(maxTextWidth(60), math.huge)})
	make(label, "UIStroke", {Thickness = 4, Color = Color3.new(0, 0, 0), LineJoinMode = Enum.LineJoinMode.Round})
	local points = {}
	for i, c in colors do points[i] = ColorSequenceKeypoint.new((i - 1) / (#colors - 1), c) end
	local shade = make(label, "UIGradient", {Color = ColorSequence.new(points), Rotation = 0})
	-- apparition et disparition en fondu
	local stroke = label:FindFirstChildOfClass("UIStroke")
	stroke.Transparency = 1
	label:SetAttribute("No3D", true)
	label.Parent = announceContainer
	local fadeIn = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(label, fadeIn, {TextTransparency = 0}):Play()
	TweenService:Create(stroke, fadeIn, {Transparency = 0}):Play()
	task.delay(7, function()
		if not label.Parent then return end
		local fadeOut = TweenInfo.new(0.8)
		TweenService:Create(label, fadeOut, {TextTransparency = 1}):Play()
		TweenService:Create(stroke, fadeOut, {Transparency = 1}):Play()
		task.wait(0.85)
		label:Destroy()
	end)
	task.spawn(function() -- le dégradé glisse sur le texte
		local start = os.clock()
		while label.Parent do
			shade.Offset = Vector2.new(math.sin((os.clock() - start) * 2.4) * 0.6, 0)
			task.wait()
		end
	end)
end
remotes:WaitForChild("EggSpawnAnnounce").OnClientEvent:Connect(showEggSpawn)

