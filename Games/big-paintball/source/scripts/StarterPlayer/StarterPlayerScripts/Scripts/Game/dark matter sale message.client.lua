-- Firebase sez: 404: Not Found (Retrying until success)

local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v1.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
v1.Message.New("\240\159\143\183\239\184\143 Dark Matter guns are 80% for Christmas only! Be sure to check them out. \n\nHappy Holidays! \240\159\152\138");
