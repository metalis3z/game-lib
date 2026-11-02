local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local TAG_NAME = "CmdrRevealRoleTag"
local MAX_DURATION = 300

local ROLE_COLORS = {
	Murderer = Color3.fromRGB(255, 35, 35),
	Sheriff = Color3.fromRGB(35, 120, 255),
	Hero = Color3.fromRGB(255, 210, 40),
	Innocent = Color3.fromRGB(70, 255, 70),
}

local state = _G.CmdrRevealRolesState
if not state then
	state = {
		Token = 0,
		Connections = {},
	}
	_G.CmdrRevealRolesState = state
end

local function getRoundActive()
	local roundState = ServerStorage:FindFirstChild("RoundState")
	local roundActive = roundState and roundState:FindFirstChild("RoundActive")
	return roundActive and roundActive.Value == true
end

local function getPlayerData()
	local gameScript = ServerScriptService:FindFirstChild("GameScript")
	local getFolder = gameScript and gameScript:FindFirstChild("Get")
	local getter = getFolder and getFolder:FindFirstChild("PlayerData")
	if not getter then
		return nil
	end

	local ok, playerData = pcall(function()
		return getter:Invoke()
	end)
	if ok and type(playerData) == "table" then
		return playerData
	end

	return nil
end

local function removeTags()
	for _, object in ipairs(workspace:GetDescendants()) do
		if object.Name == TAG_NAME then
			object:Destroy()
		end
	end
end

local function disconnectAll()
	for _, connection in ipairs(state.Connections) do
		connection:Disconnect()
	end
	table.clear(state.Connections)
end

local function cleanup()
	disconnectAll()
	removeTags()
end

local function getAdornee(character)
	return character:FindFirstChild("Head") or character:FindFirstChildWhichIsA("BasePart")
end

local function addTag(player, role)
	local character = player.Character
	if not character then
		return
	end

	local adornee = getAdornee(character)
	if not adornee then
		return
	end

	local existingTag = character:FindFirstChild(TAG_NAME, true)
	if existingTag then
		existingTag:Destroy()
	end

	local color = ROLE_COLORS[role] or Color3.fromRGB(255, 255, 255)
	local tag = Instance.new("BillboardGui")
	tag.Name = TAG_NAME
	tag.AlwaysOnTop = true
	tag.LightInfluence = 0
	tag.MaxDistance = 250
	tag.Size = UDim2.new(0, 130, 0, 34)
	tag.StudsOffsetWorldSpace = Vector3.new(0, 3.15, 0)
	tag.Adornee = adornee
	tag.Parent = adornee

	local label = Instance.new("TextLabel")
	label.Name = "Role"
	label.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	label.BackgroundTransparency = 0.18
	label.BorderSizePixel = 0
	label.Size = UDim2.fromScale(1, 1)
	label.Font = Enum.Font.GothamBlack
	label.Text = string.upper(role)
	label.TextColor3 = color
	label.TextScaled = true
	label.TextStrokeColor3 = Color3.new(0, 0, 0)
	label.TextStrokeTransparency = 0
	label.Parent = tag

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 5)
	corner.Parent = label

	local padding = Instance.new("UIPadding")
	padding.PaddingLeft = UDim.new(0, 8)
	padding.PaddingRight = UDim.new(0, 8)
	padding.PaddingTop = UDim.new(0, 3)
	padding.PaddingBottom = UDim.new(0, 3)
	padding.Parent = label
end

local function updatePlayer(player, playerData)
	local data = playerData and playerData[player.Name]
	local role = data and data.Role
	if type(role) ~= "string" or role == "" then
		return
	end

	addTag(player, role)
end

return function(_, seconds)
	local duration = tonumber(seconds)
	if not duration then
		return "Usage: revealroles <seconds>"
	end

	duration = math.floor(duration)
	if duration <= 0 then
		return "Revealroles needs a number greater than 0."
	end

	duration = math.min(duration, MAX_DURATION)
	if not getRoundActive() then
		return "Revealroles only works while a round is playing."
	end

	local playerData = getPlayerData()
	if not playerData or next(playerData) == nil then
		return "Round player data is not ready yet."
	end

	state.Token += 1
	local token = state.Token
	cleanup()

	for _, player in ipairs(Players:GetPlayers()) do
		updatePlayer(player, playerData)
		table.insert(state.Connections, player.CharacterAdded:Connect(function()
			task.wait(0.25)
			if state.Token == token then
				updatePlayer(player, getPlayerData())
			end
		end))
	end

	table.insert(state.Connections, Players.PlayerAdded:Connect(function(player)
		table.insert(state.Connections, player.CharacterAdded:Connect(function()
			task.wait(0.25)
			if state.Token == token then
				updatePlayer(player, getPlayerData())
			end
		end))
	end))

	task.delay(duration, function()
		if state.Token == token then
			cleanup()
		end
	end)

	return "Revealing roles for " .. duration .. " seconds."
end