-- Attribue une base (1 à 7) à chaque joueur dans l'ordre d'arrivée et le fait spawn dessus
local Players = game:GetService("Players")

local MAX_BASES = 7
local SPAWN_HEIGHT = 3.5

local bases = workspace:WaitForChild("all base")
local owners = {} -- [numéro de base] = player

local function getBase(number)
	return number and bases:FindFirstChild("base " .. number)
end

-- Panneau de la base : nom + tête du joueur, ou "No one" si elle est libre
local function updateSign(base, player)
	local sign = base:FindFirstChild("Sign")
	local gui = sign and sign:FindFirstChild("BaseDisplayGui", true)
	if not gui then return end
	local frame = gui:FindFirstChild("Frame")
	local empty = gui:FindFirstChild("EmptyBase")
	local portrait = gui:FindFirstChild("PlayerDisplay")
	if frame then
		frame.Visible = player ~= nil
		local nameLabel = frame:FindFirstChild("PlayerName", true)
		if nameLabel and player then nameLabel.Text = player.DisplayName .. "'s" end
	end
	if empty then empty.Visible = player == nil end
	if portrait then
		portrait.Visible = player ~= nil
		if player then
			portrait.Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", player.UserId)
		end
	end
end

local function setOwner(number, player)
	local base = getBase(number)
	owners[number] = player
	if not base then return end
	base:SetAttribute("OwnerUserId", player and player.UserId or 0)
	updateSign(base, player)
end

-- Position du Spawn de la base, tourné vers le jardin
local function getSpawnCFrame(base)
	local spawnPart = base:FindFirstChild("Spawn")
	if not spawnPart then return nil end
	local pos = spawnPart.Position + Vector3.new(0, SPAWN_HEIGHT, 0)
	local animals, plants = base:FindFirstChild("animaux"), base:FindFirstChild("plantes")
	local center = (animals and plants) and (animals.Position + plants.Position) / 2 or base:GetBoundingBox().Position
	return CFrame.lookAt(pos, Vector3.new(center.X, pos.Y, center.Z))
end

local function onCharacterAdded(player, character)
	local base = getBase(player:GetAttribute("BaseNumber"))
	local cf = base and getSpawnCFrame(base)
	if not cf then return end
	if not character:WaitForChild("HumanoidRootPart", 10) then return end
	task.wait(0.1) -- laisse le spawn par défaut se terminer avant de téléporter
	if character.Parent then character:PivotTo(cf) end
end

local function onPlayerAdded(player)
	if player:GetAttribute("BaseNumber") then return end
	local number
	for i = 1, MAX_BASES do
		if not owners[i] and getBase(i) then
			number = i
			break
		end
	end
	if not number then
		player:Kick("Server full: " .. MAX_BASES .. " players maximum.")
		return
	end

	player:SetAttribute("BaseNumber", number)
	setOwner(number, player)

	player.CharacterAdded:Connect(function(character)
		onCharacterAdded(player, character)
	end)
	if player.Character then
		task.spawn(onCharacterAdded, player, player.Character)
	end
end

local function onPlayerRemoving(player)
	local number = player:GetAttribute("BaseNumber")
	if number and owners[number] == player then
		setOwner(number, nil)
	end
end

for i = 1, MAX_BASES do setOwner(i, nil) end
Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)
for _, player in Players:GetPlayers() do
	task.spawn(onPlayerAdded, player)
end
