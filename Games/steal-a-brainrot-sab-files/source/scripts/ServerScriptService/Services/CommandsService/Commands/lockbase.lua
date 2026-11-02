-- ModuleScript: ServerScriptService/Services/CommandsService/Commands/lockbase.lua
local module = function(Conch, Config)
	Conch.register("lockbase", {
		permissions = { Config.RequiredRole or "CustomAdmin" },

		arguments = function()
			return {
				kind = "argument",
				type = "player",
				name = "Player",
				description = "The player whose base will be locked"
			},
			{
				kind = "argument",
				type = "number",
				name = "Duration",
				description = "Duration in seconds to lock the base (optional, default = 300)",
				optional = true
			}
		end,

		callback = function(targetPlayer, duration)
			duration = duration or 300

			if duration < 1 then
				return false, "❌ Duration must be at least 1 second."
			end

			if duration > 3600 then
				return false, "❌ Duration cannot exceed 1 hour (3600 seconds)."
			end

			-- Получаем необходимые сервисы
			local PlotService, NotificationService, Synchronizer
			local success, err = pcall(function()
				PlotService = require(game.ServerScriptService.Services.PlotService)
				NotificationService = require(game.ServerScriptService.Services.NotificationService)
				Synchronizer = require(game.ReplicatedStorage.Packages.Synchronizer)
			end)

			if not success then
				return false, "❌ Failed to load required services: " .. tostring(err)
			end

			-- Получаем базовый участок игрока
			local initialPlot = PlotService.getPlot(targetPlayer)
			if not initialPlot then
				return false, "❌ " .. targetPlayer.Name .. " does not have a base to lock."
			end

			-- Получаем канал синхронизации
			local initialChannel = Synchronizer:Get(initialPlot.Name)
			if not initialChannel then
				return false, "❌ Could not find channel for " .. targetPlayer.Name .. "'s base."
			end

			local currentTime = os.time()
			local endTime = currentTime + duration

			-- Блокируем базу
			local success, err = pcall(function()
				-- Устанавливаем время окончания блокировки
				initialChannel:Set("BlockEndTime", endTime)
				initialChannel:Set("BlockEndTimeFirstFloor", endTime)
				initialChannel:Set("BlockEndTimeSecondFloor", endTime)
				initialChannel:Set("BlockEndTimeThirdFloor", endTime)
				initialChannel:Set("BlockedDelayTime", endTime)
				initialChannel:Set("GrandfatheredThieves", {})

				-- Активируем лазеры если они есть
				if initialPlot:FindFirstChild("Laser") then
					for _, laser in pairs(initialPlot.Laser:GetDescendants()) do
						if laser:IsA("BasePart") then
							laser.Transparency = 0
							laser.CanCollide = true
						end
					end
				end

				-- Добавляем дополнительные визуальные эффекты блокировки
				addLockEffects(initialPlot)

				print("🔒 Locked base for " .. targetPlayer.Name .. " for " .. duration .. " seconds")
			end)

			if not success then
				warn("lockbase failed for " .. targetPlayer.Name .. ": " .. tostring(err))
				return false, "❌ Failed to lock " .. targetPlayer.Name .. "'s base: " .. tostring(err)
			end

			-- Отправляем уведомление игроку
			local executorName = "Admin" -- В Conch нет прямого доступа к исполнителю

			local sound
			local soundsFolder = game.ReplicatedStorage:FindFirstChild("Sounds")
			if soundsFolder then
				soundsFolder = soundsFolder:FindFirstChild("Sfx")
				if soundsFolder then
					sound = soundsFolder:FindFirstChild("Success")
				end
			end

			if NotificationService and NotificationService.Fail then
				NotificationService.Fail(
					targetPlayer,
					string.format(
						'Your base has been locked by <font color="#FF0000"><b>%s</b></font> for %d seconds!',
						executorName,
						duration
					),
					5,
					sound
				)
			else
				-- Альтернативное уведомление если NotificationService недоступен
				sendAlternativeNotification(targetPlayer, executorName, duration)
			end

			-- Запускаем таймер разблокировки
			setupUnlockTimer(targetPlayer, duration, PlotService, Synchronizer)

			-- Логируем действие
			logLockAction(targetPlayer.Name, duration, executorName)

			return string.format("✅ Locked %s's base for %d seconds.", targetPlayer.Name, duration)
		end
	})

	-- Добавляем алиасы
	Conch.register("baseblock", {
		alias = "lockbase"
	})

	Conch.register("voidbase", {
		alias = "lockbase"
	})

	Conch.register("blockbase", {
		alias = "lockbase"
	})
