-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
v1.Network.Fired("Show Killstreak Msg"):Connect(function(p1)
	game.StarterGui:SetCore("ChatMakeSystemMessage", {
		Text = p1, 
		Color = Color3.fromRGB(255, 0, 0), 
		Font = Enum.Font.SourceSansBold, 
		TextSize = 18
	});
end);
