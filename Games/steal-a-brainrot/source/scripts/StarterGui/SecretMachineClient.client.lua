local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Net = require(ReplicatedStorage.Packages.Net)
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Spin  = Net:RemoteFunction("SecretMachineService/Spin")
local Fetch = Net:RemoteFunction("SecretMachineService/Fetch")

-- ─── Couleurs par rareté ────────────────────────────────────────────────────
local RARITY_COLORS = {
	Common    = Color3.fromRGB(180, 180, 180),
	Uncommon  = Color3.fromRGB(100, 220, 100),
	Rare      = Color3.fromRGB(80, 120, 255),
	Epic      = Color3.fromRGB(180, 80, 255),
	Legendary = Color3.fromRGB(255, 200, 0),
}

-- ─── Créer l'UI ─────────────────────────────────────────────────────────────
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SecretMachineGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Bouton toggle (toujours visible)
local toggleBtn = Instance.new("ImageButton")
toggleBtn.Name = "Toggle"
toggleBtn.Size = UDim2.new(0, 60, 0, 60)
toggleBtn.Position = UDim2.new(0, 20, 0.5, -30)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 15, 60)
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = ""
toggleBtn.Parent = screenGui
local tc = Instance.new("UICorner"); tc.CornerRadius = UDim.new(1,0); tc.Parent = toggleBtn
local tl = Instance.new("TextLabel")
tl.Size = UDim2.new(1,0,1,0); tl.BackgroundTransparency = 1
tl.Text = "🔮"; tl.TextScaled = true; tl.Parent = toggleBtn

-- Frame principale
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 360, 0, 520)
mainFrame.Position = UDim2.new(0.5, -180, 0.5, -260)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 10, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui
local mc = Instance.new("UICorner"); mc.CornerRadius = UDim.new(0,16); mc.Parent = mainFrame
local ms = Instance.new("UIStroke"); ms.Color = Color3.fromRGB(100, 50, 200); ms.Thickness = 2; ms.Parent = mainFrame

-- Titre
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 50)
title.Position = UDim2.new(0, 10, 0, 8)
title.BackgroundTransparency = 1
title.Text = "🔮 Machine à Secrets"
title.TextColor3 = Color3.fromRGB(220, 180, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Bouton fermer
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 36, 0, 36)
closeBtn.Position = UDim2.new(1, -44, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 60)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = mainFrame
local cc = Instance.new("UICorner"); cc.CornerRadius = UDim.new(1,0); cc.Parent = closeBtn

-- Zone du secret révélé
local secretBox = Instance.new("Frame")
secretBox.Size = UDim2.new(1, -30, 0, 120)
secretBox.Position = UDim2.new(0, 15, 0, 65)
secretBox.BackgroundColor3 = Color3.fromRGB(30, 15, 60)
secretBox.BorderSizePixel = 0
secretBox.Parent = mainFrame
local sbc = Instance.new("UICorner"); sbc.CornerRadius = UDim.new(0,12); sbc.Parent = secretBox
local sbs = Instance.new("UIStroke"); sbs.Color = Color3.fromRGB(80, 40, 160); sbs.Thickness = 1.5; sbs.Parent = secretBox

local secretEmoji = Instance.new("TextLabel")
secretEmoji.Size = UDim2.new(0, 80, 1, 0)
secretEmoji.Position = UDim2.new(0, 10, 0, 0)
secretEmoji.BackgroundTransparency = 1
secretEmoji.Text = "❓"
secretEmoji.TextScaled = true
secretEmoji.Parent = secretBox

local secretName = Instance.new("TextLabel")
secretName.Size = UDim2.new(1, -100, 0.5, 0)
secretName.Position = UDim2.new(0, 95, 0, 10)
secretName.BackgroundTransparency = 1
secretName.Text = "Tourne la machine !"
secretName.TextColor3 = Color3.new(1,1,1)
secretName.TextScaled = true
secretName.Font = Enum.Font.GothamBold
secretName.TextXAlignment = Enum.TextXAlignment.Left
secretName.Parent = secretBox

