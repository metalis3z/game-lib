-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
v1.Network.Fired("Activate VIP"):Connect(function()
	v1.Message.New("\226\156\133 Your VIP benefits have been activated! Thank you for your support! \240\159\152\138");
end);