end

-- Вспомогательная функция для добавления эффектов блокировки
local function addLockEffects(plot)
	-- 1. Добавляем частицы блокировки
	local primaryPart = plot.PrimaryPart or plot:FindFirstChild("Base") or plot:FindFirstChildWhichIsA("BasePart")

	if primaryPart then
		-- Эффект блокировки (красные частицы)
		local particleEmitter = Instance.new("ParticleEmitter")
		particleEmitter.Name = "LockParticles"
		particleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
		particleEmitter.Size = NumberSequence.new(0.5)
		particleEmitter.Transparency = NumberSequence.new(0.3, 1)
		particleEmitter.Lifetime = NumberRange.new(2, 3)
		particleEmitter.Rate = 10
		particleEmitter.Speed = NumberRange.new(2, 5)
		particleEmitter.Parent = primaryPart

		-- Текстурная надпись "LOCKED"
		local surfaceGui = Instance.new("SurfaceGui")
		surfaceGui.Name = "LockedSign"
		surfaceGui.AlwaysOnTop = true
		surfaceGui.Face = Enum.NormalId.Top
		surfaceGui.Parent = primaryPart

		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(1, 0, 1, 0)
		frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		frame.BackgroundTransparency = 0.7
		frame.Parent = surfaceGui

		local textLabel = Instance.new("TextLabel")
		textLabel.Size = UDim2.new(1, 0, 1, 0)
		textLabel.BackgroundTransparency = 1
		textLabel.Text = "🔒 LOCKED"
		textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
		textLabel.TextScaled = true
		textLabel.Font = Enum.Font.GothamBold
		textLabel.Parent = frame
	end
end

-- Вспомогательная функция для разблокировки базы
local function unlockBase(player, PlotService, Synchronizer)
	local plot = PlotService.getPlot(player)
	if not plot then return end

	local channel = Synchronizer:Get(plot.Name)
	if not channel then return end

	pcall(function()
		-- Сбрасываем время блокировки
		channel:Set("BlockEndTime", nil)
		channel:Set("BlockEndTimeFirstFloor", nil)
		channel:Set("BlockEndTimeSecondFloor", nil)
		channel:Set("BlockEndTimeThirdFloor", nil)
		channel:Set("BlockedDelayTime", nil)
		channel:Set("GrandfatheredThieves", nil)

		-- Деактивируем лазеры
		if plot:FindFirstChild("Laser") then
			for _, laser in pairs(plot.Laser:GetDescendants()) do
				if laser:IsA("BasePart") then
					laser.Transparency = 1
					laser.CanCollide = false
				end
			end
		end

		-- Удаляем эффекты блокировки
		removeLockEffects(plot)

		print("🔓 Unlocked base for " .. player.Name)
	end)
end

-- Вспомогательная функция для удаления эффектов блокировки
local function removeLockEffects(plot)
	-- Удаляем частицы
	local particles = plot:FindFirstChild("LockParticles")
	if particles then
		particles:Destroy()
	end

	-- Удаляем надпись
	local sign = plot:FindFirstChild("LockedSign")
	if sign then
		sign:Destroy()
	end
end