local secretRarity = Instance.new("TextLabel")
secretRarity.Size = UDim2.new(1, -100, 0.4, 0)
secretRarity.Position = UDim2.new(0, 95, 0.55, 0)
secretRarity.BackgroundTransparency = 1
secretRarity.Text = ""
secretRarity.TextColor3 = Color3.fromRGB(180, 180, 180)
secretRarity.TextScaled = true
secretRarity.Font = Enum.Font.Gotham
secretRarity.TextXAlignment = Enum.TextXAlignment.Left
secretRarity.Parent = secretBox

-- Statut free / cost
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -30, 0, 32)
statusLabel.Position = UDim2.new(0, 15, 0, 195)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Chargement..."
statusLabel.TextColor3 = Color3.fromRGB(180, 255, 180)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

-- Bouton SPIN
local spinBtn = Instance.new("TextButton")
spinBtn.Size = UDim2.new(1, -30, 0, 56)
spinBtn.Position = UDim2.new(0, 15, 0, 235)
spinBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 220)
spinBtn.Text = "🎲 OBTENIR UN SECRET"
spinBtn.TextColor3 = Color3.new(1,1,1)
spinBtn.TextScaled = true
spinBtn.Font = Enum.Font.GothamBold
spinBtn.BorderSizePixel = 0
spinBtn.Parent = mainFrame
local spbc = Instance.new("UICorner"); spbc.CornerRadius = UDim.new(0,12); spbc.Parent = spinBtn
local spbg = Instance.new("UIGradient")
spbg.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 60, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 20, 160)),
})
spbg.Rotation = 90
spbg.Parent = spinBtn

-- Titre historique
local histTitle = Instance.new("TextLabel")
histTitle.Size = UDim2.new(1, -30, 0, 28)
histTitle.Position = UDim2.new(0, 15, 0, 300)
histTitle.BackgroundTransparency = 1
histTitle.Text = "📜 Derniers secrets obtenus"
histTitle.TextColor3 = Color3.fromRGB(180, 140, 255)
histTitle.TextScaled = true
histTitle.Font = Enum.Font.GothamBold
histTitle.Parent = mainFrame

-- Historique scrollable
local histFrame = Instance.new("ScrollingFrame")
histFrame.Size = UDim2.new(1, -30, 0, 185)
histFrame.Position = UDim2.new(0, 15, 0, 330)
histFrame.BackgroundColor3 = Color3.fromRGB(25, 12, 50)
histFrame.BorderSizePixel = 0
histFrame.ScrollBarThickness = 4
histFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 50, 200)
histFrame.CanvasSize = UDim2.new(0,0,0,0)
histFrame.Parent = mainFrame
local hfc = Instance.new("UICorner"); hfc.CornerRadius = UDim.new(0,10); hfc.Parent = histFrame
local hfl = Instance.new("UIListLayout"); hfl.Padding = UDim.new(0,4); hfl.Parent = histFrame

-- ─── Fonctions ──────────────────────────────────────────────────────────────

local spinning = false

local function refreshStatus(freeUsed, cost)
	if not freeUsed then
		statusLabel.Text = "✅ Spin gratuit disponible !"
		statusLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
	else
		statusLabel.Text = "💰 Coût : " .. tostring(cost) .. " coins"
		statusLabel.TextColor3 = Color3.fromRGB(255, 210, 100)
	end
end

