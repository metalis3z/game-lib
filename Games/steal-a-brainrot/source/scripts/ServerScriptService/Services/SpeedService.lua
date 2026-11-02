local SpeedService = {}

local Players = game:GetService("Players")
local StarterPlayer = game:GetService("StarterPlayer")

local characterAddedConnections = {}
local toolDetectionConnections = {}

local function getModifiedValue(player: Player, baseValue: number, attributeName: string)
	local modifiedValue = baseValue
	local character = workspace:FindFirstChild(player.Name)

	if character then
		local tool = character:FindFirstChildOfClass("Tool")
		if tool then
			local modifier = tool:GetAttribute(attributeName)
			if modifier then
				modifiedValue *= modifier
			end
		end

		if player:GetAttribute("Stealing") then
			modifiedValue *= 0.6
		end
	else
		return 0
	end

	return math.clamp(modifiedValue, 0, 1e9)
end

local function updateMovementProperties(player: Player)
	local character = workspace:FindFirstChild(player.Name)
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	humanoid.WalkSpeed = getModifiedValue(player, StarterPlayer.CharacterWalkSpeed, "SpeedModifier")
	humanoid.JumpHeight = getModifiedValue(player, StarterPlayer.CharacterJumpHeight, "JumpModifier")
end

local function setupToolDetection(player: Player, character: Model)
	if toolDetectionConnections[player.UserId] then
		toolDetectionConnections[player.UserId]:Disconnect()
	end

	toolDetectionConnections[player.UserId] = character.ChildAdded:Connect(function(child)
		if child:IsA("Tool") then
			updateMovementProperties(player)

			child.AncestryChanged:Connect(function()
				if child.Parent ~= character then
					updateMovementProperties(player)
				end
			end)
		end
	end)

	character.ChildRemoved:Connect(function(child)
		if child:IsA("Tool") then
			updateMovementProperties(player)
		end
	end)
end

local function playerAdded(player: Player)
	player:GetAttributeChangedSignal("Stealing"):Connect(function()
		updateMovementProperties(player)
	end)

	characterAddedConnections[player.UserId] = player.CharacterAdded:Connect(function(character)
		-- Reset des attributs bloquants au respawn
		player:SetAttribute("Stealing", nil)
		player:SetAttribute("RagdollImmune", nil)
		
		task.defer(function()
			-- Forcer WalkSpeed à la valeur normale avant tout
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.WalkSpeed = game:GetService("StarterPlayer").CharacterWalkSpeed
				humanoid.JumpHeight = game:GetService("StarterPlayer").CharacterJumpHeight
			end
			updateMovementProperties(player)
			setupToolDetection(player, character)
		end)
	end)
end

function SpeedService:Update(player: Player)
	updateMovementProperties(player)
end

function SpeedService:Start()
	for _, player in pairs(Players:GetPlayers()) do
		playerAdded(player)
	end

	Players.PlayerAdded:Connect(playerAdded)

	Players.PlayerRemoving:Connect(function(player: Player)
		local conn = characterAddedConnections[player.UserId]
		if conn then
			conn:Disconnect()
			characterAddedConnections[player.UserId] = nil
		end

		local toolConn = toolDetectionConnections[player.UserId]
		if toolConn then
			toolConn:Disconnect()
			toolDetectionConnections[player.UserId] = nil
		end
	end)
end

return SpeedService