--FaypleStudios
local module = function(Conch, Config)
	Conch.register("fuselucktimer", {
		permissions = { Config.RequiredRole or "CustomAdmin" },

		arguments = function()
			return {
				kind = "argument",
				type = "number",
				name = "Luck",
				description = "The luck multiplier (1-100)"
			},
			{
				kind = "argument",
				type = "number",
				name = "Duration",
				description = "Duration in seconds (default: 900 = 15min)",
				optional = true
			}
		end,

		callback = function(luck, duration)
			duration = duration or 900

			if not luck or type(luck) ~= "number" then
				return false, "❌ Invalid luck value"
			end

			if luck < 1 then
				return false, "❌ Luck cannot be less than 1"
			end

			if luck > 100 then
				return false, "❌ Luck cannot exceed 100"
			end

			if duration < 60 then
				return false, "❌ Duration must be at least 60 seconds"
			end

			if duration > 86400 then
				return false, "❌ Duration cannot exceed 24 hours"
			end
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local MessagingService = game:GetService("MessagingService")
			local Players = game:GetService("Players")
			local currentTime = os.time()
			local endTime = currentTime + duration

			ReplicatedStorage:SetAttribute("FuseMachineLuck", luck)
			ReplicatedStorage:SetAttribute("FuseMachineLuckEventActive", true)
			ReplicatedStorage:SetAttribute("FuseMachineLuckStartTime", currentTime)
			ReplicatedStorage:SetAttribute("FuseMachineLuckEndTime", endTime)

			-- Запускаем EventService если есть
			local EventService
			local success = pcall(function()
				EventService = require(game.ServerScriptService.Services.EventService)
				if EventService and EventService.ExecuteEvent then
					EventService:ExecuteEvent("Fuse Machine Luck", duration)
				end
			end)
			notifyPlayersWithTimer(luck, duration)

			createAdminAddedSign(luck, duration)
			startLuckTimer(duration, luck)
			pcall(function()
				MessagingService:PublishAsync("GlobalLuckTimer", {
					Luck = luck,
					Duration = duration,
					FromServer = game.JobId,
					Executor = "Admin"
				})
			end)

			return string.format(
				"✅ Set fuse machine luck to x%.1f for %d seconds (%d:%02d)\n" ..
					"📢 Created 'Admin Added Fuse Machine Luck!' sign in Workspace",
				luck, duration, math.floor(duration / 60), duration % 60
			)
		end
	})
	Conch.register("removelucksign", {
		permissions = { Config.RequiredRole or "CustomAdmin" },

		arguments = function()
			return {}
		end,

		callback = function()
			removeLuckSign()
			return "✅ Removed Fuse Machine Luck sign from Workspace"
		end
	})

	Conch.register("clearlucksign", {
		alias = "removelucksign"
	})
