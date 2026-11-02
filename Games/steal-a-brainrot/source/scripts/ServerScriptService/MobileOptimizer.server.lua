-- MobileOptimizer - Réduit le lag sur mobile
local RS = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")

-- Désactiver les particles des events inactifs
local function updateEventParticles()
    local eventsFolder = workspace:FindFirstChild("Events")
    if not eventsFolder then return end
    
    for _, eventModel in ipairs(eventsFolder:GetChildren()) do
        local eventAttr = eventModel.Name:gsub(" ", "").."Event"
        local isActive = RS:GetAttribute(eventAttr)
        for _, desc in ipairs(eventModel:GetDescendants()) do
            if desc:IsA("ParticleEmitter") then
                desc.Enabled = isActive == true
            end
        end
    end
end

-- Réduire le rate des particles lourdes (CraftingMachine, FuseMachine)
local function optimizeHeavyParticles()
    local heavyObjects = {
        workspace:FindFirstChild("CraftingMachine"),
        workspace:FindFirstChild("FuseMachine"),
        workspace:FindFirstChild("CupidsMachine"),
        workspace:FindFirstChild("Santa Merchant"),
    }
    for _, obj in ipairs(heavyObjects) do
        if obj then
            for _, desc in ipairs(obj:GetDescendants()) do
                if desc:IsA("ParticleEmitter") then
                    -- Réduire le rate de 50% pour mobile
                    local rate = desc.Rate
                    if rate > 10 then
                        desc.Rate = math.floor(rate * 0.5)
                    end
                end
            end
        end
    end
    print("[MobileOptimizer] Particles optimisées")
end

-- Anchorer les parts flottantes inutiles
local function anchorFloatingParts()
    local anchored = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Anchored 
           and not obj:FindFirstAncestorOfClass("Model") then
            obj.Anchored = true
            anchored += 1
        end
    end
    if anchored > 0 then
        print("[MobileOptimizer] Parts ancrées:", anchored)
    end
end

-- Désactiver les SurfaceGui inutiles (très lourds sur mobile)
local function optimizeSurfaceGuis()
    local disabled = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("SurfaceGui") and obj.Enabled then
            -- Garder seulement les SurfaceGui importants (leaderboards, shops)
            local important = obj.Name:lower():find("shop") or 
                             obj.Name:lower():find("board") or
                             obj.Name:lower():find("spawn") or
                             obj.Name:lower():find("price")
            if not important then
                obj.Enabled = false
                disabled += 1
            end
        end
    end
    if disabled > 0 then
        print("[MobileOptimizer] SurfaceGuis désactivés:", disabled)
    end
end

-- Mettre à jour quand les events changent
RS.AttributeChanged:Connect(function(attr)
    if attr:find("Event") then
        task.delay(0.5, updateEventParticles)
    end
end)

-- Appliquer au démarrage
task.wait(3)
optimizeHeavyParticles()
updateEventParticles()

print("[MobileOptimizer] ✅ Optimisations actives")
