-- ScriptClient: GlobalPlayerDisplay - RAFRAÎCHISSEMENT RAPIDE
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local NOM_JEU = "STEAL A  "
local remoteEvent = nil
local ScreenGui = nil
local MainFrame = nil
local PlayerCountLabel = nil
local currentCount = 0

-- Création de l'interface (noir transparent en haut)
local function createUI()
	ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "GlobalPlayerUI"
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

	-- Frame principal (noir transparent)
	MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, 340, 0, 42)
	MainFrame.Position = UDim2.new(0.5, -170, 0, 10)
	MainFrame.BackgroundColor3 = Color3.fromRGB(9, 19, 207)
	MainFrame.BackgroundTransparency = 0.45
	MainFrame.BorderSizePixel = 0
	MainFrame.Parent = ScreenGui

	-- Coins arrondis
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 21)
	corner.Parent = MainFrame

	-- Bordure subtile
	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Color3.fromRGB(255, 255, 255)
	Stroke.Thickness = 1
	Stroke.Transparency = 0.7
	Stroke.Parent = MainFrame

	-- Icône globe
	local GlobeIcon = Instance.new("TextLabel")
	GlobeIcon.Size = UDim2.new(0, 32, 0, 32)
	GlobeIcon.Position = UDim2.new(0, 10, 0.5, -16)
	GlobeIcon.BackgroundTransparency = 1
	GlobeIcon.Text = "⛱️"
	GlobeIcon.TextSize = 18
	GlobeIcon.Font = Enum.Font.Gotham
	GlobeIcon.TextXAlignment = Enum.TextXAlignment.Center
	GlobeIcon.TextYAlignment = Enum.TextYAlignment.Center
	GlobeIcon.Parent = MainFrame

	-- Séparateur
	local Sep = Instance.new("Frame")
	Sep.Size = UDim2.new(0, 1, 0.5, 0)
	Sep.Position = UDim2.new(0, 50, 0.25, 0)
	Sep.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Sep.BackgroundTransparency = 0.6
	Sep.BorderSizePixel = 0
	Sep.Parent = MainFrame

	-- Titre du jeu
	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Size = UDim2.new(0, 130, 1, 0)
	TitleLabel.Position = UDim2.new(0, 60, 0, 0)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Text = NOM_JEU
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.TextSize = 14
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Parent = MainFrame

	-- Séparateur 2
	local Sep2 = Instance.new("Frame")
	Sep2.Size = UDim2.new(0, 1, 0.5, 0)
	Sep2.Position = UDim2.new(0, 198, 0.25, 0)
	Sep2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Sep2.BackgroundTransparency = 0.6
	Sep2.BorderSizePixel = 0
	Sep2.Parent = MainFrame

	-- Label du nombre de joueurs
	PlayerCountLabel = Instance.new("TextLabel")
	PlayerCountLabel.Size = UDim2.new(0, 130, 1, 0)
	PlayerCountLabel.Position = UDim2.new(0, 208, 0, 0)
	PlayerCountLabel.BackgroundTransparency = 1
	PlayerCountLabel.Text = "chargement..."
	PlayerCountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	PlayerCountLabel.Font = Enum.Font.GothamBold
	PlayerCountLabel.TextSize = 14
	PlayerCountLabel.TextXAlignment = Enum.TextXAlignment.Left
	PlayerCountLabel.Parent = MainFrame

	-- Petit dot vert (indicateur en ligne avec animation de refresh)
	local Dot = Instance.new("Frame")
	Dot.Size = UDim2.new(0, 9, 0, 9)
	Dot.Position = UDim2.new(1, -24, 0.5, -4.5)
	Dot.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
	Dot.BorderSizePixel = 0
	local dotCorner = Instance.new("UICorner")
	dotCorner.CornerRadius = UDim.new(1, 0)
	dotCorner.Parent = Dot
	Dot.Parent = MainFrame

	-- Animation du dot (pulsation)
	task.spawn(function()
		while ScreenGui and Dot and Dot.Parent do
			pcall(function()
				local tween = TweenService:Create(Dot, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
					BackgroundTransparency = 0.5,
					Size = UDim2.new(0, 11, 0, 11)
				})
				tween:Play()
				task.wait(1.2)
			end)
		end
	end)

	-- Animation d'apparition (glisse depuis le haut)
	MainFrame.Position = UDim2.new(0.5, -170, 0, -50)
	local appearTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.new(0.5, -170, 0, 10)
	})
	appearTween:Play()

	print("[CLIENT] Interface créée (rafraîchissement rapide)")
