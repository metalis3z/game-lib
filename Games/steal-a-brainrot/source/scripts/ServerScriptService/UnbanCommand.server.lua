--[[
    COMMANDE UNBAN ADMIN
    Utilisation: :unban NomDuJoueur
]]

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

-- Liste des admins (mets ton nom ici)
local ADMINS = {
    [""] = true,
    -- Ajoute d'autres admins:
    -- ["AutreAdmin"] = true,
}

local BanStore = DataStoreService:GetDataStore("AntiFastStealBans")
local ExploitBanStore = DataStoreService:GetDataStore("AntiExploitBans")

-- Fonction pour débannir
local function UnbanPlayer(playerName)
    local success, err = pcall(function()
        -- Chercher dans les deux DataStores
        for _, store in ipairs({BanStore, ExploitBanStore}) do
            local pages = store:GetSortedAsync(false, 100)
            if pages then
                local currentPage = pages:GetCurrentPage()
                for _, data in ipairs(currentPage) do
                    local key = data.key
                    local value = data.value
                    
                    if value and value.playerName and 
                       value.playerName:lower() == playerName:lower() then
                        store:RemoveAsync(key)
                        print("✅ Débanni: "..playerName.." (clé: "..key..")")
                    end
                end
            end
        end
    end)
    
    if not success then
        warn("Erreur unban:", err)
    end
end

-- Fonction pour lister les bans
local function ListBans()
    print("=== LISTE DES BANS ===")
    
    for storeName, store in pairs({["AntiFastSteal"] = BanStore, ["AntiExploit"] = ExploitBanStore}) do
        print("\n["..storeName.."]:")
        local success, pages = pcall(function()
            return store:GetSortedAsync(false, 100)
        end)
        
        if success and pages then
            local currentPage = pages:GetCurrentPage()
            for _, data in ipairs(currentPage) do
                local value = data.value
                if value then
                    local remaining = value.expiry and math.max(0, value.expiry - os.time())
                    local remainingStr = remaining and remaining > 0 and 
                        string.format("%dh %dm", math.floor(remaining/3600), math.floor((remaining%3600)/60)) or "Expiré"
                    print("  - "..(value.playerName or "?").." | Raison: "..(value.reason or "?").." | Reste: "..remainingStr)
                end
            end
        end
    end
end

-- Fonction pour tout effacer
local function ClearAllBans()
    print("🗑️ Suppression de tous les bans...")
    
    for storeName, store in pairs({["AntiFastSteal"] = BanStore, ["AntiExploit"] = ExploitBanStore}) do
        local success, pages = pcall(function()
            return store:GetSortedAsync(false, 100)
        end)
        
        if success and pages then
            local currentPage = pages:GetCurrentPage()
            for _, data in ipairs(currentPage) do
                store:RemoveAsync(data.key)
            end
        end
    end
    
    print("✅ Tous les bans ont été supprimés!")
end

-- Commande chat
Players.PlayerAdded:Connect(function(player)
    if ADMINS[player.Name] then
        player.Chatted:Connect(function(message)
            local cmd = message:lower()
            
            -- :unban Nom
            if cmd:sub(1, 7) == ":unban " then
                local targetName = cmd:sub(8)
                UnbanPlayer(targetName)
                print("[ADMIN] "..player.Name.." a débanni "..targetName)
            end
            
            -- :listbans
            if cmd == ":listbans" then
                ListBans()
            end
            
            -- :clearbans
            if cmd == ":clearbans" then
                ClearAllBans()
            end
        end)
    end
end)

print("====================================")
print("   COMMANDES ADMIN DISPONIBLES")
print("   :unban NomDuJoueur")
print("   :listbans")
print("   :clearbans")
print("====================================")