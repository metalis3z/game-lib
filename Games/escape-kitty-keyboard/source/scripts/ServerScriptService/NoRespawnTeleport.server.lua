-- Remplace le respawn par defaut de Roblox par une teleportation au SpawnLocation
-- Les joueurs ne restent pas morts, ils reapparaissent instantanement au point de spawn

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- Desactiver le respawn automatique de Roblox
Players.CharacterAutoLoads = false

local function getSpawnPosition()
	local spawn = Workspace:FindFirstChild("SpawnLocation")
	if spawn then
		return spawn.Position + Vector3.new(0, 5, 0)
	end
	return Vector3.new(0, 15, 0)
end

local function onCharacterAdded(player, character)
	local humanoid = character:WaitForChild("Humanoid", 10)
	if not humanoid then return end

	humanoid.Died:Connect(function()
		-- Au lieu de laisser Roblox respawner, on recharge immediatement le personnage
		-- LoadCharacter() le fait apparaitre au SpawnLocation
		task.wait(0.5)
		if player and player.Parent then
			player:LoadCharacter()
		end
	end)
end

local function onPlayerAdded(player)
	-- Chargement initial du personnage
	player:LoadCharacter()

	player.CharacterAdded:Connect(function(character)
		onCharacterAdded(player, character)
	end)

	-- Si le personnage existe deja au moment ou le script demarre
	if player.Character then
		onCharacterAdded(player, player.Character)
	end
end

Players.PlayerAdded:Connect(onPlayerAdded)

-- Gerer les joueurs deja presents
for _, player in ipairs(Players:GetPlayers()) do
	onPlayerAdded(player)
end

print("[NoRespawnTeleport] Active - les joueurs sont teleportes au spawn au lieu de respawner")