end

-- Animation de comptage (effet de défilement des nombres)
local function animateCount(label, newValue)
	local oldValue = tonumber(label.Text:match("(%d+)")) or 0
	if oldValue == newValue then return end

	local duration = 0.3
	local startTime = tick()
	local startValue = oldValue
	local endValue = newValue

	local function updateNumber()
		local elapsed = tick() - startTime
		local progress = math.min(1, elapsed / duration)
		local currentValue = math.floor(startValue + (endValue - startValue) * progress)
		label.Text = string.format("👥 %d en ligne", currentValue)

		if progress < 1 then
			task.wait()
			updateNumber()
		else
			label.Text = string.format("👥 %d en ligne", endValue)
		end
	end

	updateNumber()
end

-- Effet de flash (indique que le nombre a changé)
local function flashEffect()
	if not PlayerCountLabel then return end

	local originalColor = PlayerCountLabel.TextColor3
	PlayerCountLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
	task.wait(0.1)
	PlayerCountLabel.TextColor3 = originalColor
end

-- Animation de refresh (clignotement du dot)
local function refreshAnimation()
	local Dot = MainFrame:FindFirstChildWhichIsA("Frame")
	if Dot then
		local originalSize = Dot.Size
		local tween1 = TweenService:Create(Dot, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 14, 0, 14),
			BackgroundColor3 = Color3.fromRGB(255, 200, 100)
		})
		tween1:Play()
		tween1.Completed:Wait()

		local tween2 = TweenService:Create(Dot, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = originalSize,
			BackgroundColor3 = Color3.fromRGB(100, 255, 100)
		})
		tween2:Play()
	end
end

-- Mise à jour de l'affichage (avec animations)
local function updateDisplay(globalCount)
	if not PlayerCountLabel then return end

	-- Anime le compteur
	animateCount(PlayerCountLabel, globalCount)

	-- Effet flash si le nombre a changé
	if currentCount ~= 0 and currentCount ~= globalCount then
		flashEffect()
		refreshAnimation()
		print(string.format("[CLIENT] 🔄 Nombre changé: %d → %d", currentCount, globalCount))
	end

	currentCount = globalCount

	-- Animation de rafraîchissement subtile
	pcall(function()
		local tween = TweenService:Create(PlayerCountLabel, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			TextTransparency = 0.3
		})
		tween:Play()
		tween.Completed:Wait()

		local tween2 = TweenService:Create(PlayerCountLabel, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			TextTransparency = 0
		})
		tween2:Play()
	end)
end

-- Configuration des événements réseau
local function setupNetworkEvents()
	remoteEvent = ReplicatedStorage:WaitForChild("GlobalPlayerCount", 10)

	if remoteEvent then
		print("[CLIENT] ✅ Connecté au serveur - Réception des mises à jour rapides")
		remoteEvent.OnClientEvent:Connect(function(globalCount)
			if type(globalCount) == "number" then
				updateDisplay(globalCount)
			end
		end)
	else
		warn("[CLIENT] ❌ RemoteEvent non trouvé, réessai...")
		task.wait(2)
		setupNetworkEvents()
	end
end

-- Initialisation
local function init()
	print("[CLIENT] 🚀 Démarrage de l'interface (rafraîchissement 2 secondes)...")

	local player = Players.LocalPlayer
	if not player or not player.PlayerGui then
		player = Players.LocalPlayer
		player:WaitForChild("PlayerGui")
	end

	createUI()
	setupNetworkEvents()

	print("[CLIENT] ✅ Interface prête - Mise à jour automatique toutes les 2 secondes")
end

pcall(init)