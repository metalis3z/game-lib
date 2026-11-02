local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- CONFIGURATION

local admins = {
	["badr_studio"] = {
		title = "Owner",
		displayName = "Kaizou",
		colors = {
			Color3.fromRGB(71, 255, 249),
			Color3.fromRGB(204, 115, 255),
			Color3.fromRGB(255, 219, 148),
		}
	},
	["do_zynna"] = {
		title = "Main-Dev",
		displayName = "Do_zynna",
		colors = {
			Color3.fromRGB(71, 255, 249),
			Color3.fromRGB(204, 115, 255),
			Color3.fromRGB(255, 219, 148),
		}
	},
}

local contentCreators = {
	[2902176772] = true,
	[11304033343] = true,
	[7779999906] = true,
	[1187656599] = true,
	[8056438081] = true,
	[9314751525] = true,
	[8405209298] = true,
	[9723311208] = true,
	[11121269312] = true,
	[8987994851] = true,
	[7050570501] = true,
	[7869103927] = true,
	[9240009271] = true,
	[6043092878] = true,
	[10249277741] = true,
	[10730587645] = true,
	[10723031546] = true,
	[4592790712] = true,
	[3385851855] = true,
	[9519409976] = true,
	[8876016380] = true,
	[10754578257] = true,
	[11293410326] = true,
}

local savedSkins = {}

local function getPlayerConfig(player)
	local config = admins[player.Name]

	if config then
		return config
	end

	if contentCreators[player.UserId] then
		return {
			title = "Content Creator",
			displayName = player.DisplayName,
			colors = {
				Color3.fromRGB(17, 17, 255),
				Color3.fromRGB(255, 255, 255),
				Color3.fromRGB(32, 233, 255),
			},
		}
	end

	return nil
end

local function createTag(player, config)
	local character = player.Character
	if not character or not character:FindFirstChild("Head") then return end

	local oldTag = character.Head:FindFirstChild("AdminTag")
	if oldTag then
		oldTag:Destroy()
	end

	local gui = Instance.new("BillboardGui")
	gui.Name = "AdminTag"
	gui.Parent = character.Head
	gui.Size = UDim2.new(4,0,2,0)
	gui.StudsOffset = Vector3.new(0,3.5,0)
	gui.AlwaysOnTop = true

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1,0,1,0)
	frame.BackgroundTransparency = 1
	frame.Parent = gui

	local function setupLabel(text,pos,size)
		local label = Instance.new("TextLabel")
		label.Size = size
		label.Position = pos
		label.Text = text
		label.Font = Enum.Font.LuckiestGuy
		label.TextScaled = true
		label.BackgroundTransparency = 1
		label.TextColor3 = Color3.new(1,1,1)
		label.Parent = frame

		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 2.5
		stroke.Color = Color3.new(0,0,0)
		stroke.Parent = label

		local gradient = Instance.new("UIGradient")
		gradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0,config.colors[1]),
			ColorSequenceKeypoint.new(0.5,config.colors[2]),
			ColorSequenceKeypoint.new(1,config.colors[3]),
		})
		gradient.Parent = label

		return gradient
	end

	local titleGrad = setupLabel(
		config.title,
		UDim2.new(0,0,0,0),
		UDim2.new(1,0,0.52,0)
	)

	local nameGrad = setupLabel(
		config.displayName,
		UDim2.new(0,0,0.50,0),
		UDim2.new(1,0,0.50,0)
	)

	task.spawn(function()
		local rot = 0

		while gui and gui.Parent do
			rot += 2

			titleGrad.Rotation = rot
			nameGrad.Rotation = -rot

			gui.StudsOffset = Vector3.new(
				0,
				3.5 + math.sin(tick()*2)*0.2,
				0
			)

			task.wait(0.03)
		end
	end)
end
-- GESTION DU SPAWN

Players.PlayerAdded:Connect(function(player)

	player.CharacterAdded:Connect(function(character)

		local config = getPlayerConfig(player)

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

-- CHANGEMENT DE SKIN VIA LE MENU

local event = ReplicatedStorage:WaitForChild("ChangeSkinEvent")

event.OnServerEvent:Connect(function(player, targetName)

	local config = getPlayerConfig(player)

	if not config then
		return
	end

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

end)