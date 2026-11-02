local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- 1. CONFIGURATION (ADMINS ET TAGS)
local admins = {
	["1"] = { 
		title = "CO OWNER", 
		displayName = "1",
		colors = {
			Color3.fromRGB(0, 123, 255),
			Color3.fromRGB(253, 253, 253),
			Color3.fromRGB(255, 0, 0),
		}
	},
	["1"] = { 
		title = " OWNER", 
		displayName = "1",
		colors = {
			Color3.fromRGB(0, 123, 255),
			Color3.fromRGB(253, 253, 253),
			Color3.fromRGB(255, 0, 0),
		}
	},
	["1"] = { 
		title = "ADMIN", 
		displayName = "1",
		colors = {
			Color3.fromRGB(0, 85, 255),
			Color3.fromRGB(255, 255, 255),
			Color3.fromRGB(237, 41, 57),
		}
	},

	["1"] = { 
		title = "🎬 CONTENT CREATORS 🎬", 
		displayName = "1",
		colors = {
			Color3.fromRGB(255, 30, 0),
			Color3.fromRGB(255, 165, 0),
			Color3.fromRGB(255, 220, 0),
		}
	},
	
	["1"] = { 
		title = "ADMIN", 
		displayName = "1",
		colors = {
			Color3.fromRGB(255, 30, 0),
			Color3.fromRGB(255, 165, 0),
			Color3.fromRGB(255, 220, 0),
		}
	},
	
	["1"] = { 
		title = "🎬 CONTENT CREATORS 🎬", 
		displayName = "1",
		colors = {
			Color3.fromRGB(255, 30, 0),
			Color3.fromRGB(255, 165, 0),
			Color3.fromRGB(255, 220, 0),
		}
	},

	
	["1"] = { 
		title = "🎬 CONTENT CREATORS 🎬", 
		displayName = "1",
		colors = {
			Color3.fromRGB(255, 30, 0),
			Color3.fromRGB(255, 165, 0),
			Color3.fromRGB(255, 220, 0),
		}
	},

}

local savedSkins = {}

-- 2. FONCTION POUR CRÉER LE TAG
local function createTag(player, config)
	local character = player.Character
	if not character or not character:FindFirstChild("Head") then return end

	local oldTag = character.Head:FindFirstChild("AdminTag")
	if oldTag then oldTag:Destroy() end

	local gui = Instance.new("BillboardGui")
	gui.Name = "AdminTag"
	gui.Parent = character.Head
	gui.Size = UDim2.new(4, 0, 2.0, 0)
	gui.StudsOffset = Vector3.new(0, 3.5, 0)
	gui.AlwaysOnTop = true

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundTransparency = 1
	frame.Parent = gui

	local function setupLabel(text, pos, size)
		local label = Instance.new("TextLabel")
		label.Size = size
		label.Position = pos
		label.Text = text
		label.Font = Enum.Font.LuckiestGuy
		label.TextScaled = true
		label.BackgroundTransparency = 1
		label.TextColor3 = Color3.new(1, 1, 1)
		label.Parent = frame

		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 2.5
		stroke.Color = Color3.new(0, 0, 0)
		stroke.Parent = label

		local gradient = Instance.new("UIGradient")

		if config.colors then
			gradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0,   config.colors[1]),
				ColorSequenceKeypoint.new(0.5, config.colors[2]),
				ColorSequenceKeypoint.new(1,   config.colors[3]),
			})
		else
			-- Dégradé arc-en-ciel par défaut
			gradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0,   Color3.fromHSV(0,   0.7, 1)),
				ColorSequenceKeypoint.new(0.5, Color3.fromHSV(0.5, 0.7, 1)),
				ColorSequenceKeypoint.new(1,   Color3.fromHSV(1,   0.7, 1)),
			})
		end

		gradient.Parent = label
		return gradient
	end

	local titleGrad = setupLabel(config.title,       UDim2.new(0, 0, 0,    0), UDim2.new(1, 0, 0.52, 0))
	local nameGrad  = setupLabel(config.displayName, UDim2.new(0, 0, 0.50, 0), UDim2.new(1, 0, 0.50, 0))

	-- ANIMATION (Rotation dégradé + Flottement vertical)
	task.spawn(function()
		local rot = 0
		while gui and gui.Parent do
			rot = rot + 2
			titleGrad.Rotation = rot
			nameGrad.Rotation = -rot
			local yOffset = 3.5 + math.sin(tick() * 2) * 0.2
			gui.StudsOffset = Vector3.new(0, yOffset, 0)
			task.wait(0.03)
		end
	end)
end

-- 3. GESTION DU SPAWN
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local config = admins[player.Name]
		if config then
			if savedSkins[player.UserId] then
				task.wait(0.1)
				local humanoid = character:WaitForChild("Humanoid")
				humanoid:ApplyDescription(savedSkins[player.UserId])
			end
			task.wait(0.5)
			createTag(player, config)
		end
	end)
end)

-- 4. CHANGEMENT DE SKIN VIA LE MENU
local event = ReplicatedStorage:WaitForChild("ChangeSkinEvent")
event.OnServerEvent:Connect(function(player, targetName)
	local config = admins[player.Name]
	if config then
		local success, targetId = pcall(function()
			return Players:GetUserIdFromNameAsync(targetName)
		end)
		if success and targetId then
			local appearance = Players:GetHumanoidDescriptionFromUserId(targetId)
			savedSkins[player.UserId] = appearance
			local character = player.Character
			if character and character:FindFirstChild("Humanoid") then
				character.Humanoid:ApplyDescription(appearance)
				task.wait(0.5)
				createTag(player, config)
			end
		end
	end
end)