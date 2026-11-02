-- Script universel pour power up la machine avec n'importe quel achat ingame du productId 3324422106
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WEATHER_MACHINE_PRODUCT_ID = 3324422106

-- Localisation de la Weather Machine et de son PowerLevel
local weatherMachine = workspace:FindFirstChild("WeatherMachine")
local powerLevelTag = nil
if weatherMachine then
    powerLevelTag = weatherMachine:FindFirstChild("PowerLevel")
end

-- Sécurité simple pour éviter les exploits (ne power up que si le joueur est bien dans le jeu)
local function tryPowerUpWeatherMachine(playerId)
    if not powerLevelTag then return end
    for _, player in pairs(Players:GetPlayers()) do
        if player.UserId == playerId then
            powerLevelTag.Value = powerLevelTag.Value + 1
            break
        end
    end
end

MarketplaceService.ProcessReceipt = function(receiptInfo)
    -- Si un autre script gère déjà ce product, ne pas interférer avec la décision d'achat (avoid double grant)
    if receiptInfo.ProductId == WEATHER_MACHINE_PRODUCT_ID then
        tryPowerUpWeatherMachine(receiptInfo.PlayerId)
        return Enum.ProductPurchaseDecision.PurchaseGranted
    end
    -- Pour tout autre achat, laisser l'achat se faire normalement (si un autre handler existe, il peut le traiter)
    return Enum.ProductPurchaseDecision.NotProcessedYet
end

-- Ajout pour le power up gratuit via le bouton
local freePowerUpEvent = ReplicatedStorage:WaitForChild("FreePowerUpEvent")

freePowerUpEvent.OnServerEvent:Connect(function(player)
    if powerLevelTag then
        powerLevelTag.Value = powerLevelTag.Value + 1
    end
end)