end
local function createAdminAddedSign(luck, duration)
	removeLuckSign()

	local Workspace = game:GetService("Workspace")
	local sign = Instance.new("Part")
	sign.Name = "FuseMachineLuckSign"
	sign.Size = Vector3.new(15, 2, 0.5)
	sign.Position = Vector3.new(0, 10, 0)
	sign.Anchored = true
	sign.CanCollide = true
	sign.Material = Enum.Material.Neon
	sign.Color = Color3.fromRGB(255, 215, 0) -- Золотой цвет
	sign.Transparency = 0.2
	sign.Parent = Workspace
	local surfaceGui = Instance.new("SurfaceGui")
	surfaceGui.Name = "LuckSignGUI"
	surfaceGui.Face = Enum.NormalId.Front
	surfaceGui.AlwaysOnTop = true
	surfaceGui.Parent = sign
	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainFrame"
	mainFrame.Size = UDim2.new(1, 0, 1, 0)
	mainFrame.BackgroundTransparency = 1
	mainFrame.Parent = surfaceGui
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "Title"
	titleLabel.Size = UDim2.new(1, 0, 0.4, 0)
	titleLabel.Position = UDim2.new(0, 0, 0, 0)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "🎰 ADMIN ADDED FUSE MACHINE LUCK! 🎰"
	titleLabel.TextColor3 = Color3.fromRGB(255, 50, 50) -- Красный
	titleLabel.TextScaled = true
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextStrokeTransparency = 0.5
	titleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	titleLabel.Parent = mainFrame
	local luckLabel = Instance.new("TextLabel")
	luckLabel.Name = "LuckInfo"
	luckLabel.Size = UDim2.new(1, 0, 0.3, 0)
	luckLabel.Position = UDim2.new(0, 0, 0.4, 0)
	luckLabel.BackgroundTransparency = 1
	luckLabel.Text = string.format("LUCK MULTIPLIER: x%.1f", luck)
	luckLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- Золотой
	luckLabel.TextScaled = true
	luckLabel.Font = Enum.Font.GothamBold
	luckLabel.TextStrokeTransparency = 0.5
	luckLabel.Parent = mainFrame
	local timerLabel = Instance.new("TextLabel")
	timerLabel.Name = "Timer"
	timerLabel.Size = UDim2.new(1, 0, 0.3, 0)
	timerLabel.Position = UDim2.new(0, 0, 0.7, 0)
	timerLabel.BackgroundTransparency = 1
	timerLabel.Text = string.format("DURATION: %d:%02d", math.floor(duration / 60), duration % 60)
	timerLabel.TextColor3 = Color3.fromRGB(100, 255, 100) -- Зеленый
	timerLabel.TextScaled = true
	timerLabel.Font = Enum.Font.GothamBold
	timerLabel.TextStrokeTransparency = 0.5
	timerLabel.Parent = mainFrame
	local pointLight = Instance.new("PointLight")
	pointLight.Name = "SignLight"
	pointLight.Color = Color3.fromRGB(255, 215, 0)
	pointLight.Brightness = 2
	pointLight.Range = 20
	pointLight.Shadows = true
	pointLight.Parent = sign
	local particleEmitter = Instance.new("ParticleEmitter")
	particleEmitter.Name = "SignParticles"
	particleEmitter.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 100)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 215, 0))
	})
	particleEmitter.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.5),
		NumberSequenceKeypoint.new(1, 0.2)
	})
	particleEmitter.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.3),
		NumberSequenceKeypoint.new(1, 1)
	})
	particleEmitter.Lifetime = NumberRange.new(2, 3)
	particleEmitter.Rate = 20
	particleEmitter.Speed = NumberRange.new(1, 3)
	particleEmitter.Parent = sign
	positionSign(sign)
	updateSignTimer(sign, duration, luck)

	return sign
end
local function positionSign(sign)
	local Workspace = game:GetService("Workspace")
	local spawnLocation = Workspace:FindFirstChild("SpawnLocation") or 
		Workspace:FindFirstChild("Baseplate") or
		Workspace:FindFirstChild("Part")

	if spawnLocation then
		sign.Position = spawnLocation.Position + Vector3.new(0, 15, 0)
	else
		sign.Position = Vector3.new(0, 15, 0)
	end
	local Players = game:GetService("Players")
	local player = Players:GetPlayers()[1]

	if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local playerPos = player.Character.HumanoidRootPart.Position
		sign.CFrame = CFrame.new(sign.Position, Vector3.new(playerPos.X, sign.Position.Y, playerPos.Z))
	else
		sign.CFrame = CFrame.new(sign.Position) * CFrame.Angles(0, math.rad(180), 0)
	end
end


local function updateSignTimer(sign, duration, luck)
	task.spawn(function()
		local remaining = duration
		local timerLabel = sign:FindFirstChild("LuckSignGUI"):FindFirstChild("MainFrame"):FindFirstChild("Timer")

		while remaining > 0 and sign and sign.Parent do
			if timerLabel then
				timerLabel.Text = string.format("DURATION: %d:%02d", math.floor(remaining / 60), remaining % 60)
				if remaining < 60 then
					timerLabel.TextColor3 = Color3.fromRGB(255, 50, 50) -- Красный при <1 мин
				elseif remaining < 300 then
					timerLabel.TextColor3 = Color3.fromRGB(255, 165, 0) -- Оранжевый при <5 мин
				end
			end

			task.wait(1)
			remaining = remaining - 1
		end
		if sign and sign.Parent then
			local tweenService = game:GetService("TweenService")
			local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			local transparencyTween = tweenService:Create(sign, tweenInfo, {Transparency = 1})
			transparencyTween:Play()

			task.wait(2.5)
			sign:Destroy()
		end
	end)
