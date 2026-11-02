-- Decompiled with the Synapse X Luau decompiler.

local v1 = require(script.Parent);
local v2 = script:FindFirstAncestor("MainUI");
local l__LocalPlayer__3 = game.Players.LocalPlayer;
game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo"):WaitForChild("SystemMessage").OnClientEvent:Connect(function(p1, p2)
	game.TextChatService.TextChannels.RBXSystem:DisplaySystemMessage(p1, p2);
end);
