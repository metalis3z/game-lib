local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")

-- Créer un groupe de collision pour les joueurs
local playerCollisionGroupName = "Players"

local success, err = pcall(function()
    PhysicsService:RegisterCollisionGroup(playerCollisionGroupName)
end)

-- Les joueurs ne collisionnent pas entre eux
PhysicsService:CollisionGroupSetCollidable(playerCollisionGroupName, playerCollisionGroupName, false)

local function setCollisionGroup(object)
    if object:IsA("BasePart") then
        object.CollisionGroup = playerCollisionGroupName
    end
end

local function onCharacterAdded(character)
    for _, part in ipairs(character:GetDescendants()) do
        setCollisionGroup(part)
    end
    character.DescendantAdded:Connect(setCollisionGroup)
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(onCharacterAdded)
end)

-- Gérer les joueurs déjà présents
for _, player in ipairs(Players:GetPlayers()) do
    if player.Character then
        onCharacterAdded(player.Character)
    end
    player.CharacterAdded:Connect(onCharacterAdded)
end