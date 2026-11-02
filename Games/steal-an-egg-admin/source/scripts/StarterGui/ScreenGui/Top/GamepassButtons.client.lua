-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MonetizationConfig = require(ReplicatedStorage.Data.MonetizationConfig)
local LocalPlayer = Players.LocalPlayer
local Frame = script.Parent:WaitForChild("Frame")
local DoubleMoney = Frame:WaitForChild("DoubleMoney")
local MaxRebirths = Frame:WaitForChild("MaxRebirths")
local X2Money = MonetizationConfig.GamepassIds.X2Money
local MaxRebirths_2 = MonetizationConfig.GamepassIds.MaxRebirths
DoubleMoney.Activated:Connect(function() -- line 16 | captures: MarketplaceService, LocalPlayer, X2Money
    MarketplaceService:PromptGamePassPurchase(LocalPlayer, X2Money)
end)
MaxRebirths.Activated:Connect(function() -- line 20 | captures: MarketplaceService, LocalPlayer, MaxRebirths_2
    MarketplaceService:PromptGamePassPurchase(LocalPlayer, MaxRebirths_2)
end)
