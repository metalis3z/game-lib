-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local MarketplaceService = game:GetService("MarketplaceService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Parent = script.Parent
local Parent_2 = Parent.Parent
local InfiniteSpeed = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.InfiniteSpeed
local v1 = false

local function promptPurchase() -- line 9 | captures: v1, MarketplaceService, LocalPlayer, InfiniteSpeed
    if v1 then
        return
    end
    v1 = true
    MarketplaceService:PromptProductPurchase(LocalPlayer, InfiniteSpeed)
    task.delay(1, function() -- line 13 | captures: v1
        v1 = false
    end)
end

Parent.Activated:Connect(promptPurchase)

if not (Parent_2 and Parent_2:IsA("GuiObject")) then
    return
end
Parent_2.Active = true
Parent_2.InputBegan:Connect(function(v2) -- line 22 | captures: v1, MarketplaceService, LocalPlayer, InfiniteSpeed
    if v2.UserInputType ~= Enum.UserInputType.MouseButton1 and v2.UserInputType ~= Enum.UserInputType.Touch then
        return
    end
    if v1 then
        return
    end
    v1 = true
    MarketplaceService:PromptProductPurchase(LocalPlayer, InfiniteSpeed)
    task.delay(1, function() -- line 13 | captures: v1
        v1 = false
    end)
end)
