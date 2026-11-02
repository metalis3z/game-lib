-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local MarketplaceService = game:GetService("MarketplaceService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local PromptPurchase = require(ReplicatedStorage.Library.Shared.Functions.PromptPurchase);
task.spawn(function() -- Line: 11
    -- upvalues: MarketplaceService (copy)
    local success, result = pcall(MarketplaceService.GetProductInfo, MarketplaceService, 3710829171, Enum.InfoType.Product);

    if not success then
        return;
    end;

    script.Parent.Cost.Cost.Text = result.IsForSale and "" .. tostring(result.PriceInRobux) or "OFF SALE";
end);
script.Parent.ImageButton.Activated:Connect(function() -- Line: 19
    -- upvalues: PromptPurchase (copy)
    PromptPurchase.Prompt(3710829171, true);
end);