end
local function removeLuckSign()
	local Workspace = game:GetService("Workspace")
	local sign = Workspace:FindFirstChild("FuseMachineLuckSign")

	if sign then
		local tweenService = game:GetService("TweenService")
		local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local transparencyTween = tweenService:Create(sign, tweenInfo, {Transparency = 1})
		transparencyTween:Play()

		task.wait(1.5)
		sign:Destroy()

		print("✅ Removed Fuse Machine Luck sign")
	end
end
local function notifyPlayersWithTimer(luck, duration)
	local Players = game:GetService("Players")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	for _, player in ipairs(Players:GetPlayers()) do
		pcall(function()
			local screenGui = Instance.new("ScreenGui")
			screenGui.Name = "FuseLuckNotification"
			screenGui.Parent = player:WaitForChild("PlayerGui")
			local mainFrame = Instance.new("Frame")
			mainFrame.Name = "MainFrame"
			mainFrame.Size = UDim2.new(0, 350, 0, 180)
			mainFrame.Position = UDim2.new(0.5, -175, 0.05, 0)
			mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			mainFrame.BackgroundTransparency = 0.2
			mainFrame.BorderSizePixel = 3
			mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
			mainFrame.Parent = screenGui
			local titleLabel = Instance.new("TextLabel")
			titleLabel.Name = "Title"
			titleLabel.Size = UDim2.new(1, 0, 0.25, 0)
			titleLabel.Position = UDim2.new(0, 0, 0, 0)
			titleLabel.BackgroundTransparency = 1
			titleLabel.Text = "🎰 ADMIN ADDED FUSE MACHINE LUCK!"
			titleLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
			titleLabel.TextScaled = true
			titleLabel.Font = Enum.Font.GothamBold
			titleLabel.Parent = mainFrame
			local luckLabel = Instance.new("TextLabel")
			luckLabel.Name = "Luck"
			luckLabel.Size = UDim2.new(1, 0, 0.2, 0)
			luckLabel.Position = UDim2.new(0, 0, 0.25, 0)
			luckLabel.BackgroundTransparency = 1
			luckLabel.Text = string.format("Luck Multiplier: x%.1f", luck)
			luckLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
			luckLabel.TextScaled = true
			luckLabel.Font = Enum.Font.GothamBold
			luckLabel.Parent = mainFrame
			local timerLabel = Instance.new("TextLabel")
			timerLabel.Name = "Timer"
			timerLabel.Size = UDim2.new(1, 0, 0.2, 0)
			timerLabel.Position = UDim2.new(0, 0, 0.45, 0)
			timerLabel.BackgroundTransparency = 1
			timerLabel.Text = string.format("Time: %d:%02d", math.floor(duration / 60), duration % 60)
			timerLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
			timerLabel.TextScaled = true
			timerLabel.Font = Enum.Font.GothamBold
			timerLabel.Parent = mainFrame
			local messageLabel = Instance.new("TextLabel")
			messageLabel.Name = "Message"
			messageLabel.Size = UDim2.new(1, 0, 0.2, 0)
			messageLabel.Position = UDim2.new(0, 0, 0.65, 0)
			messageLabel.BackgroundTransparency = 1
			messageLabel.Text = "Check the sign in Workspace!"
			messageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
			messageLabel.TextScaled = true
			messageLabel.Font = Enum.Font.Gotham
			messageLabel.Parent = mainFrame
			local closeButton = Instance.new("TextButton")
			closeButton.Name = "CloseButton"
			closeButton.Size = UDim2.new(0.4, 0, 0.15, 0)
			closeButton.Position = UDim2.new(0.3, 0, 0.85, 0)
			closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
			closeButton.Text = "CLOSE"
			closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			closeButton.TextScaled = true
			closeButton.Font = Enum.Font.GothamBold
			closeButton.Parent = mainFrame

			closeButton.MouseButton1Click:Connect(function()
				screenGui:Destroy()
			end)

			-- Автоматическое закрытие через 15 секунд
			task.delay(15, function()
				if screenGui and screenGui.Parent then
					screenGui:Destroy()
				end
			end)
		end)
	end