local function buildHistoryRow(entry)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, -8, 0, 36)
	row.BackgroundColor3 = Color3.fromRGB(40, 20, 80)
	row.BorderSizePixel = 0
	local rc = Instance.new("UICorner"); rc.CornerRadius = UDim.new(0,8); rc.Parent = row

	local emojiL = Instance.new("TextLabel")
	emojiL.Size = UDim2.new(0, 36, 1, 0)
	emojiL.BackgroundTransparency = 1
	emojiL.Text = entry.Emoji or "🔮"
	emojiL.TextScaled = true
	emojiL.Parent = row

	local nameL = Instance.new("TextLabel")
	nameL.Size = UDim2.new(0.55, 0, 1, 0)
	nameL.Position = UDim2.new(0, 40, 0, 0)
	nameL.BackgroundTransparency = 1
	nameL.Text = entry.Name
	nameL.TextColor3 = Color3.new(1,1,1)
	nameL.TextScaled = true
	nameL.Font = Enum.Font.Gotham
	nameL.TextXAlignment = Enum.TextXAlignment.Left
	nameL.Parent = row

	local rarL = Instance.new("TextLabel")
	rarL.Size = UDim2.new(0.35, 0, 1, 0)
	rarL.Position = UDim2.new(0.65, 0, 0, 0)
	rarL.BackgroundTransparency = 1
	rarL.Text = entry.Rarity or ""
	rarL.TextColor3 = RARITY_COLORS[entry.Rarity] or Color3.new(1,1,1)
	rarL.TextScaled = true
	rarL.Font = Enum.Font.GothamBold
	rarL.TextXAlignment = Enum.TextXAlignment.Right
	rarL.Parent = row

	return row
end

local function refreshHistory(history)
	for _, c in ipairs(histFrame:GetChildren()) do
		if not c:IsA("UIListLayout") then c:Destroy() end
	end
	for _, entry in ipairs(history or {}) do
		buildHistoryRow(entry).Parent = histFrame
	end
	local totalH = #(history or {}) * 40
	histFrame.CanvasSize = UDim2.new(0,0,0,totalH)
end

local function fetchData()
	local ok, result = pcall(function()
		return Fetch:InvokeServer()
	end)
	if ok and result then
		refreshStatus(result.FreeUsed, result.CostPerSpin)
		refreshHistory(result.History)
	end
end

-- ─── Bouton SPIN ─────────────────────────────────────────────────────────────
spinBtn.MouseButton1Click:Connect(function()
	if spinning then return end
	spinning = true
	spinBtn.Text = "⏳ En cours..."
	spinBtn.BackgroundColor3 = Color3.fromRGB(60, 30, 100)

	local ok, result = pcall(function()
		return Spin:InvokeServer()
	end)

	task.wait(0.3)
	spinning = false
	spinBtn.Text = "🎲 OBTENIR UN SECRET"
	spinBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 220)

	if ok and result then
		if result.Success then
			local s = result.Secret
			-- Animer le résultat
			secretEmoji.Text = s.Emoji or "🔮"
			secretName.Text = s.Name
			secretRarity.Text = s.Rarity
			secretRarity.TextColor3 = RARITY_COLORS[s.Rarity] or Color3.new(1,1,1)
			-- Faire clignoter la boîte
			local col = RARITY_COLORS[s.Rarity] or Color3.fromRGB(100,50,200)
			TweenService:Create(sbs, TweenInfo.new(0.3), {Color = col, Thickness = 3}):Play()
			task.delay(1, function()
				TweenService:Create(sbs, TweenInfo.new(0.5), {Color = Color3.fromRGB(80,40,160), Thickness = 1.5}):Play()
			end)
			refreshStatus(result.FreeUsed, result.CostPerSpin)
			refreshHistory(result.History)
		else
			secretName.Text = result.Reason or "Erreur"
			secretRarity.Text = ""
			secretEmoji.Text = "❌"
		end
	else
		secretName.Text = "Erreur réseau"
		secretEmoji.Text = "⚠️"
	end
end)

-- ─── Toggle ──────────────────────────────────────────────────────────────────
toggleBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
	if mainFrame.Visible then
		fetchData()
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

-- Chargement initial différé
task.wait(3)
fetchData()
