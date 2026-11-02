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

	local safe = string.gsub(string.gsub(string.gsub(text, "&", "&amp;"), "<", "&lt;"), ">", "&gt;")
	local label = make(frame, "TextLabel", {
		RichText = true,
		Text = '<font color="#FFD84A">' .. adminName .. '</font>  ' .. safe,
		FontFace = HEAVY,
		TextSize = 32,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
		Size = UDim2.new(0, 0, 0, 0),
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		LayoutOrder = 2,
	})
	make(label, "UISizeConstraint", {MaxSize = Vector2.new(760, math.huge)})
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
	Halloween = {Color3.fromRGB(255, 150, 30), Color3.fromRGB(255, 220, 90), Color3.fromRGB(160, 60, 255)},
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
		TextSize = (rarity == "Halloween" or rarity == "Secret" or rarity == "Mythic" or giant) and 40 or 32,
		TextColor3 = Color3.new(1, 1, 1),
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.XY,
		Size = UDim2.new(0, 0, 0, 0),
		TextWrapped = true,
		LayoutOrder = announceCounter,
	})
	make(label, "UISizeConstraint", {MaxSize = Vector2.new(900, math.huge)})
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

---------------------------------------------------------------- Code redemption UI
local codeGui = make(playerGui, "ScreenGui", {
	Name = "CodeRedeemGui",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
})

local codeFrame = make(codeGui, "Frame", {
	Size = UDim2.new(0, 300, 0, 130),
	Position = UDim2.new(0.5, -150, 0.5, -65),
	BackgroundColor3 = Color3.fromRGB(25, 25, 35),
	BorderSizePixel = 0,
	Visible = false,
})
make(codeFrame, "UICorner", {CornerRadius = UDim.new(0, 2)})
make(codeFrame, "UIStroke", {Color = Color3.fromRGB(100, 100, 120), Thickness = 2})

make(codeFrame, "TextLabel", {
	Text = "REDEEM CODE",
	FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy),
	TextSize = 18,
	TextColor3 = Color3.fromRGB(255, 215, 0),
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 36),
})

local codeInput = make(codeFrame, "TextBox", {
	PlaceholderText = "Enter your code...",
	Text = "",
	FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy),
	TextSize = 15,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundColor3 = Color3.fromRGB(40, 40, 50),
	BorderSizePixel = 0,
	Size = UDim2.new(0, 260, 0, 36),
	Position = UDim2.new(0.5, -130, 0, 44),
	ClearTextOnFocus = false,
})
make(codeInput, "UICorner", {CornerRadius = UDim.new(0, 2)})
make(codeInput, "UIPadding", {PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)})

local resultLabel = make(codeFrame, "TextLabel", {
	Text = "",
	FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy),
	TextSize = 13,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 18),
	Position = UDim2.new(0, 0, 0, 88),
	TextWrapped = true,
})

local redeemBtn = make(codeFrame, "TextButton", {
	Text = "VALIDER",
	FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy),
	TextSize = 15,
	TextColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundColor3 = Color3.fromRGB(60, 130, 240),
	BorderSizePixel = 0,
	Size = UDim2.new(0, 120, 0, 28),
	Position = UDim2.new(0.5, -60, 0, 96),
})
make(redeemBtn, "UICorner", {CornerRadius = UDim.new(0, 2)})

local closeCodeBtn = make(codeFrame, "TextButton", {
	Text = "X",
	FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy),
	TextSize = 14,
	TextColor3 = Color3.fromRGB(255, 100, 100),
	BackgroundColor3 = Color3.fromRGB(50, 30, 30),
	BorderSizePixel = 0,
	Size = UDim2.new(0, 28, 0, 24),
	Position = UDim2.new(1, -34, 0, 6),
})
make(closeCodeBtn, "UICorner", {CornerRadius = UDim.new(0, 2)})

redeemBtn.MouseButton1Click:Connect(function()
	local code = codeInput.Text
	if code == "" then return end
	remotes.RedeemCode:FireServer(code)
	codeInput.Text = ""
end)

closeCodeBtn.MouseButton1Click:Connect(function()
	codeFrame.Visible = false
	resultLabel.Text = ""
end)

remotes.CodeResult.OnClientEvent:Connect(function(success, message)
	resultLabel.Text = message
	resultLabel.TextColor3 = success and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
	task.delay(3, function() if resultLabel.Parent then resultLabel.Text = "" end end)
end)

-- Toggle code redemption with F5
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.F5 then
		codeFrame.Visible = not codeFrame.Visible
		if codeFrame.Visible then
			codeInput:CaptureFocus()
			resultLabel.Text = ""
		end
	end
end)