end

local function startLuckTimer(duration, luck)
	-- Créer des entrées fictives dans le Liveboard quand la Luck est mise
	local success, LiveboardService = pcall(function()
		return require(game.ServerScriptService.Services.LiveboardService)
	end)
	
	if success and LiveboardService and LiveboardService.CreateFakeEntry then
		-- Créer quelques entrées fictives aléatoires
		local fakeBrainrots = {"Headless Horseman", "Griffin", "Cerberus", "Dragon Cannelloni"}
		local numEntries = math.random(2, 5)
		
		for i = 1, numEntries do
			local brainrotName = fakeBrainrots[math.random(1, #fakeBrainrots)]
			LiveboardService.CreateFakeEntry(brainrotName, 1)
		end
		
		print(string.format("[fuseluck] 🎲 Créé %d entrées fictives dans le Liveboard", numEntries))
	end
	
	task.spawn(function()
		local remaining = duration

		while remaining > 0 do
			task.wait(1)
			remaining = remaining - 1

			-- Обновляем таймер каждые 60 секунд
			if remaining % 60 == 0 then
				local ReplicatedStorage = game:GetService("ReplicatedStorage")
				ReplicatedStorage:SetAttribute("FuseMachineLuckEndTime", os.time() + remaining)

				print(string.format(
					"⏰ Fuse machine luck: x%.1f - %d:%02d remaining",
					luck, math.floor(remaining / 60), remaining % 60
					))
			end
		end
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		ReplicatedStorage:SetAttribute("FuseMachineLuck", 1)
		ReplicatedStorage:SetAttribute("FuseMachineLuckEventActive", false)
		ReplicatedStorage:SetAttribute("FuseMachineLuckEndTime", nil)

		print("✅ Fuse machine luck reset to normal")
		removeLuckSign()
		local Players = game:GetService("Players")
		for _, player in ipairs(Players:GetPlayers()) do
			pcall(function()
				local screenGui = Instance.new("ScreenGui")
				local textLabel = Instance.new("TextLabel")
				textLabel.Size = UDim2.new(0, 300, 0, 50)
				textLabel.Position = UDim2.new(0.5, -150, 0.1, 0)
				textLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				textLabel.Text = "🎰 Fuse Machine luck has returned to normal"
				textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				textLabel.TextScaled = true
				textLabel.Parent = screenGui
				screenGui.Parent = player:WaitForChild("PlayerGui")

				task.wait(3)
				screenGui:Destroy()
			end)
		end
	end)
end

local MessagingService = game:GetService("MessagingService")

MessagingService:SubscribeAsync("GlobalLuckTimer", function(message)
	local data = message.Data
	if data.FromServer == game.JobId then return end

	print("🌐 Received global luck timer: " .. data.Luck .. " for " .. data.Duration .. "s")

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local currentTime = os.time()
	local endTime = currentTime + data.Duration

	ReplicatedStorage:SetAttribute("FuseMachineLuck", data.Luck)
	ReplicatedStorage:SetAttribute("FuseMachineLuckEventActive", true)
	ReplicatedStorage:SetAttribute("FuseMachineLuckStartTime", currentTime)
	ReplicatedStorage:SetAttribute("FuseMachineLuckEndTime", endTime)

	createAdminAddedSign(data.Luck, data.Duration)

	notifyPlayersWithTimer(data.Luck, data.Duration)

	startLuckTimer(data.Duration, data.Luck)

	print("✅ Applied global luck timer with sign")
end)

return module