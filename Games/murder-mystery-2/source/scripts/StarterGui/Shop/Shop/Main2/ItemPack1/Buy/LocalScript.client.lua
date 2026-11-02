-- Decompiled with the Synapse X Luau decompiler.

local l__Parent__1 = script.Parent;
local l__MarketplaceService__1 = game:GetService("MarketplaceService");
local l__LocalPlayer__2 = game.Players.LocalPlayer;
script.Parent.MouseButton1Click:Connect(function()
	l__MarketplaceService__1:PromptGamePassPurchase(l__LocalPlayer__2, 38475789);
end);
