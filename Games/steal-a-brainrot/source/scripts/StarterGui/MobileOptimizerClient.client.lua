-- MobileOptimizerClient - Optimisations côté client mobile
local UIS = game:GetService("UserInputService")
local RS  = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- Détecter si mobile
local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled

if not isMobile then
    print("[MobileOptimizer] PC détecté - optimisations légères")
end

-- Réduire la qualité de rendu sur mobile
if isMobile then
    -- Réduire le render distance
    local Camera = workspace.CurrentCamera
    Camera.FieldOfView = 70 -- réduit légèrement
    
    -- Qualité graphique réduite
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level04
    
    -- Désactiver les shadows sur mobile
    game:GetService("Lighting").GlobalShadows = false
    
    print("[MobileOptimizer] 📱 Mode mobile activé - qualité réduite")
end

-- Désactiver les BillboardGui hors de portée
local function optimizeBillboards()
    local camera = workspace.CurrentCamera
    while true do
        task.wait(0.5)
        if not camera then camera = workspace.CurrentCamera end
        local camPos = camera.CFrame.Position
        
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BillboardGui") then
                local part = obj.Parent
                if part and part:IsA("BasePart") then
                    local dist = (part.Position - camPos).Magnitude
                    -- Désactiver si trop loin (>200 studs)
                    obj.Enabled = dist < 200
                end
            end
        end
    end
end

-- Nettoyer les effets excessifs sur mobile
local function cleanupMobileEffects()
    if not isMobile then return end
    
    local removed = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        -- Désactiver les particles très lourdes sur mobile (rate > 50)
        if obj:IsA("ParticleEmitter") and obj.Rate > 50 then
            obj.Rate = math.floor(obj.Rate * 0.4)
            removed += 1
        end
        -- Réduire les Beams sur mobile
        if obj:IsA("Beam") then
            obj.FaceCamera = false
        end
    end
    print("[MobileOptimizer] Particles réduites:", removed)
end

task.wait(3)
cleanupMobileEffects()

if isMobile then
    task.spawn(optimizeBillboards)
end

print("[MobileOptimizerClient] ✅ Actif", isMobile and "(mobile)" or "(PC)")
