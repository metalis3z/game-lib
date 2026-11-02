-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local MarketplaceService = game:GetService("MarketplaceService");
game:GetService("ReplicatedStorage");
game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local script_Parent = script.Parent;

if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
    script_Parent.Position = UDim2.new(script_Parent.Position.X.Scale, script_Parent.Position.X.Offset, 0.17, script_Parent.Position.Y.Offset);
end;

local ProductId = require(game.ReplicatedStorage.Directory.Gamepasses._Index.AdminPanel).ProductId;
task.spawn(function() -- Line: 17
    -- upvalues: MarketplaceService (copy), ProductId (copy)
    local success, result = pcall(MarketplaceService.GetProductInfo, MarketplaceService, ProductId, Enum.InfoType.GamePass);

    if not success then
        return;
    end;

    script.Parent.Price.Text = result.IsForSale and "" .. tostring(result.PriceInRobux) or "OFF SALE";
end);