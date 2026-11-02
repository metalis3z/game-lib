-- AdminGodMode | ID: 7602834871
-- Immunité totale : items, vol, ragdoll, laser
-- Persistant jusqu'à désactivation manuelle

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local CollectionService = game:GetService("CollectionService")

local ADMIN_ID = 7602834871
local STORE_KEY = "AdminGodMode_v1"
local GodStore = DataStoreService:GetDataStore("AdminGodMode")

-- Charger l'état depuis DataStore (persistant)
local godModeActive = false
task.spawn(function()
    local ok, val = pcall(function() return GodStore:GetAsync(STORE_KEY) end)
    if ok and val == true then
        godModeActive = true
        print("[GodMode] ✅ God Mode chargé depuis DataStore - ACTIF")
    else
        print("[GodMode] God Mode chargé - inactif")
    end
end)

local function saveState()
    pcall(function() GodStore:SetAsync(STORE_KEY, godModeActive) end)
end

local function applyGodMode(player)
    if player.UserId ~= ADMIN_ID then return end
    -- Attributs lus par tous les services
    player:SetAttribute("GodMode", true)
    player:SetAttribute("StealProtection", true)
    player:SetAttribute("RagdollImmune", true)
    player:SetAttribute("IgnoredByAntiCheat", true)
    -- Rendre le personnage non-collidable avec les lasers
    local char = player.Character
    if char then
        -- Tag CollectionService pour que les scripts de laser ignorent le joueur
        CollectionService:AddTag(char, "GodModePlayer")
        -- Désactiver les hitbox pour les items
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp:SetAttribute("GodMode", true)
        end
    end
    print("[GodMode] ✅ " .. player.Name .. " - God Mode ACTIF")
end

local function removeGodMode(player)
    if player.UserId ~= ADMIN_ID then return end
    player:SetAttribute("GodMode", false)
    player:SetAttribute("StealProtection", false)
    player:SetAttribute("RagdollImmune", false)
    player:SetAttribute("IgnoredByAntiCheat", false)
    local char = player.Character
    if char then
        CollectionService:RemoveTag(char, "GodModePlayer")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then hrp:SetAttribute("GodMode", false) end
    end
    print("[GodMode] ❌ " .. player.Name .. " - God Mode DÉSACTIVÉ")
end

-- Appliquer au spawn (persistant)
Players.PlayerAdded:Connect(function(player)
    if player.UserId ~= ADMIN_ID then return end
    -- Attendre que le character soit chargé
    local function onCharacter(char)
        if godModeActive then
            task.wait(0.5) -- laisser le character s'initialiser
            applyGodMode(player)
        end
    end
    player.CharacterAdded:Connect(onCharacter)
    if player.Character then onCharacter(player.Character) end
end)

-- Vérifier si déjà connecté
for _, player in ipairs(Players:GetPlayers()) do
    if player.UserId == ADMIN_ID then
        local function onChar(char)
            if godModeActive then
                task.wait(0.5)
                applyGodMode(player)
            end
        end
        player.CharacterAdded:Connect(onChar)
        if player.Character then onChar(player.Character) end
    end
end

-- Commande pour activer/désactiver
local Net = require(ReplicatedStorage.Packages.Net)
local Conch = require(ReplicatedStorage.Packages.Conch)

-- Attendre que Conch soit prêt
task.wait(5)

local function getAdmin()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.UserId == ADMIN_ID then return p end
    end
    return nil
end

Conch.register("godmode", {
    permissions = {"super-user"},
    arguments = function()
        return { kind = "argument", type = "string", name = "Action", optional = true }
    end,
    callback = function(action)
        action = (action or "toggle"):lower()
        local admin = getAdmin()

        if action == "on" or (action == "toggle" and not godModeActive) then
            godModeActive = true
            saveState()
            if admin then applyGodMode(admin) end
            return "✅ God Mode ACTIVÉ - Immunité totale (items, vol, ragdoll, laser)"

        elseif action == "off" or (action == "toggle" and godModeActive) then
            godModeActive = false
            saveState()
            if admin then removeGodMode(admin) end
            return "❌ God Mode DÉSACTIVÉ"

        elseif action == "status" then
            return "God Mode: " .. (godModeActive and "✅ ACTIF" or "❌ INACTIF")
        end

        return "Usage: godmode on/off/toggle/status"
    end
})

print("[GodMode] ✅ Serveur prêt - commande 'godmode' enregistrée")
