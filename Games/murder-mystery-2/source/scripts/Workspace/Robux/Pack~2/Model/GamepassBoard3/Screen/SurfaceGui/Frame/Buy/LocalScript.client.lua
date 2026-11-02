-- By Rhavi (RhavizinNxtrixz, DON'T ROB MY SCRIPT!)

local Market = game:GetService("MarketplaceService")
local Player = game.Players.LocalPlayer
local Trigger = script.Parent

--// /IDS/ID\ \\--

local Id1 = 14734459897

--// /Functions/Function\ \\--

local function Buy()
	Market:PromptPurchase(Player, Id1)
end

Trigger.MouseButton1Click:Connect(Buy)