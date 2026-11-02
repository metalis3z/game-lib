local ZombieManager = {}
ZombieManager.AliveZombies = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local UpdateEnemiesLeft = ReplicatedStorage.Remotes:FindFirstChild("UpdateEnemiesLeft")

-- Helper to get the current map's Zombies folder
local function getZombiesFolder()
    local mapFolder = Workspace:FindFirstChild("Map")
    if not mapFolder then return Workspace end
    
    -- Find the first model in the Map folder (current active map)
    local mapModel = nil
    for _, child in mapFolder:GetChildren() do
        if child:IsA("Model") then
            mapModel = child
            break
        end
    end
    
    if not mapModel then return Workspace end
    
    local zombiesFolder = mapModel:FindFirstChild("Zombies")
    if not zombiesFolder then
        zombiesFolder = Instance.new("Folder")
        zombiesFolder.Name = "Zombies"
        zombiesFolder.Parent = mapModel
    end
    return zombiesFolder
end

function ZombieManager:RegisterZombie(zombie)
    if not zombie then return end
    
    -- Validate zombie is in the correct folder
    local zombiesFolder = getZombiesFolder()
    if not zombie:IsDescendantOf(zombiesFolder) then
        warn("Zombie not in correct Zombies folder")
        return
    end
    
    ZombieManager.AliveZombies[zombie] = true
    ZombieManager:UpdateClients()
end

function ZombieManager:UnregisterZombie(zombie)
    if ZombieManager.AliveZombies[zombie] then
        ZombieManager.AliveZombies[zombie] = nil
        ZombieManager:UpdateClients()
    end
end

function ZombieManager:GetAliveCount()
    local count = 0
    local zombiesFolder = getZombiesFolder()
    
    for zombie, _ in pairs(ZombieManager.AliveZombies) do
        -- Check if zombie still exists and is in the correct folder
        if zombie and zombie.Parent == zombiesFolder then
            count = count + 1
        else
            -- Clean up invalid zombie references
            ZombieManager.AliveZombies[zombie] = nil
        end
    end
    
    return count
end

function ZombieManager:GetAliveZombies()
    local zombies = {}
    local zombiesFolder = getZombiesFolder()
    
    for zombie, _ in pairs(ZombieManager.AliveZombies) do
        -- Check if zombie still exists and is in the correct folder
        if zombie and zombie.Parent == zombiesFolder then
            table.insert(zombies, zombie)
        else
            -- Clean up invalid zombie references
            ZombieManager.AliveZombies[zombie] = nil
        end
    end
    
    return zombies
end

function ZombieManager:ClearZombies()
    local zombiesFolder = getZombiesFolder()
    
    for zombie, _ in pairs(ZombieManager.AliveZombies) do
        if zombie and zombie.Parent == zombiesFolder then
            zombie:Destroy()
        end
    end
    
    ZombieManager.AliveZombies = {}
    ZombieManager:UpdateClients()
end

function ZombieManager:UpdateClients()
    if UpdateEnemiesLeft then
        UpdateEnemiesLeft:FireAllClients(ZombieManager:GetAliveCount())
    end
end

return ZombieManager