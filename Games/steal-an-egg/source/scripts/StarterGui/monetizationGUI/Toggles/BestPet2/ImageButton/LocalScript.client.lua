-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local MarketplaceService = game:GetService("MarketplaceService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local ProductId = require(game.ReplicatedStorage.Directory.Products._Index.Offers["Offer 2"]).ProductId;
script.Parent.MouseButton1Click:Connect(function() -- Line: 6
    -- upvalues: MarketplaceService (copy), LocalPlayer (copy), ProductId (copy)
    MarketplaceService:PromptProductPurchase(LocalPlayer, ProductId);
end);