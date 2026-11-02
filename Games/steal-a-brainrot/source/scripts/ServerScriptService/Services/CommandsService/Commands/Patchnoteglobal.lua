-- =====================================================
-- patchnoteglobal (ModuleScript) - Commands
-- =====================================================

local MessagingService = game:GetService("MessagingService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Channel = "GlobalBrainrotCustom_CountOnly"

-- ======= PATCH NOTES (rich‑text format) =======
local PATCH_NOTES = [[
<font size="18" color="#E5B8FF"><b>✨ New Commands</b></font>
  • <b>spawnrandomserverbrainrot</b> – Spawn a specific brainrot in random servers with custom mutation & traits
  • <b>spawnrandomog</b> – Spawn a random OG brainrot across servers
  • <b>spawnrandomsecret</b> – Spawn a random Secret brainrot across servers

<font size="18" color="#FFD166"><b>🎁 New Features</b></font>
  • <b>Code Redeem System</b> – Redeem codes for coins or brainrots directly in the shop

<font size="18" color="#6AFF8B"><b>🔧 Improvements</b></font>
  • UI animations and visual polish
  • Smoother scrolling and responsive behaviour
  • Added blur/dim background for better readability
]]

-- ======= UI améliorée à fond =======
local function showPatchNotes(player)
	local PlayerGui = player:FindFirstChild("PlayerGui")
	if not PlayerGui then return end

	-- Évite les doublons
	local existing = PlayerGui:FindFirstChild("PatchNoteUI")
	if existing then existing:Destroy() end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "PatchNoteUI"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	-- -------------------------------------------
	-- 1. Overlay sombre (fond cliqué pour fermer)
	-- -------------------------------------------
	local Overlay = Instance.new("TextButton")
	Overlay.Size = UDim2.fromScale(1, 1)
	Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Overlay.BackgroundTransparency = 1     -- animé plus tard
	Overlay.Text = ""
	Overlay.AutoButtonColor = false
	Overlay.ZIndex = 9
	Overlay.Parent = ScreenGui

	-- -------------------------------------------
	-- 2. Fenêtre principale
	-- -------------------------------------------
	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(0, 480, 0, 380)
	Frame.Position = UDim2.new(0.5, -240, 0.5, -190)
	Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	Frame.BorderSizePixel = 0
	Frame.ClipsDescendants = true
	Frame.ZIndex = 10
	Frame.Parent = ScreenGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 14)
	corner.Parent = Frame

	-- Bordure subtile avec un dégradé
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(80, 80, 120)
	stroke.Thickness = 1.5
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = Frame

	-- Dégradé de fond de la fenêtre
	local frameGradient = Instance.new("UIGradient")
	frameGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 35)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 22))
	})
	frameGradient.Rotation = 45
	frameGradient.Parent = Frame

	-- Ombre portée (simulée)
	local shadow = Instance.new("ImageLabel")
	shadow.Size = UDim2.new(1, 24, 1, 24)
	shadow.Position = UDim2.new(0, -12, 0, -12)
	shadow.BackgroundTransparency = 1
	shadow.Image = "rbxassetid://6015897843"  -- drop shadow asset (optionnel, peut être remplacé)
	shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	shadow.ImageTransparency = 0.6
	shadow.ScaleType = Enum.ScaleType.Slice
	shadow.SliceCenter = Rect.new(8, 8, 8, 8)
	shadow.ZIndex = 9
	shadow.Parent = Frame

	-- -------------------------------------------
	-- 3. Header
	-- -------------------------------------------
	local Header = Instance.new("Frame")
	Header.Size = UDim2.new(1, 0, 0, 48)
	Header.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	Header.BorderSizePixel = 0
	Header.ZIndex = 11
	Header.Parent = Frame

	local headerCorner = Instance.new("UICorner")
	headerCorner.CornerRadius = UDim.new(0, 14)
	headerCorner.Parent = Header

	-- Cache les coins du bas
	local headerFix = Instance.new("Frame")
	headerFix.Size = UDim2.new(1, 0, 0, 14)
	headerFix.Position = UDim2.new(0, 0, 1, -14)
	headerFix.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	headerFix.BorderSizePixel = 0
	headerFix.ZIndex = 11
	headerFix.Parent = Header

	-- Titre avec dégradé de texte
	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(1, -50, 1, 0)
	Title.Position = UDim2.new(0, 16, 0, 0)
	Title.BackgroundTransparency = 1
	Title.Text = "📜 PATCH NOTES"
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 16
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.ZIndex = 12
	Title.Parent = Header

	local titleGradient = Instance.new("UIGradient")
	titleGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(230, 180, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 200))
	})
	titleGradient.Rotation = 90
	titleGradient.Parent = Title

	-- Bouton de fermeture stylisé
	local CloseBtn = Instance.new("TextButton")
	CloseBtn.Size = UDim2.new(0, 36, 0, 36)
	CloseBtn.Position = UDim2.new(1, -42, 0.5, -18)
	CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
	CloseBtn.Text = "✕"
	CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseBtn.Font = Enum.Font.GothamBold
	CloseBtn.TextSize = 16
	CloseBtn.BorderSizePixel = 0
	CloseBtn.ZIndex = 13
	CloseBtn.Parent = Header

	local closeCorner = Instance.new("UICorner")
	closeCorner.CornerRadius = UDim.new(0, 8)
	closeCorner.Parent = CloseBtn

	local closeGradient = Instance.new("UIGradient")
	closeGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 80)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 40, 40))
	})
	closeGradient.Parent = CloseBtn

	-- Hover animation sur le bouton de fermeture
	local hoverTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local hoverAnimIn = TweenService:Create(CloseBtn, hoverTweenInfo, {
		BackgroundColor3 = Color3.fromRGB(255, 100, 100),
	})
	local hoverAnimOut = TweenService:Create(CloseBtn, hoverTweenInfo, {
		BackgroundColor3 = Color3.fromRGB(255, 70, 70),
	})

	CloseBtn.MouseEnter:Connect(function()
		hoverAnimIn:Play()
	end)
	CloseBtn.MouseLeave:Connect(function()
		hoverAnimOut:Play()
	end)

	-- -------------------------------------------
	-- 4. Contenu défilable (riche texte)
	-- -------------------------------------------
	local ScrollFrame = Instance.new("ScrollingFrame")
	ScrollFrame.Size = UDim2.new(1, -24, 1, -68)
	ScrollFrame.Position = UDim2.new(0, 12, 0, 56)
	ScrollFrame.BackgroundTransparency = 1
	ScrollFrame.BorderSizePixel = 0
	ScrollFrame.ScrollBarThickness = 5
	ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(160, 120, 240)
	ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	ScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
	ScrollFrame.ZIndex = 11
	ScrollFrame.Parent = Frame

	-- Barre de scroll personnalisée (optionnel, déjà intégré)

	local Content = Instance.new("TextLabel")
	Content.Size = UDim2.new(1, -8, 0, 0)
	Content.AutomaticSize = Enum.AutomaticSize.Y
	Content.BackgroundTransparency = 1
	Content.Text = ""        -- sera initialisé avec du rich text
	Content.RichText = true
	Content.TextColor3 = Color3.fromRGB(220, 220, 230)
	Content.Font = Enum.Font.Gotham
	Content.TextSize = 14
	Content.TextXAlignment = Enum.TextXAlignment.Left
	Content.TextYAlignment = Enum.TextYAlignment.Top
	Content.TextWrapped = true
	Content.ZIndex = 12
	Content.Parent = ScrollFrame

	-- Application du texte (rich text)
	Content.Text = PATCH_NOTES

	local padding = Instance.new("UIPadding")
	padding.PaddingTop = UDim.new(0, 6)
	padding.PaddingLeft = UDim.new(0, 4)
	padding.Parent = ScrollFrame

	-- -------------------------------------------
	-- 5. Animations d'entrée / sortie
	-- -------------------------------------------
	local animInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	-- Overlay fade
	local overlayFadeIn = TweenService:Create(Overlay, animInfo, {BackgroundTransparency = 0.55})
	-- Frame scale & slight slide
	Frame.Position = UDim2.new(0.5, -240, 0.55, -190)  -- légèrement décalé vers le bas
	Frame.BackgroundTransparency = 0.2                 -- légère transparence initiale

	local frameAppear = TweenService:Create(Frame, animInfo, {
		Position = UDim2.new(0.5, -240, 0.5, -190),
		BackgroundTransparency = 0
	})

	overlayFadeIn:Play()
	frameAppear:Play()

	-- Fermeture de l'UI
	local function closeUI()
		local closeInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		local overlayFadeOut = TweenService:Create(Overlay, closeInfo, {BackgroundTransparency = 1})
		local frameFadeOut = TweenService:Create(Frame, closeInfo, {
			Position = UDim2.new(0.5, -240, 0.45, -190),
			BackgroundTransparency = 0.6
		})

		overlayFadeOut:Play()
		frameFadeOut:Play()
		frameFadeOut.Completed:Connect(function()
			ScreenGui:Destroy()
		end)
	end

	-- Actions de fermeture
	CloseBtn.MouseButton1Click:Connect(closeUI)
	Overlay.MouseButton1Click:Connect(closeUI)   -- cliquer à l'extérieur ferme aussi

	-- Appuyer sur Echap (facultatif)
	local function onInputBegan(input, gameProcessed)
		if gameProcessed then return end
		if input.KeyCode == Enum.KeyCode.Escape then
			closeUI()
		end
	end
	local inputConn
	inputConn = game:GetService("UserInputService").InputBegan:Connect(onInputBegan)

	-- Nettoyage de la connexion quand l'UI est détruite
	ScreenGui.Destroying:Connect(function()
		if inputConn then inputConn:Disconnect() end
	end)

	ScreenGui.Parent = PlayerGui
end

-- ======= SUBSCRIBE =======
local Subscribed = false
if not Subscribed then
	Subscribed = true
if not _G._sub_cmd_Patchnoteglobal then _G._sub_cmd_Patchnoteglobal = true
pcall(function()
	MessagingService:SubscribeAsync(Channel, function(Message)
		local Data = Message.Data
		if typeof(Data) ~= "table" then return end
		if Data.Type ~= "PatchNote" then return end

		for _, player in ipairs(Players:GetPlayers()) do
			showPatchNotes(player)
		end
	end)
end) end
end

-- ======= MODULE =======
local Module = function(Conch, Config)
	Conch.register("patchnoteglobal", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function() return end,
		callback = function()
			local ok, err = pcall(function()
				MessagingService:PublishAsync(Channel, {
					Type = "PatchNote",
				})
			end)

			if not ok then
				return false, "MessagingService error: " .. tostring(err)
			end

			-- Affiche localement aussi
			for _, player in ipairs(Players:GetPlayers()) do
				showPatchNotes(player)
			end

			return "Patch notes sent to all servers!"
		end,
	})
end

return Module