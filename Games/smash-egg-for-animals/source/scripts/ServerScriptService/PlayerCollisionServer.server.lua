-- Script pour permettre aux joueurs de se traverser (no collision entre joueurs)
local Players = game:GetService("Players")
local PhysicsService = game:GetService("PhysicsService")

-- Creer deux groupes de collision: un pour les joueurs, un pour le reste
local playerGroup = "Players"
local defaultGroup = "Default"

-- Verifier si les groupes existent deja, sinon les creer
local function setupCollisionGroups()
    local groups = PhysicsService:GetCollisionGroups()
    local playerExists = false
    for _, group in ipairs(groups) do
        if group.name == playerGroup then
            playerExists = true
        end
    end

    if not playerExists then
        PhysicsService:CreateCollisionGroup(playerGroup)
    end

    -- Desactiver la collision entre le groupe Players et lui-meme
    PhysicsService:CollisionGroupSetCollidable(playerGroup, playerGroup, false)
end

-- Appliquer le groupe de collision a toutes les parties d'un personnage
local function setCharacterCollisionGroup(character)
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CollisionGroup = playerGroup
        end
    end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        -- Attendre que le personnage soit charge
        task.wait(0.1)
        setCharacterCollisionGroup(character)
    end)
end

-- Configurer les groupes de collision
setupCollisionGroups()

-- Gerer les joueurs deja presents
for _, player in Players:GetPlayers() do
    onPlayerAdded(player)
end

-- Gerer les nouveaux joueurs
Players.PlayerAdded:Connect(onPlayerAdded)