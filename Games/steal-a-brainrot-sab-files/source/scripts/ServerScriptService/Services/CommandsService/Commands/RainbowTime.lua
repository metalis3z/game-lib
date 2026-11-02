-- ModuleScript: ServerScriptService/Services/CommandsService/Commands/rainbowtime.lua
local module = function(Conch, Config)
	Conch.register("rainbowtime", {
		permissions = { Config.RequiredRole or "Admin" },

		arguments = function()
			return {
				kind = "argument",
				type = "number",
				name = "Duration",
				description = "Duration in seconds (optional, default = 60)",
				optional = true
			}
		end,

		callback = function(duration)
			duration = duration or 60

			if duration < 10 or duration > 600 then
				return false, "Duration must be between 10 and 600 seconds"
			end

			-- Получаем необходимые сервисы
			local Workspace = game:GetService("Workspace")
			local RunService = game:GetService("RunService")
			local Debris = game:GetService("Debris")
			local Players = game:GetService("Players")

			-- Проверяем, уже ли активен RainbowTime
			if Workspace:GetAttribute("RainbowTimeActive") then
				return false, "❌ RainbowTime is already active!"
			end

			print("🌈 Starting RainbowTime for " .. duration .. " seconds...")

			-- Устанавливаем атрибут активности
			Workspace:SetAttribute("RainbowTimeActive", true)

			-- Загружаем данные мутаций
			local MutationsData
			local success, err = pcall(function()
				MutationsData = require(game:GetService("ReplicatedStorage").Datas.Mutations)
			end)

			if not success or not MutationsData then
				warn("⚠️ Could not load MutationsData: " .. tostring(err))
				return false, "❌ Failed to load mutations data"
			end

			-- Проверяем существует ли мутация Rainbow
			if not MutationsData.Rainbow then
				return false, "❌ Rainbow mutation not found in MutationsData"
			end

			print("✅ Found Rainbow mutation in system")

			-- Таблица для отслеживания затронутых животных
			local affectedAnimals = {}

			-- Функция для поиска животных в Workspace
			local function findAnimalsInWorkspace()
				local animals = {}

				local function searchFolder(folder)
					for _, child in ipairs(folder:GetChildren()) do
						-- Проверяем признаки животного
						if child:IsA("Model") then
							-- Проверяем наличие Humanoid (главный признак)
							if child:FindFirstChild("Humanoid") then
								-- Проверяем наличие Mutation значения
								local mutationValue = child:FindFirstChild("Mutation")
								if mutationValue and mutationValue:IsA("StringValue") then
									table.insert(animals, {
										Model = child,
										MutationValue = mutationValue
									})
								else
									-- Если нет Mutation, но есть Humanoid, это тоже животное
									table.insert(animals, {
										Model = child,
										MutationValue = nil
									})
								end
							end
						end

						-- Рекурсивно ищем в папках
						if child:IsA("Folder") or child:IsA("Model") then
							searchFolder(child)
						end
					end
				end

				searchFolder(Workspace)
				return animals
			end

			-- Функция для применения радужной мутации к животному
			local function applyRainbowMutation(animalData)
				if not animalData or not animalData.Model or not animalData.Model.Parent then
					return false
				end

				local animal = animalData.Model

				-- Проверяем, не обработано ли уже это животное
				if affectedAnimals[animal] then
					return false
				end

				print("🎨 Applying rainbow to: " .. animal.Name)

				-- Сохраняем информацию о животном
				local animalInfo = {
					Timestamp = os.time(),
					OriginalMutation = nil,
					OriginalPalette = nil,
					Effects = {}
				}

				-- Сохраняем оригинальную мутацию
				if animalData.MutationValue then
					animalInfo.OriginalMutation = animalData.MutationValue.Value
					animalInfo.OriginalPalette = animal:GetAttribute("MutationPalette")

					-- Устанавливаем радужную мутацию
					animalData.MutationValue.Value = "Rainbow"

					-- Устанавливаем палитру Rainbow (если поддерживается)
					animal:SetAttribute("MutationPalette", 1)
				else
					-- Создаем значение мутации если его нет
					local mutationValue = Instance.new("StringValue")
					mutationValue.Name = "Mutation"
					mutationValue.Value = "Rainbow"
					mutationValue.Parent = animal
					animalData.MutationValue = mutationValue

					-- Устанавливаем атрибут палитры
					animal:SetAttribute("MutationPalette", 1)
				end

				-- Устанавливаем атрибут для быстрого поиска
				animal:SetAttribute("RainbowTime", true)

				-- Добавляем дополнительные визуальные эффекты для усиления радуги
				local primaryPart = animal.PrimaryPart or 
					animal:FindFirstChild("HumanoidRootPart") or 
					animal:FindFirstChild("Head") or
					animal:FindFirstChildWhichIsA("BasePart")

				if primaryPart then
					-- 1. Частицы радуги
					local particleEmitter = Instance.new("ParticleEmitter")
					particleEmitter.Name = "RainbowTimeParticles"
					particleEmitter.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),      -- Красный
						ColorSequenceKeypoint.new(0.166, Color3.fromRGB(255, 165, 0)), -- Оранжевый
						ColorSequenceKeypoint.new(0.332, Color3.fromRGB(255, 255, 0)), -- Желтый
						ColorSequenceKeypoint.new(0.498, Color3.fromRGB(0, 255, 0)),    -- Зеленый
						ColorSequenceKeypoint.new(0.664, Color3.fromRGB(0, 0, 255)),    -- Синий
						ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75, 0, 130)),    -- Индиго
						ColorSequenceKeypoint.new(1, Color3.fromRGB(238, 130, 238))     -- Фиолетовый
					})
					particleEmitter.Size = NumberSequence.new(0.4)
					particleEmitter.Transparency = NumberSequence.new(0.3, 1)
					particleEmitter.Lifetime = NumberRange.new(1, 2)
					particleEmitter.Rate = 15
					particleEmitter.Speed = NumberRange.new(3, 6)
					particleEmitter.Parent = primaryPart

					animalInfo.Effects.Particles = particleEmitter

					-- 2. PointLight с меняющимся цветом
					local pointLight = Instance.new("PointLight")
					pointLight.Name = "RainbowTimeLight"
					pointLight.Color = Color3.fromRGB(255, 0, 0)
					pointLight.Brightness = 0.6
					pointLight.Range = 10
					pointLight.Shadows = true
					pointLight.Parent = primaryPart

					animalInfo.Effects.Light = pointLight

					-- 3. Анимация смены цвета света
					task.spawn(function()
						local colors = {
							Color3.fromRGB(255, 0, 0),      -- Красный
							Color3.fromRGB(255, 165, 0),    -- Оранжевый
							Color3.fromRGB(255, 255, 0),    -- Желтый
							Color3.fromRGB(0, 255, 0),      -- Зеленый
							Color3.fromRGB(0, 0, 255),      -- Синий
							Color3.fromRGB(75, 0, 130),     -- Индиго
							Color3.fromRGB(238, 130, 238)   -- Фиолетовый
						}

						local colorIndex = 1
						while animal and animal.Parent and animal:GetAttribute("RainbowTime") do
							pointLight.Color = colors[colorIndex]
							colorIndex = colorIndex + 1
							if colorIndex > #colors then
								colorIndex = 1
							end
							task.wait(0.2)
						end
					end)
				end

				-- Сохраняем в таблицу
				affectedAnimals[animal] = animalInfo

				return true
			end

			-- Функция для восстановления оригинального состояния
			local function revertRainbowMutation(animal)
				if not animal or not animal.Parent then
					return
				end

				local animalInfo = affectedAnimals[animal]
				if not animalInfo then
					return
				end

				print("↩️ Reverting rainbow from: " .. animal.Name)

				-- Восстанавливаем оригинальную мутацию
				local mutationValue = animal:FindFirstChild("Mutation")
				if mutationValue and mutationValue:IsA("StringValue") then
					if animalInfo.OriginalMutation then
						mutationValue.Value = animalInfo.OriginalMutation

						-- Восстанавливаем оригинальную палитру
						if animalInfo.OriginalPalette then
							animal:SetAttribute("MutationPalette", animalInfo.OriginalPalette)
						else
							animal:SetAttribute("MutationPalette", nil)
						end
					else
						-- Если не было оригинальной мутации, удаляем созданную
						mutationValue:Destroy()
						animal:SetAttribute("MutationPalette", nil)
					end
				end

				-- Удаляем атрибут
				animal:SetAttribute("RainbowTime", nil)

				-- Удаляем эффекты
				if animalInfo.Effects then
					if animalInfo.Effects.Particles then
						animalInfo.Effects.Particles.Enabled = false
						Debris:AddItem(animalInfo.Effects.Particles, 1)
					end
					if animalInfo.Effects.Light then
						animalInfo.Effects.Light:Destroy()
					end
				end

				-- Удаляем из таблицы
				affectedAnimals[animal] = nil
			end

			-- 1. Находим и обрабатываем существующих животных
			print("🔍 Searching for existing animals...")
			local existingAnimals = findAnimalsInWorkspace()
			local initialCount = 0

			for _, animalData in ipairs(existingAnimals) do
				if applyRainbowMutation(animalData) then
					initialCount = initialCount + 1
				end
			end

			print("✅ Applied rainbow to " .. initialCount .. " existing animals")

			-- 2. Обработка новых животных
			local connections = {}

			-- Слушаем добавление новых моделей в Workspace
			local workspaceConnection = Workspace.DescendantAdded:Connect(function(descendant)
				if descendant:IsA("Model") and descendant:FindFirstChild("Humanoid") then
					task.wait(0.5) -- Даем время на инициализацию

					-- Проверяем наличие Mutation
					local mutationValue = descendant:FindFirstChild("Mutation")
					if mutationValue and mutationValue:IsA("StringValue") then
						if applyRainbowMutation({
							Model = descendant,
							MutationValue = mutationValue
							}) then
							print("🎯 New animal got rainbow: " .. descendant.Name)
						end
					end
				end
			end)

			table.insert(connections, workspaceConnection)

			-- 3. Периодическая проверка
			local heartbeatConnection
			heartbeatConnection = RunService.Heartbeat:Connect(function()
				if not Workspace:GetAttribute("RainbowTimeActive") then
					return
				end

				-- Быстрая проверка новых животных
				local currentAnimals = findAnimalsInWorkspace()
				for _, animalData in ipairs(currentAnimals) do
					if animalData.Model and not affectedAnimals[animalData.Model] then
						applyRainbowMutation(animalData)
					end
				end
			end)

			table.insert(connections, heartbeatConnection)

			-- 4. Запускаем таймер окончания
			local endTime = os.time() + duration

			-- Создаем атрибут для отслеживания времени
			Workspace:SetAttribute("RainbowTimeEnd", endTime)

			-- Корутина таймера
			task.spawn(function()
				local remaining = duration

				while remaining > 0 and Workspace:GetAttribute("RainbowTimeActive") do
					Workspace:SetAttribute("RainbowTimeRemaining", remaining)

					-- Обновляем каждую секунду
					task.wait(1)
					remaining = remaining - 1

					-- Логируем каждые 10 секунд
					if remaining % 10 == 0 then
						print("⏰ RainbowTime: " .. remaining .. " seconds remaining")
					end
				end

				-- Завершение RainbowTime
				Workspace:SetAttribute("RainbowTimeActive", false)
				Workspace:SetAttribute("RainbowTimeEnd", nil)
				Workspace:SetAttribute("RainbowTimeRemaining", nil)

				-- Отключаем все соединения
				for _, connection in ipairs(connections) do
					if connection then
						connection:Disconnect()
					end
				end

				-- Восстанавливаем всех животных
				local revertedCount = 0
				for animal, _ in pairs(affectedAnimals) do
					if animal and animal.Parent then
						revertRainbowMutation(animal)
						revertedCount = revertedCount + 1
					end
				end

				-- Очищаем таблицу
				affectedAnimals = {}

				print("🌈 RainbowTime ended. Reverted " .. revertedCount .. " animals")

				-- Уведомление игроков
				for _, player in ipairs(Players:GetPlayers()) do
					pcall(function()
						-- Можно использовать вашу систему уведомлений
						local PlayerGui = player:FindFirstChild("PlayerGui")
						if PlayerGui then
							-- Создаем простое уведомление
							local screenGui = Instance.new("ScreenGui")
							local textLabel = Instance.new("TextLabel")
							textLabel.Size = UDim2.new(0, 300, 0, 50)
							textLabel.Position = UDim2.new(0.5, -150, 0.1, 0)
							textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
							textLabel.BackgroundTransparency = 0.5
							textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
							textLabel.Text = "🌈 RainbowTime has ended!"
							textLabel.Font = Enum.Font.GothamBold
							textLabel.TextSize = 18
							textLabel.Parent = screenGui
							screenGui.Parent = PlayerGui

							task.wait(3)
							screenGui:Destroy()
						end
					end)
				end
			end)

			-- Возвращаем информацию о запуске
			local response = {
				"🌈 RAINBOW TIME ACTIVATED! 🌈",
				"Duration: " .. duration .. " seconds",
				"Animals affected: " .. initialCount,
				"",
				"🎨 All animals now have Rainbow mutation!",
				"✨ New animals will automatically get rainbow",
				"⏰ Will auto-revert after " .. duration .. " seconds"
			}

			return table.concat(response, "\n")
		end
	})

	-- Алиасы
	Conch.register("rainbow", {
		alias = "rainbowtime"
	})

	Conch.register("rt", {
		alias = "rainbowtime"
	})
end

return module