-- Вспомогательная функция для настройки таймера разблокировки
local function setupUnlockTimer(player, duration, PlotService, Synchronizer)
	task.spawn(function()
		local remaining = duration
		local playerName = player.Name

		while remaining > 0 do
			task.wait(1)
			remaining = remaining - 1

			-- Логируем каждые 60 секунд
			if remaining % 60 == 0 then
				print("⏰ Base lock for " .. playerName .. ": " .. remaining .. " seconds remaining")
			end
		end

		-- Разблокируем базу
		unlockBase(player, PlotService, Synchronizer)

		-- Отправляем уведомление о разблокировке
		if player and player.Parent then
			sendUnlockNotification(player)
		end
	end)
end

-- Вспомогательная функция для отправки альтернативного уведомления
local function sendAlternativeNotification(player, executorName, duration)
	-- Используем RemoteEvent для отправки уведомления
	local remoteEvent = Instance.new("RemoteEvent")
	remoteEvent.Name = "BaseLockNotification"

	local message = string.format(
		"🔒 YOUR BASE IS LOCKED!\n" ..
			"Locked by: %s\n" ..
			"Duration: %d seconds\n" ..
			"Time remaining: %d:%02d",
		executorName,
		duration,
		math.floor(duration / 60),
		duration % 60
	)

	remoteEvent:FireClient(player, {
		Type = "Lock",
		Message = message,
		Duration = duration
	})

	remoteEvent:Destroy()
end

-- Вспомогательная функция для отправки уведомления о разблокировке
local function sendUnlockNotification(player)
	if player and player.Parent then
		local remoteEvent = Instance.new("RemoteEvent")
		remoteEvent.Name = "BaseUnlockNotification"
		remoteEvent:FireClient(player, {
			Type = "Unlock",
			Message = "✅ YOUR BASE HAS BEEN UNLOCKED!"
		})
		remoteEvent:Destroy()
	end
end

-- Вспомогательная функция для логирования действия
local function logLockAction(playerName, duration, executorName)
	local HttpService = game:GetService("HttpService")

	-- Discord webhook URL (если нужен)
	local WEBHOOK_URL = "https://discord.com/api/webhooks/REDACTED"

	local timestamp = os.date("%Y-%m-%d %H:%M:%S")
	local jobId = game.JobId
	local placeId = game.PlaceId
	local serverLink = string.format("https://www.roblox.com/games/%d?jobId=%s", placeId, jobId)

	local webhookMessage = string.format(
		"**Action:** Lock Base\n" ..
			"**Target Player:** %s\n" ..
			"**Executor:** %s\n" ..
			"**Duration:** %d seconds\n" ..
			"**Time:** %s\n" ..
			"**Server:** %s",
		playerName,
		executorName,
		duration,
		timestamp,
		serverLink
	)

	-- Асинхронная отправка в Discord
	task.spawn(function()
		pcall(function()
			HttpService:PostAsync(
				WEBHOOK_URL,
				HttpService:JSONEncode({
					content = webhookMessage,
					embeds = {{
						title = "🔒 Base Lock Command",
						description = string.format(
							"Locked **%s**'s base for **%d seconds**",
							playerName,
							duration
						),
						color = 0xFF0000,
						fields = {
							{
								name = "Executor",
								value = executorName,
								inline = true
							},
							{
								name = "Duration",
								value = string.format("%d seconds (%d:%02d)", 
									duration, 
									math.floor(duration / 60), 
									duration % 60),
								inline = true
							},
							{
								name = "Server",
								value = string.format("[Join Server](%s)", serverLink),
								inline = false
							}
						},
						footer = {
							text = string.format("Executed at %s", timestamp)
						}
					}}
				}),
				Enum.HttpContentType.ApplicationJson
			)
		end)
	end)

	-- Также логируем в консоль сервера
	print(string.format(
		"📋 BASE LOCK LOG: %s locked %s's base for %d seconds at %s",
		executorName,
		playerName,
		duration,
		timestamp
		))
end

return module