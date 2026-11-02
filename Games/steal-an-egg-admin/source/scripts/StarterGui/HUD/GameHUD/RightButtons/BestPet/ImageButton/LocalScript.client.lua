-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PromptPurchase = require(ReplicatedStorage.Client.Functions.PromptPurchase)
local MonetizationConfig = require(ReplicatedStorage.Data.MonetizationConfig)
local BestPet = script:FindFirstAncestor("BestPet")
local v1 = BestPet and BestPet:IsA("GuiButton")
assert(v1, "BestPet must be a GUI button")
local v2 = false

local function promptPurchase() -- line 9 | captures: v2, PromptPurchase, MonetizationConfig
    if v2 then
        return
    end
    v2 = true
    local v3, v4 = pcall(PromptPurchase.Prompt, MonetizationConfig.ProductIds["Strawberry Elephant"], true)
    v2 = false
    if not v3 then
        warn("[BestPet] Could not open purchase prompt: " .. tostring(v4))
    end
end

local function bindButton(v5) -- line 21 | captures: promptPurchase
    if not v5:IsA("GuiButton") then
        return
    end
    v5.Active = true
    v5.Interactable = true
    v5.Activated:Connect(promptPurchase)
end

if BestPet:IsA("GuiButton") then
    BestPet.Active = true
    BestPet.Interactable = true
    BestPet.Activated:Connect(promptPurchase)
end
for v6, v7 in ipairs(BestPet:GetDescendants()) do
    if v7:IsA("GuiButton") then
        v7.Active = true
        v7.Interactable = true
        v7.Activated:Connect(promptPurchase)
    end
end
BestPet.DescendantAdded:Connect(bindButton)
