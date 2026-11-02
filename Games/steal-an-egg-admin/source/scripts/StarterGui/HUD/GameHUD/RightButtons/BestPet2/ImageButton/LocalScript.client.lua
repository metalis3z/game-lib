-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PromptPurchase = require(ReplicatedStorage.Client.Functions.PromptPurchase)
local MonetizationConfig = require(ReplicatedStorage.Data.MonetizationConfig)
local BestPet2 = script:FindFirstAncestor("BestPet2")
local v1 = BestPet2 and BestPet2:IsA("GuiButton")
assert(v1, "BestPet2 must be a GUI button")
local v2 = false

local function promptPurchase() -- line 9 | captures: v2, PromptPurchase, MonetizationConfig
    if v2 then
        return
    end
    v2 = true
    local v3, v4 = pcall(PromptPurchase.Prompt, MonetizationConfig.ProductIds["Mecha Dreadscale"], true)
    v2 = false
    if not v3 then
        warn("[BestPet2] Could not open purchase prompt: " .. tostring(v4))
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

if BestPet2:IsA("GuiButton") then
    BestPet2.Active = true
    BestPet2.Interactable = true
    BestPet2.Activated:Connect(promptPurchase)
end
for v6, v7 in ipairs(BestPet2:GetDescendants()) do
    if v7:IsA("GuiButton") then
        v7.Active = true
        v7.Interactable = true
        v7.Activated:Connect(promptPurchase)
    end
end
BestPet2.DescendantAdded:Connect(bindButton)
