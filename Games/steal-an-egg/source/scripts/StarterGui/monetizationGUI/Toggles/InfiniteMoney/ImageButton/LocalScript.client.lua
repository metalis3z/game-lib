-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local MarketplaceService = game:GetService("MarketplaceService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local script_Parent = script.Parent;

if not script_Parent:IsA("GuiButton") then
    script_Parent = script.Parent:FindFirstChild("ImageButton", true);
end;

if not script_Parent then
    return;
end;

script_Parent.MouseButton1Click:Connect(function() -- Line: 10
    -- upvalues: MarketplaceService (copy), LocalPlayer (copy)
    MarketplaceService:PromptProductPurchase(LocalPlayer, 3710829171);
end);