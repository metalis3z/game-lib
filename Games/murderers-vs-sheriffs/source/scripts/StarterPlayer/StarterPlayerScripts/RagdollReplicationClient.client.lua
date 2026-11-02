local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local Gameplay = Remotes:WaitForChild("Gameplay")
local RagdollSync = Gameplay:WaitForChild("RagdollSync")

local ragdolledUserIds = {}
local characterConnections = {}
local originalVisuals = setmetatable({}, { __mode = "k" })

local function disconnectCharacterConnections(player)
	local connections = characterConnections[player]
	if not connections then
		return
	end

	for _, connection in ipairs(connections) do
		connection:Disconnect()
	end
	characterConnections[player] = nil
end

local function getOriginalVisual(instance)
	local original = originalVisuals[instance]
	if original then
		return original
	end

	original = {}
	if instance:IsA("BasePart") then
		original.CanCollide = instance.CanCollide
	elseif instance:IsA("Decal") or instance:IsA("Texture") then
		original.Transparency = instance.Transparency
	elseif instance:IsA("ParticleEmitter") or instance:IsA("Trail") or instance:IsA("Beam") then
		original.Enabled = instance.Enabled
	end
	originalVisuals[instance] = original
	return original
end

local function setCharacterHidden(character, hidden)
	if not character then
		return
	end

	for _, descendant in ipairs(character:GetDescendants()) do
		if descendant:IsA("BasePart") then
			local original = getOriginalVisual(descendant)
			descendant.LocalTransparencyModifier = hidden and 1 or 0
			if hidden then
				descendant.CanCollide = false
			elseif original.CanCollide ~= nil then
				descendant.CanCollide = original.CanCollide
			end
		elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
			local original = getOriginalVisual(descendant)
			descendant.Transparency = hidden and 1 or original.Transparency
		elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Beam") then
			local original = getOriginalVisual(descendant)
			descendant.Enabled = hidden and false or original.Enabled
		end
	end
end

local function forceHideOriginalCharacter(player)
	local character = player and player.Character
	if not character then
		return
	end

	setCharacterHidden(character, true)

	for _ = 1, 30 do
		if player.Character ~= character or not character.Parent then
			return
		end
		RunService.Heartbeat:Wait()
		setCharacterHidden(character, true)
	end
end

local function waitForCorpse(corpseName)
	local ragdollFolder = workspace:FindFirstChild("Ragdolls") or workspace:WaitForChild("Ragdolls", 5)
	if not ragdollFolder then
		return
	end

	local corpse = ragdollFolder:FindFirstChild(corpseName) or ragdollFolder:WaitForChild(corpseName, 5)
	if not corpse then
		return
	end

	for _, descendant in ipairs(corpse:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.LocalTransparencyModifier = 0
		end
	end
end

local function onCharacterAdded(player, character)
	disconnectCharacterConnections(player)
	characterConnections[player] = {}

	local function refresh()
		if character:GetAttribute("ServerRagdolled") or ragdolledUserIds[player.UserId] then
			task.spawn(forceHideOriginalCharacter, player)
		else
			setCharacterHidden(character, false)
		end
	end

	table.insert(characterConnections[player], character:GetAttributeChangedSignal("ServerRagdolled"):Connect(refresh))
	table.insert(characterConnections[player], character.DescendantAdded:Connect(function()
		task.defer(refresh)
	end))

	task.defer(refresh)
end

local function watchPlayer(player)
	if player.Character then
		onCharacterAdded(player, player.Character)
	end

	player.CharacterAdded:Connect(function(character)
		ragdolledUserIds[player.UserId] = nil
		onCharacterAdded(player, character)
	end)
end

for _, player in ipairs(Players:GetPlayers()) do
	watchPlayer(player)
end

Players.PlayerAdded:Connect(watchPlayer)
Players.PlayerRemoving:Connect(function(player)
	disconnectCharacterConnections(player)
	ragdolledUserIds[player.UserId] = nil
end)

RagdollSync.OnClientEvent:Connect(function(userId, corpseName)
	ragdolledUserIds[userId] = true

	local player = Players:GetPlayerByUserId(userId)
	if player then
		task.spawn(forceHideOriginalCharacter, player)
	end

	if type(corpseName) == "string" and corpseName ~= "" then
		task.spawn(waitForCorpse, corpseName)
	end
end)
