-- Préchargement prioritaire des assets critiques
local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")

-- Précharger uniquement les assets critiques (pas les 408 animaux d'un coup)
-- On précharge les textures UI et les premiers animaux visibles

local function preloadFolder(folder, maxItems)
    if not folder then return end
    local items = {}
    local count = 0
    for _, v in ipairs(folder:GetDescendants()) do
        if v:IsA("MeshPart") or v:IsA("SpecialMesh") or v:IsA("Texture") or v:IsA("Decal") then
            table.insert(items, v)
            count += 1
            if count >= (maxItems or 50) then break end
        end
    end
    if #items > 0 then
        ContentProvider:PreloadAsync(items)
    end
end

-- Précharger les UI en priorité
task.spawn(function()
    preloadFolder(ReplicatedStorage:FindFirstChild("ReplicatedGui"), 100)
end)

-- Précharger les 20 premiers animaux (les plus communs)
task.spawn(function()
    task.wait(1)
    local animals = ReplicatedStorage:FindFirstChild("Models") 
        and ReplicatedStorage.Models:FindFirstChild("Animals")
    if animals then
        local items = {}
        local count = 0
        for _, animal in ipairs(animals:GetChildren()) do
            for _, v in ipairs(animal:GetDescendants()) do
                if v:IsA("MeshPart") or v:IsA("SpecialMesh") then
                    table.insert(items, v)
                    count += 1
                end
            end
            if count >= 200 then break end
        end
        ContentProvider:PreloadAsync(items)
    end
end)
